Given(/^Workshop Submission Viewed for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @workshop_id = configatron.workshop_id unless configatron.workshop_id == nil
  @workshopSubmissionName = configatron.workshopsubmissionname

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
  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  sleep(5)

  on CourseWorkshopSubmissionPage do |page|
    page.workshop_submission_link(@workshopSubmissionName).click
  end
end

When(/^The Workshop Submission got successfully viewed by instructor$/) do

  on CourseWorkshopSubmissionPage do |page|
    page.submission_title.text.should == @workshopSubmissionName
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Workshop Submission Viewed should get generated and sent to our Raw Event Index\.$/) do
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
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.target.extensions.moduleType\":\"workshop_submission\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['target'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop_submission'$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['extensions']['moduleType'].should == 'workshop_submission'
end
