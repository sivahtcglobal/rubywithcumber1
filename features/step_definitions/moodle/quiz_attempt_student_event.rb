Given(/^Started a Quiz Attempt for a course$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  @quizId = configatron.quizId
  @quizName = configatron.updatedquizname

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

  @browser.goto(configatron.moodleURL+'/mod/quiz/view.php?id='+@quizId)

  @startQuizAttemptStartTimeStamp = Time.new.to_i * 1000
  sleep(20)
  on QuizAttemptPage do |page|
    #Need to wait for a static element
    page.attempt_quiz_btn_clk if page.attempt_quiz_btn.exists?
    page.attempt_quiz_button_clk if page.attempt_quiz_button.exists?
    sleep(3)
    page.start_attempt_btn_clk if page.start_attempt_btn.exists?
  end
end

When(/^The Quiz Attempt got successfully started by student$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.wait_until_present
    page.course_item_breadcrumb.text.include? @quizName
  end
  configatron.attemptId = get_item_id()
  sleep(configatron.eventWaitTime)
  @startQuizAttemptEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Quiz Attempt Started should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @startQuizAttemptStartTimeStamp
  @endTimeStamp = @startQuizAttemptEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Started\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'quiz'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'quiz'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'quiz_attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'quiz_attempt'
end

Then(/^An Event for Quiz Attempt Started should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 2

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Started' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Quiz Attempt Started CSV \['Action'\] Column Value = 'Started'$/) do
  @latest_record['Action'].should == 'Started'
end

And(/^Quiz Attempt Started CSV \['Page'\] Column Value = 'quiz_attempt'$/) do
  @latest_record['Page'].should == 'quiz_attempt'
end

And(/^Quiz Attempt Started CSV \['Activity Type'\] Column Value = 'quiz'$/) do
  @latest_record['Activity Type'].should == 'quiz'
end

And(/^Quiz Attempt Started CSV \['Activity Name'\] Column Value = Provided Quiz Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedquizname
end

And(/^Quiz Attempt Started CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Quiz Attempt Started should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 2

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Started' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Quiz Attempt Started Tableau \['Action'\] Column Value = 'Started'$/) do
  @newest_record['Action'].should == 'Started'
end

And(/^Quiz Attempt Started Tableau \['Page'\] Column Value = 'quiz_attempt'$/) do
  @newest_record['Page'].should == 'quiz_attempt'
end

And(/^Quiz Attempt Started Tableau \['Activity Type'\] Column Value = 'quiz'$/) do
  @newest_record['ActivityType'].should == 'quiz'
end

And(/^Quiz Attempt Started Tableau \['Activity Name'\] Column Value = Provided Quiz Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedquizname
end

And(/^Quiz Attempt Started Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Given(/^Submitted a Quiz Attempt for a course$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  @quizId = configatron.quizId
  @quizName = configatron.quizName
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  @browser.goto(configatron.moodleURL+'/mod/quiz/attempt.php?attempt='+configatron.attemptId)
  sleep(10)
  @submitQuizAttemptStartTimeStamp = Time.new.to_i * 1000

  on QuizAttemptPage do |page|
    page.select_answer_radio.wait_until_present
    page.select_answer_radio.click
    page.finish_attempt_btn_clk
    page.submit_all_and_finish_btn_clk if page.submit_all_and_finish_btn.exists?
    page.submit_all_and_finish_button_clk if page.submit_all_and_finish_button.exists?
    sleep(3)
    page.confirm_submit_all_and_finish_btn_clk if page.confirm_submit_all_and_finish_btn.exists?
  end
end

When(/^The Quiz Attempt got successfully submitted by student$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.include? @quizName
  end
  sleep(configatron.eventWaitTime)
  @submitQuizAttemptEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Quiz Attempt Submitted should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @submitQuizAttemptStartTimeStamp
  @endTimeStamp = @submitQuizAttemptEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":3,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Then(/^An Event for Quiz Attempt Submitted should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 4

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Quiz Attempt Submitted CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Quiz Attempt Submitted CSV \['Page'\] Column Value = 'quiz_attempt'$/) do
  @latest_record['Page'].should == 'quiz_attempt'
end

And(/^Quiz Attempt Submitted CSV \['Activity Type'\] Column Value = 'quiz'$/) do
  @latest_record['Activity Type'].should == 'quiz'
end

And(/^Quiz Attempt Submitted CSV \['Activity Name'\] Column Value = Provided Quiz Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedquizname
end

And(/^Quiz Attempt Submitted CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Quiz Attempt Submitted should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 4

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Quiz Attempt Submitted Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Quiz Attempt Submitted Tableau \['Page'\] Column Value = 'quiz_attempt'$/) do
  @newest_record['Page'].should == 'quiz_attempt'
end

And(/^Quiz Attempt Submitted Tableau \['Activity Type'\] Column Value = 'quiz'$/) do
  @newest_record['ActivityType'].should == 'quiz'
end

And(/^Quiz Attempt Submitted Tableau \['Activity Name'\] Column Value = Provided Quiz Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedquizname
end

And(/^Quiz Attempt Submitted Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
