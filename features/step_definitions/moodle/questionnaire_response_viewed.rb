Given(/^Student View the Questionnaire Response$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @questionnaireId = configatron.questionnaire_id

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

  @browser.goto(configatron.moodleURL+'/mod/questionnaire/view.php?id='+@questionnaireId)
  sleep(5)

  on SubmitAnswersPage do |page|
    @questionnaireResponseViewedStartTimeStamp = Time.new.to_i * 1000
    sleep(5)
    page.your_response_link.click
    sleep(5)
    @questionnaireResponseViewedEndTimeStamp = Time.new.to_i * 1000
  end
end

When(/^The Questionnaire Response got successfully viewed by the Student$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == 'Your response'
  end
  moodle_logout
end

Then(/^An Event for Student Questionnaire Response Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @questionnaireResponseViewedStartTimeStamp
  @endTimeStamp = @questionnaireResponseViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Given(/^Instructor View the Questionnaire Responses$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @questionnaireId = configatron.questionnaire_id

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

  @browser.goto(configatron.moodleURL+'/mod/questionnaire/view.php?id='+@questionnaireId)
  sleep(5)

  on SubmitAnswersPage do |page|
    @questionnaireAllResponsesViewedStartTimeStamp = Time.new.to_i * 1000
    sleep(5)
    page.view_all_responses_link.click
    sleep(5)
    @questionnaireAllResponsesViewedEndTimeStamp = Time.new.to_i * 1000
  end
end

When(/^The Questionnaire Responses got successfully viewed by the Instructor$/) do
  on SubmitAnswersPage do |page|
    page.all_responses_breadcrumb.text.should == 'View All Responses'
  end
  moodle_logout
end

Then(/^An Event for Instructor Questionnaire Responses Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @questionnaireAllResponsesViewedStartTimeStamp
  @endTimeStamp = @questionnaireAllResponsesViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'questionnaire_all_responses'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'questionnaire_all_responses'
end
