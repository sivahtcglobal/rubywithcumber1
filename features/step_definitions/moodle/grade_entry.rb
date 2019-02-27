Given(/^Submit Grade Entry for Database Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Submit a New Grade Entry for Database for #{@courseId}"
  @databaseName = configatron.databasename unless configatron.databasename == nil
  @database_id = configatron.database_id unless configatron.database_id == nil
  @database_entry_id = configatron.database_entry_id unless configatron.database_entry_id == nil
  @entryName = configatron.entryname unless configatron.entryname == nil

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoTeacherUsername
      @password = configatron.autoTeacherPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Teacher.exists? && page.automation_site_Teacher.text.include?(configatron.autoTeacherUsername))
  end
  @browser.goto(configatron.moodleURL+'/mod/data/view.php?id=' + @database_id.to_s)
  @currnetTimeStamp = Time.new.to_i * 1000
  on CourseDatabasGradeEntryePage do |page|
    page.view_single_link.wait_until_present
    page.view_single_link.click
    page.next_link.click
    page.avg_rating_select.select '9'

  end
end

When(/^The New Grade Entry for Database Page Got successfully submitted$/) do

  on CourseDatabasGradeEntryePage do |page|
    page.rating_verify.wait_until_present
    page.rating_verify.text.should == '9'
    page.view_list_link.click
    page.view_single_link.click
    page.next_link.click
    page.rating_verify.text.should == '9'
  end
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for New Grade Entry for Database Page should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp


  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"


  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  puts @response
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'data'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['extensions']['moduleType'].should == 'data'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Database Entry Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 10
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Database Entry Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 1.16
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Database Entry Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 90
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Database Entry Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 1.31
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'data'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'data'
end

And(/^\['event'\]\.\['generated'\]\.\['totalScore'\] = Graded Database Entry Score$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == 9
end
