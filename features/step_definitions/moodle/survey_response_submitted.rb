Given(/^Survey Response Submitted by Instructor$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @surveyId = configatron.survey_id

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

  @surveyInstructorResponse =  'at_survey_instructor_response'+@currnetTimeStamp.to_s

  @browser.goto(configatron.moodleURL+'/mod/survey/view.php?id='+@surveyId)

  on SurveyResponsePage do |page|
    sleep(3)
    page.survey_question_1.send_keys [:control, 'a']
    page.survey_question_1.send_keys @surveyInstructorResponse
    page.survey_question_2.send_keys [:control, 'a']
    page.survey_question_2.send_keys @surveyInstructorResponse
    page.survey_question_3.send_keys [:control, 'a']
    page.survey_question_3.send_keys @surveyInstructorResponse
    page.survey_question_4.send_keys [:control, 'a']
    page.survey_question_4.send_keys @surveyInstructorResponse
    page.survey_question_5.send_keys [:control, 'a']
    page.survey_question_5.send_keys @surveyInstructorResponse
    page.continue_btn_clk
  end
end

When(/^The Survey Response got successfully submitted by Instructor$/) do

  on SurveyResponsePage do |page|
    page.survey_confirmation_msg.text.should == "Thanks for answering this survey, #{configatron.autoTeacherUsername}_fname"
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Instructor Response Submitted should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 5
end

And(/^\['event'\]\.\['object'\]\.\['@id'\] = Survey Id$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@id'].include? "#{configatron.survey_id}"
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'survey'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'survey'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'survey_response'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'survey_response'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'survey'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'survey'
end

Given(/^Survey Response Submitted by Student$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @surveyId = configatron.survey_id

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

  @surveyStudentResponse =  'at_survey_student_response'+@currnetTimeStamp.to_s

  @browser.goto(configatron.moodleURL+'/mod/survey/view.php?id='+@surveyId)

  on SurveyResponsePage do |page|
    sleep(3)
    page.survey_question_1.send_keys [:control, 'a']
    page.survey_question_1.send_keys @surveyStudentResponse
    page.survey_question_2.send_keys [:control, 'a']
    page.survey_question_2.send_keys @surveyStudentResponse
    page.survey_question_3.send_keys [:control, 'a']
    page.survey_question_3.send_keys @surveyStudentResponse
    page.survey_question_4.send_keys [:control, 'a']
    page.survey_question_4.send_keys @surveyStudentResponse
    page.survey_question_5.send_keys [:control, 'a']
    page.survey_question_5.send_keys @surveyStudentResponse
    page.continue_btn_clk
  end
end

When(/^The Survey Response got successfully submitted by Student$/) do

  on SurveyResponsePage do |page|
    page.survey_confirmation_msg.text.should == "Thanks for answering this survey, #{configatron.autoStudentUsername}_fname"
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Student Response Submitted should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 5
end

Then(/^An Event for Student Response Submitted should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Student Response Submitted CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Student Response Submitted CSV \['Page'\] Column Value = 'survey_response'$/) do
  @latest_record['Page'].should == 'survey_response'
end

And(/^Student Response Submitted CSV \['Activity Type'\] Column Value = 'survey'$/) do
  @latest_record['Activity Type'].should == 'survey'
end

And(/^Student Response Submitted CSV \['Activity Name'\] Column Value = Provided Survey Name$/) do
  @latest_record['Activity Name'].should == configatron.surveynameupdated
end

And(/^Student Response Submitted CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Student Response Submitted should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Student Response Submitted Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Student Response Submitted Tableau \['Page'\] Column Value = 'survey_response'$/) do
  @newest_record['Page'].should == 'survey_response'
end

And(/^Student Response Submitted Tableau \['Activity Type'\] Column Value = 'survey'$/) do
  @newest_record['ActivityType'].should == 'survey'
end

And(/^Student Response Submitted Tableau \['Activity Name'\] Column Value = Provided Survey Name$/) do
  @newest_record['ActivityName'].should == configatron.surveynameupdated
end

And(/^Student Response Submitted Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
