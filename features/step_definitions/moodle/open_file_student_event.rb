Given(/^Opened a File for a course$/) do
  @fileId = configatron.file_id
  @fileName = configatron.filename

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoStudentUsername
      @password = configatron.autoStudentPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Student.exists? && page.automation_site_Student.text.include?(configatron.autoStudentUsername))
  end

  sleep(10)
  @openFileStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/resource/view.php?id='+@fileId)
end

When(/^The File got successfully opened$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.include? @fileName
  end
  sleep(10)
  @openFileEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Open File should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @openFileStartTimeStamp
  @endTimeStamp = @openFileEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'resource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'resource'
end

And(/^\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Document'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Document'
end
