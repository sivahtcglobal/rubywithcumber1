Given(/^Completed a Lesson for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @lessonId = configatron.lessonId
  @essayAnswer = 'at_essay_answer'+@currnetTimeStamp.to_s
  configatron.essayanswer = @essayAnswer

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

  @browser.goto(configatron.moodleURL+'/mod/lesson/view.php?id='+@lessonId)

  on SubmitAnswersPage do |page|
    page.resume_lesson_link.wait_until_present
    page.resume_lesson_link.click

    page.essay_answer_txt.send_keys @essayAnswer
    @lessonStartTimeStamp = Time.new.to_i * 1000
    page.submit_btn.wait_until_present
    page.submit_btn_clk
    page.continue_btn.click if page.continue_btn.exists?
  end
end

When(/^The Lesson got successfully completed by student$/) do

  on SubmitAnswersPage do |page|
    page.congratulations_txt.wait_until_present
    page.congratulations_txt.text.should == 'Congratulations - end of lesson reached'
  end
  sleep(configatron.eventWaitTime)
  @lessonCompleteTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Complete Lesson should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @lessonStartTimeStamp
  @endTimeStamp = @lessonCompleteTimeStamp

  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Submitted'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson_timer'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'lesson_timer'
end

And(/^\['event'\]\.\['generated'\]\.\['count'\] = 2$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['count'].should == 2
end

Then(/^An Event for Complete Lesson should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 5

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Complete Lesson CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Complete Lesson CSV \['Page'\] Column Value = 'lesson_timer'$/) do
  @latest_record['Page'].should == 'lesson_timer'
end

And(/^Complete Lesson CSV \['Activity Type'\] Column Value = 'lesson'$/) do
  @latest_record['Activity Type'].should == 'lesson'
end

And(/^Complete Lesson CSV \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedlessonname
end

And(/^Complete Lesson CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Complete Lesson should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 5

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Complete Lesson Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Complete Lesson Tableau \['Page'\] Column Value = 'lesson_timer'$/) do
  @newest_record['Page'].should == 'lesson_timer'
end

And(/^Complete Lesson Tableau \['Activity Type'\] Column Value = 'lesson'$/) do
  @newest_record['ActivityType'].should == 'lesson'
end

And(/^Complete Lesson Tableau \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedlessonname
end

And(/^Complete Lesson Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Then(/^An Event for Lesson Question Answered should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @lessonStartTimeStamp
  @endTimeStamp = @lessonCompleteTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Completed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['name'\] = Provided Name$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['name'].should == configatron.essaytitle
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson_question'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'lesson_question'
end

Then(/^An Event for Lesson Question Answered should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 5

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Completed' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Lesson Question Answered CSV \['Action'\] Column Value = 'Completed'$/) do
  @latest_record['Action'].should == 'Completed'
end

And(/^Lesson Question Answered CSV \['Page'\] Column Value = 'lesson_question'$/) do
  @latest_record['Page'].should == 'lesson_question'
end

And(/^Lesson Question Answered CSV \['Activity Type'\] Column Value = 'lesson'$/) do
  @latest_record['Activity Type'].should == 'lesson'
end

And(/^Lesson Question Answered CSV \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedlessonname
end

And(/^Lesson Question Answered CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Lesson Question Answered should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 5

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Completed' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Lesson Question Answered Tableau \['Action'\] Column Value = 'Completed'$/) do
  @newest_record['Action'].should == 'Completed'
end

And(/^Lesson Question Answered Tableau \['Page'\] Column Value = 'lesson_question'$/) do
  @newest_record['Page'].should == 'lesson_question'
end

And(/^Lesson Question Answered Tableau \['Activity Type'\] Column Value = 'lesson'$/) do
  @newest_record['ActivityType'].should == 'lesson'
end

And(/^Lesson Question Answered Tableau \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedlessonname
end

And(/^Lesson Question Answered Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
