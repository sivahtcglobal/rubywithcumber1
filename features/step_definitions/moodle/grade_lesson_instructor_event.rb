Given(/^Graded a Lesson under a course$/) do
  #Grade a Lesson by teacher
  @courseId = configatron.courseId
  @lessonId = configatron.lessonId

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

  @gradeLessonStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/grade/report/grader/index.php?id='+@courseId)

  on GradeReportPage do |page|
    page.grades_menu_link.wait_until_present
    page.grades_menu_link.click
    page.single_view_link.click
    page.override_chkbox.click

    page.grade_txt.click
    page.grade_txt.send_keys [:control, 'a']
    page.grade_txt.send_keys '70'

    @browser.execute_script('arguments[0].scrollIntoView();', page.grade_txt)
    page.grade_save_btn_clk
  end
end

When(/^The Lesson got successfully graded$/) do

  on GradeReportPage do |page|
    page.grade_alert_msg.text.include? ('Grades were set for 1 items')
    page.grade_alert_continue_btn_clk if page.grade_alert_continue_btn.exists?
    page.grade_continue_btn_clk if page.grade_continue_btn.exists?
  end
  sleep(configatron.eventWaitTime)
  @gradeLessonEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for grade lesson should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @gradeLessonStartTimeStamp
  @endTimeStamp = @gradeLessonEndTimeStamp

  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"


  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson_timer'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'lesson_timer'
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['extensions']['moduleType'].should == 'lesson'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Lesson Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 100
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Lesson Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 51.28
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Lesson Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 70
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Lesson Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 35.9
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'lesson'
end

And(/^\['event'\]\.\['generated'\]\.\['totalScore'\] = Graded Lesson Total Score$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == 70
end

Then(/^An Event for Grade Lesson should get generated and sent to CSV\.$/) do
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

And(/^Grade Lesson CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Grade Lesson CSV \['Page'\] Column Value = 'lesson'$/) do
  @latest_record['Page'].should == 'lesson'
end

And(/^Grade Lesson CSV \['Activity Type'\] Column Value = 'lesson'$/) do
  @latest_record['Activity Type'].should == 'lesson'
end

And(/^Grade Lesson CSV \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedlessonname
end

And(/^Grade Lesson CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Grade Lesson CSV \['Score'\] Column Value = Graded Lesson Total Score$/) do
  @latest_record['Score'].should == '70'
end

And(/^Grade Lesson CSV \['Max Score'\] Column Value = Provided Lesson Max Grade$/) do
  @latest_record['Max Score'].should == '100'
end

And(/^Grade Lesson CSV \['Score\(Percent\)'\] Column Value = Provided Lesson Percentage$/) do
  @latest_record['Score (Percent)'].should == '70'
end

Then(/^An Event for Grade Lesson should get generated and sent to Tableau\.$/) do
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

And(/^Grade Lesson Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Grade Lesson Tableau \['Page'\] Column Value = 'lesson'$/) do
  @newest_record['Page'].should == 'lesson'
end

And(/^Grade Lesson Tableau \['Activity Type'\] Column Value = 'lesson'$/) do
  @newest_record['ActivityType'].should == 'lesson'
end

And(/^Grade Lesson Tableau \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedlessonname
end

And(/^Grade Lesson Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Grade Lesson Tableau \['Score'\] Column Value = Graded Lesson Total Score$/) do
  @newest_record['Score'].should == 70
end

And(/^Grade Lesson Tableau \['Max Score'\] Column Value = Provided Lesson Max Grade$/) do
  @newest_record['MaxScore'].should == 100
end

And(/^Grade Lesson Tableau \['Score\(Percent\)'\] Column Value = Provided Lesson Percentage$/) do
  @newest_record['Score_Percent_'].should == 70
end
