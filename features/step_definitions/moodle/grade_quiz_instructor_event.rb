Given(/^Quiz Submission CSV Record Counts before Sending Event$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleQuizSubmissionReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @beforeQuizSubmissionEventSend = JSON.parse(@response)
  puts @beforeQuizSubmissionEventSend.count
end

Given(/^Quiz Submission Tableau Record Counts before Sending Event$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleQuizSubmissionReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @beforeQuizSubmissionSend = post_request(@posturl,@query,@apitoken)
  puts @beforeQuizSubmissionSend['data'].length
end

Given(/^Graded a Quiz under a course$/) do
  #Grade a Quiz by teacher
  @courseId = configatron.courseId
  @quizId = configatron.quizId
  @attemptId = configatron.attemptId

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

  sleep(10)
  @gradeQuizStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/grade/report/grader/index.php?id='+@courseId)

  on GradeReportPage do |page|
    page.grades_menu_link.click
    page.single_view_link.click
    page.override_chkbox.click

    page.grade_txt.click
    page.grade_txt.send_keys [:control, 'a']
    page.grade_txt.send_keys '8'

    @browser.execute_script('arguments[0].scrollIntoView();', page.grade_txt)
    page.grade_save_btn_clk
  end
end

When(/^The Quiz got successfully graded$/) do

  on GradeReportPage do |page|
    page.grade_alert_msg.text.include? ('Grades were set for 1 items')
    page.grade_alert_continue_btn_clk if page.grade_alert_continue_btn.exists?
    page.grade_continue_btn_clk if page.grade_continue_btn.exists?
  end
  sleep(10)
  @gradeQuizEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for grade quiz should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @gradeQuizStartTimeStamp
  @endTimeStamp = @gradeQuizEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'quiz_attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'quiz_attempt'
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'quiz'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['extensions']['moduleType'].should == 'quiz'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Quiz Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 10
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Quiz Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 4.88
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Quiz Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 80
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Quiz Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 3.9
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'quiz'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'quiz'
end

And(/^\['event'\]\.\['generated'\]\.\['totalScore'\] = Graded Quiz Score$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == 8
end

Then(/^An Event for Grade Quiz should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Graded' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Grade Quiz CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Grade Quiz CSV \['Page'\] Column Value = 'quiz'$/) do
  @latest_record['Page'].should == 'quiz'
end

And(/^Grade Quiz CSV \['Activity Type'\] Column Value = 'quiz'$/) do
  @latest_record['Activity Type'].should == 'quiz'
end

And(/^Grade Quiz CSV \['Activity Name'\] Column Value = Provided Quiz Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedquizname
end

And(/^Grade Quiz CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Grade Quiz CSV \['Score'\] Column Value = Graded Quiz Score$/) do
  @latest_record['Score'].should == '8'
end

And(/^Grade Quiz CSV \['Max Score'\] Column Value = Provided Quiz Max Grade$/) do
  @latest_record['Max Score'].should == '10'
end

And(/^Grade Quiz CSV \['Score\(Percent\)'\] Column Value = Provided Quiz Percentage$/) do
  @latest_record['Score (Percent)'].should == '80'
end

Then(/^An Event for Grade Quiz should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Graded' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Grade Quiz Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Grade Quiz Tableau \['Page'\] Column Value = 'quiz'$/) do
  @newest_record['Page'].should == 'quiz'
end

And(/^Grade Quiz Tableau \['Activity Type'\] Column Value = 'quiz'$/) do
  @newest_record['ActivityType'].should == 'quiz'
end

And(/^Grade Quiz Tableau \['Activity Name'\] Column Value = Provided Quiz Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedquizname
end

And(/^Grade Quiz Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Grade Quiz Tableau \['Score'\] Column Value = Graded Quiz Score$/) do
  @newest_record['Score'].should == 8
end

And(/^Grade Quiz Tableau \['Max Score'\] Column Value = Provided Quiz Max Grade$/) do
  @newest_record['MaxScore'].should == 10
end

And(/^Grade Quiz Tableau \['Score\(Percent\)'\] Column Value = Provided Quiz Percentage$/) do
  @newest_record['Score_Percent_'].should == 80
end

Then(/^An Event for Quiz Submission should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleQuizSubmissionReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterQuizSubmissionEventSend = JSON.parse(@response)
  puts @afterQuizSubmissionEventSend.count

  @afterQuizSubmissionEventSend.count.should == @beforeQuizSubmissionEventSend.count + 1

  @all_csv_records = @afterQuizSubmissionEventSend.to_a.find_all { |value| value['Action']=='http://purl.imsglobal.org/vocab/caliper/v1/action#Graded' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldQuizSubmissionReport}"] }.last
  puts @latest_record
end

And(/^Quiz Submission CSV \['Student Display Name'\] Column Value = Student Display Name$/) do
  @latest_record['Student Display Name'].should == "#{configatron.autoStudentUsername}_lname,#{configatron.autoStudentUsername}_fname"
end

And(/^Quiz Submission CSV \['Student Name'\] Column Value = Student Name$/) do
  @latest_record['Student Name'].should == "#{configatron.autoStudentUsername}_fname #{configatron.autoStudentUsername}_lname"
end

And(/^Quiz Submission CSV \['Role'\] Column Value = Provided Role$/) do
  @latest_record['Role'].should == 'http://purl.imsglobal.org/vocab/lis/v2/membership#Learner'
end

And(/^Quiz Submission CSV \['Course ID'\] Column Value = Course ID$/) do
  @latest_record['Course ID'].include? configatron.courseId
end

And(/^Quiz Submission CSV \['Course Name'\] Column Value = Course Name$/) do
  @latest_record['Course Name'].should == configatron.courseName
end

And(/^Quiz Submission CSV \['Action'\] Column Value = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Graded'$/) do
  @latest_record['Action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
end

And(/^Quiz Submission CSV \['Page'\] Column Value = 'quiz'$/) do
  @latest_record['Page'].should == 'quiz'
end

And(/^Quiz Submission CSV \['Activity Type'\] Column Value = 'quiz'$/) do
  @latest_record['Activity Type'].should == 'quiz'
end

And(/^Quiz Submission CSV \['Activity Name'\] Column Value = Quiz Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedquizname
end

And(/^Quiz Submission CSV \['Activity ID'\] Column Value = Quiz ID$/) do
  @latest_record['Activity ID'].include? configatron.quizId
end

And(/^Quiz Submission CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Quiz Submission CSV \['Score'\] Column Value = Provided Score$/) do
  @latest_record['Score'].should == '8'
end

And(/^Quiz Submission CSV \['Max Score'\] Column Value = Provided Max Score$/) do
  @latest_record['Max Score'].should == '10'
end

And(/^Quiz Submission CSV \['Score \(Percent\)'\] Column Value = Score Percentage$/) do
  @latest_record['Score (Percent)'].should == '80'
end

And(/^Quiz Submission CSV \['Weight'\] Column Value = Weight$/) do
  @latest_record['Weight'].should == '4.88'
end

And(/^Quiz Submission CSV \['Attempt ID'\] Column Value = Attempt ID$/) do
  @latest_record['Attempt ID'].include? configatron.attemptId
end

And(/^Quiz Submission CSV \['Open Quiz Date'\] Column Value = Provided Open Quiz Date$/) do
  Time.at((@latest_record['Open Quiz Date'].to_i)/1000).to_s.include? '2017-04-03'
end

And(/^Quiz Submission CSV \['Close Quiz Date'\] Column Value = Provided Close Quiz Date$/) do
  Time.at((@latest_record['Close Quiz Date'].to_i)/1000).to_s.include? '2018-11-28'
end

And(/^Quiz Submission CSV \['Completion Tracking'\] Column Value = true$/) do
  @latest_record['Completion Tracking'].should == 'T'
end

And(/^Quiz Submission CSV \['Contribution To Course Total'\] Column Value = Contribution To Course Total$/) do
  @latest_record['Contribution To Course Total'].should == '3.9'
end

And(/^Quiz Submission CSV \['Count'\] Column Value = '1'$/) do
  @latest_record['Count'].should == '1'
end

And(/^Quiz Submission CSV \['Time Limit'\] Column Value = Provided Time Limit$/) do
  @latest_record['Time Limit'].should == 'PT172800S'
end

And(/^Quiz Submission CSV \['Grace Period'\] Column Value = Provided Grace Period$/) do
  @latest_record['Grace Period'].should == 'PT86400S'
end

And(/^Quiz Submission CSV \['Overdue Handling'\] Column Value = Provided Overdue Handling$/) do
  @latest_record['Overdue Handling'].should == 'graceperiod'
end

And(/^Quiz Submission CSV \['Restrictions'\] Column Value = false$/) do
  @latest_record['Restrictions'].should == 'F'
end

And(/^Quiz Submission CSV \['Tags'\] Column Value = Provided Tags$/) do
  @latest_record['Tags'].should == 'Auto tag 1'
end

And(/^Quiz Submission CSV \['Require View'\] Column Value = false$/) do
  @latest_record['Require View'].should == 'F'
end

And(/^Quiz Submission CSV \['Require Grade'\] Column Value = false$/) do
  @latest_record['Require Grade'].should == 'F'
end

And(/^Quiz Submission CSV \['Grade Method'\] Column Value = 'first_attempt'$/) do
  @latest_record['Grade Method'].should == 'first_attempt'
end

And(/^Quiz Submission CSV \['Grade To Pass'\] Column Value = Provided Grade To Pass$/) do
  @latest_record['Grade To Pass'].should == '6'
end

Then(/^An Event for Quiz Submission should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleQuizSubmissionReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterQuizSubmissionSend = post_request(@posturl,@query,@apitoken)
  puts @afterQuizSubmissionSend['data'].length

  @afterQuizSubmissionSend['data'].length.should == @beforeQuizSubmissionSend['data'].length + 1

  @all_tableau_records = @afterQuizSubmissionSend['data'].find_all { |value| value['Action']=='http://purl.imsglobal.org/vocab/caliper/v1/action#Graded' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldQuizSubmissionReportTableau}"] }.last
  puts @newest_record
end

And(/^Quiz Submission Tableau \['Student Display Name'\] Column Value = Student Display Name$/) do
  @newest_record['StudentDisplayName'].should == "#{configatron.autoStudentUsername}_lname,#{configatron.autoStudentUsername}_fname"
end

And(/^Quiz Submission Tableau \['Student Name'\] Column Value = Student Name$/) do
  @newest_record['StudentName'].should == "#{configatron.autoStudentUsername}_fname #{configatron.autoStudentUsername}_lname"
end

And(/^Quiz Submission Tableau \['Role'\] Column Value = Provided Role$/) do
  @newest_record['Role'].should == 'http://purl.imsglobal.org/vocab/lis/v2/membership#Learner'
end

And(/^Quiz Submission Tableau \['Course ID'\] Column Value = Course ID$/) do
  @newest_record['CourseID'].include? configatron.courseId
end

And(/^Quiz Submission Tableau \['Course Name'\] Column Value = Course Name$/) do
  @newest_record['CourseName'].should == configatron.courseName
end

And(/^Quiz Submission Tableau \['Action'\] Column Value = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Graded'$/) do
  @newest_record['Action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
end

And(/^Quiz Submission Tableau \['Page'\] Column Value = 'quiz'$/) do
  @newest_record['Page'].should == 'quiz'
end

And(/^Quiz Submission Tableau \['Activity Type'\] Column Value = 'quiz'$/) do
  @newest_record['ActivityType'].should == 'quiz'
end

And(/^Quiz Submission Tableau \['Activity Name'\] Column Value = Quiz Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedquizname
end

And(/^Quiz Submission Tableau \['Activity ID'\] Column Value = Quiz ID$/) do
  @newest_record['ActivityID'].include? configatron.quizId
end

And(/^Quiz Submission Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Quiz Submission Tableau \['Score'\] Column Value = Provided Score$/) do
  @newest_record['Score'].should == 8
end

And(/^Quiz Submission Tableau \['Max Score'\] Column Value = Provided Max Score$/) do
  @newest_record['MaxScore'].should == 10
end

And(/^Quiz Submission Tableau \['Score \(Percent\)'\] Column Value = Score Percentage$/) do
  @newest_record['Score_Percent_'].should == 80
end

And(/^Quiz Submission Tableau \['Weight'\] Column Value = Weight$/) do
  @newest_record['Weight'].should == 4.88
end

And(/^Quiz Submission Tableau \['Attempt ID'\] Column Value = Attempt ID$/) do
  @newest_record['AttemptID'].include? configatron.attemptId
end

And(/^Quiz Submission Tableau \['Open Quiz Date'\] Column Value = Provided Open Quiz Date$/) do
  Time.at((@newest_record['OpenQuizDate'].to_i)/1000).to_s.include? '2017-04-03'
end

And(/^Quiz Submission Tableau \['Close Quiz Date'\] Column Value = Provided Close Quiz Date$/) do
  Time.at((@newest_record['CloseQuizDate'].to_i)/1000).to_s.include? '2018-11-28'
end

And(/^Quiz Submission Tableau \['Completion Tracking'\] Column Value = true$/) do
  @newest_record['CompletionTracking'].should == 'T'
end

And(/^Quiz Submission Tableau \['Contribution To Course Total'\] Column Value = Contribution To Course Total$/) do
  @newest_record['ContributionToCourseTotal'].should == 3.9
end

And(/^Quiz Submission Tableau \['Count'\] Column Value = '1'$/) do
  @newest_record['Count'].should == 1
end

And(/^Quiz Submission Tableau \['Time Limit'\] Column Value = Provided Time Limit$/) do
  @newest_record['TimeLimit'].should == 'PT172800S'
end

And(/^Quiz Submission Tableau \['Grace Period'\] Column Value = Provided Grace Period$/) do
  @newest_record['GracePeriod'].should == 'PT86400S'
end

And(/^Quiz Submission Tableau \['Overdue Handling'\] Column Value = Provided Overdue Handling$/) do
  @newest_record['OverdueHandling'].should == 'graceperiod'
end

And(/^Quiz Submission Tableau \['Restrictions'\] Column Value = false$/) do
  @newest_record['Restrictions'].should == 'F'
end

And(/^Quiz Submission Tableau \['Tags'\] Column Value = Provided Tags$/) do
  @newest_record['Tags'].should == 'Auto tag 1'
end

And(/^Quiz Submission Tableau \['Require View'\] Column Value = false$/) do
  @newest_record['RequireView'].should == 'F'
end

And(/^Quiz Submission Tableau \['Require Grade'\] Column Value = false$/) do
  @newest_record['RequireGrade'].should == 'F'
end

And(/^Quiz Submission Tableau \['Grade Method'\] Column Value = 'first_attempt'$/) do
  @newest_record['GradeMethod'].should == 'first_attempt'
end

And(/^Quiz Submission Tableau \['Grade To Pass'\] Column Value = Provided Grade To Pass$/) do
  @newest_record['GradeToPass'].should == 6
end
