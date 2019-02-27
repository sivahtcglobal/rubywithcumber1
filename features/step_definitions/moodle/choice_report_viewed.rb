Given(/^Instructor View the Choice Report$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @choiceId = configatron.choice_id
  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @browser.goto(configatron.moodleURL+'/mod/choice/view.php?id='+@choiceId)

  on AnswerAChoicePage do |page|
    page.view_choice_responses_link.wait_until_present
    @instructorChoiceReportViewedStartTimeStamp = Time.new.to_i * 1000
    page.view_choice_responses_link.click
    sleep(5)
    @instructorChoiceReportViewedEndTimeStamp = Time.new.to_i * 1000

  end
end

When(/^The Choice Report got successfully viewed by the Instructor$/) do

  on CourseItemPage do |page|
    page.choice_responses_txt.text.include? 'Responses'
  end
  moodle_logout
end

Then(/^An Event for Instructor Choice Report Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @instructorChoiceReportViewedStartTimeStamp
  @endTimeStamp = @instructorChoiceReportViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'choice_report'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'choice_report'
end
