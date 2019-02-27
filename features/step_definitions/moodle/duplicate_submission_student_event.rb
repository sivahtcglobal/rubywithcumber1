Given(/^Duplicate Submission for a assignment as a Student$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @assignmentId = configatron.assignmentId

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

  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id='+@assignmentId)


  on AssignmentViewPage do |page|
    page.duplicate_submission_btn.wait_until_present
    @duplicateSubmissionStartTimeStamp = Time.new.to_i * 1000
    page.duplicate_submission_btn.click
    sleep(configatron.eventWaitTime)
    @duplicateSubmissionEndTimeStamp = Time.new.to_i * 1000

  end
end

When(/^Submission got successfully duplicated by the Student$/) do
  on AssignmentViewPage do |page|
    page.breadcrumb_edit_submission.wait_until_present
    page.breadcrumb_edit_submission.text.include? 'Edit submission'
  end
  moodle_logout
end

Then(/^Duplicated Submission event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @duplicateSubmissionStartTimeStamp
  @endTimeStamp = @duplicateSubmissionEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Duplicated\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Duplicated'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Duplicated'
end
