Given(/^Resume a Questionnaire Attempt as a Student$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @questionnaireId = configatron.questionnaire_id
  @questionnaireName = configatron.questionnairename

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

  on SubmitAnswersPage do |page|
    sleep(5)
    page.answer_the_questions_link.click
    page.selected_answer_radio.click
    page.next_page_btn_clk
    moodle_logout
    @username = configatron.autoStudentUsername
    @password = configatron.autoStudentPassword
    log_in_moodle(@username,@password)
    @browser.goto(configatron.moodleURL+'/mod/questionnaire/view.php?id='+@questionnaireId)
    sleep(20)
    @resumeQuestionnaireAttemptStartTimeStamp = Time.new.to_i * 1000
    page.resume_questionnaire_link.click
  end

end

When(/^Questionnaire attempt resumed successfully by the Student$/) do

  on CourseItemPage do |page|
    page.questionnaire_txt.text.should == @questionnaireName
  end
  sleep(30)
  @resumeQuestionnaireAttemptEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^Resume a Questionnaire attempt event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @resumeQuestionnaireAttemptStartTimeStamp
  @endTimeStamp = @resumeQuestionnaireAttemptEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Resumed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'questionnaire_response'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'questionnaire_response'
end

Then(/^An Event for Questionnaire Attempt Resumed should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Resumed' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Questionnaire Attempt Resumed CSV \['Action'\] Column Value = 'Resumed'$/) do
  @latest_record['Action'].should == 'Resumed'
end

And(/^Questionnaire Attempt Resumed CSV \['Page'\] Column Value = 'questionnaire_response'$/) do
  @latest_record['Page'].should == 'questionnaire_response'
end

And(/^Questionnaire Attempt Resumed CSV \['Activity Type'\] Column Value = 'questionnaire'$/) do
  @latest_record['Activity Type'].should == 'questionnaire'
end

And(/^Questionnaire Attempt Resumed CSV \['Activity Name'\] Column Value = Provided Questionnaire Name$/) do
  @latest_record['Activity Name'].should == configatron.questionnairename
end

And(/^Questionnaire Attempt Resumed CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Questionnaire Attempt Resumed should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Resumed' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Questionnaire Attempt Resumed Tableau \['Action'\] Column Value = 'Resumed'$/) do
  @newest_record['Action'].should == 'Resumed'
end

And(/^Questionnaire Attempt Resumed Tableau \['Page'\] Column Value = 'questionnaire_response'$/) do
  @newest_record['Page'].should == 'questionnaire_response'
end

And(/^Questionnaire Attempt Resumed Tableau \['Activity Type'\] Column Value = 'questionnaire'$/) do
  @newest_record['ActivityType'].should == 'questionnaire'
end

And(/^Questionnaire Attempt Resumed Tableau \['Activity Name'\] Column Value = Provided Questionnaire Name$/) do
  @newest_record['ActivityName'].should == configatron.questionnairename
end

And(/^Questionnaire Attempt Resumed Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Given(/^Submit a Questionnaire as a Student$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @questionnaireId = configatron.questionnaire_id
  @questionnaireName = configatron.questionnairename

  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)

  sleep(20)
  @browser.goto(configatron.moodleURL+'/mod/questionnaire/view.php?id='+@questionnaireId)

  on SubmitAnswersPage do |page|
    page.resume_questionnaire_link.click
    page.selected_answer_radio.click
    page.next_page_btn_clk
    sleep(20)
    @submitQuestionnaireStartTimeStamp = Time.new.to_i * 1000
    page.submit_questionnaire_btn_clk
    page.questionnaire_continue_btn_clk
  end

end

When(/^Questionnaire got submitted successfully by the Student$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @questionnaireName
  end
  sleep(30)
  @submitQuestionnaireEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^Submit a Questionnaire event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @submitQuestionnaireStartTimeStamp
  @endTimeStamp = @submitQuestionnaireEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'questionnaire'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'questionnaire'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'questionnaire'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'questionnaire'
end

Then(/^An Event for Submit a Questionnaire should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 3

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Submit Questionnaire CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Submit Questionnaire CSV \['Page'\] Column Value = 'questionnaire_response'$/) do
  @latest_record['Page'].should == 'questionnaire_response'
end

And(/^Submit Questionnaire CSV \['Activity Type'\] Column Value = 'questionnaire'$/) do
  @latest_record['Activity Type'].should == 'questionnaire'
end

And(/^Submit Questionnaire CSV \['Activity Name'\] Column Value = Provided Questionnaire Name$/) do
  @latest_record['Activity Name'].should == configatron.questionnairename
end

And(/^Submit Questionnaire CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Submit a Questionnaire should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 3

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Submit Questionnaire Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Submit Questionnaire Tableau \['Page'\] Column Value = 'questionnaire_response'$/) do
  @newest_record['Page'].should == 'questionnaire_response'
end

And(/^Submit Questionnaire Tableau \['Activity Type'\] Column Value = 'questionnaire'$/) do
  @newest_record['ActivityType'].should == 'questionnaire'
end

And(/^Submit Questionnaire Tableau \['Activity Name'\] Column Value = Provided Questionnaire Name$/) do
  @newest_record['ActivityName'].should == configatron.questionnairename
end

And(/^Submit Questionnaire Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
