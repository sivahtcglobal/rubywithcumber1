Given(/^Instructor View the Survey Report$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @surveyId = configatron.survey_id
  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @browser.goto(configatron.moodleURL+'/mod/survey/view.php?id='+@surveyId)

  on SurveyResponsePage do |page|
    sleep(5)
    @instructorSurveyReportViewedStartTimeStamp = Time.new.to_i * 1000
    page.view_survey_responses_link.click
    sleep(5)
    @instructorSurveyReportViewedEndTimeStamp = Time.new.to_i * 1000
    sleep(5)
  end
end

When(/^The Survey Report got successfully viewed by the Instructor$/) do

  on CourseItemPage do |page|
    page.survey_report_txt.text.include? 'Survey report'
  end
  moodle_logout
end

Then(/^An Event for Instructor Survey Report Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @instructorSurveyReportViewedStartTimeStamp
  @endTimeStamp = @instructorSurveyReportViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'survey_report'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'survey_report'
end
