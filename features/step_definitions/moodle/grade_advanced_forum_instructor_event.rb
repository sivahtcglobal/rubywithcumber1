Given(/^Graded a Forum under a Topic\(Discussion\) for a course$/) do
  #Grade a forum by teacher
  @courseId = configatron.courseId
  @studentPostId = configatron.post_id

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
  @gradeForumStartTimeStamp = Time.new.to_i * 1000
   @browser.goto(configatron.moodleURL+'/grade/report/grader/index.php?id='+@courseId)
  on GradeReportPage do |page|
    page.grades_menu_link.click
    page.single_view_link.click
    page.override_chkbox.click
    page.grade_txt.click
    page.grade_txt.send_keys [:control, 'a']
    page.grade_txt.send_keys '90'

    @browser.execute_script('arguments[0].scrollIntoView();', page.grade_txt)

    page.grade_save_btn_clk
  end
end

When(/^The Forum got successfully graded$/) do

  on GradeReportPage do |page|
    page.grade_alert_msg.text.include? ('Grades were set for 1 items')
    page.grade_alert_continue_btn_clk if page.grade_alert_continue_btn.exists?
    page.grade_continue_btn_clk if page.grade_continue_btn.exists?
  end
  sleep(configatron.eventWaitTime)
  @gradeForumEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for grade forum should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @gradeForumStartTimeStamp
  @endTimeStamp = @gradeForumEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Advanced Forum Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 100
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Advanced Forum Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 32.79
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Advanced Forum Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 90
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Advanced Forum Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 29.51
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['courseTotalGrade'\] = courseTotalGrade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['courseTotalGrade'].should >= 0
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['courseTotalPercentage'\] = courseTotalPercentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['courseTotalPercentage'].should >= 0
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['courseTotalRange'\] = courseTotalRange$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['courseTotalRange'].should >= 0
end

And(/^\['event'\]\.\['generated'\]\.\['totalScore'\] = Graded Score$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == 90
end

Then(/^An Event for Grade Advanced Forum should get generated and sent to CSV\.$/) do
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

And(/^Grade Advanced Forum CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Grade Advanced Forum CSV \['Page'\] Column Value = 'hsuforum'$/) do
  @latest_record['Page'].should == 'hsuforum'
end

And(/^Grade Advanced Forum CSV \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @latest_record['Activity Type'].should == 'hsuforum'
end

And(/^Grade Advanced Forum CSV \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @latest_record['Activity Name'].should == configatron.advancedforumname+'updated'
end

And(/^Grade Advanced Forum CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Grade Advanced Forum CSV \['Score'\] Column Value = Graded Score$/) do
  @latest_record['Score'].should == '90'
end

And(/^Grade Advanced Forum CSV \['Max Score'\] Column Value = Provided Advanced Forum Max Grade$/) do
  @latest_record['Max Score'].should == '100'
end

And(/^Grade Advanced Forum CSV \['Score\(Percent\)'\] Column Value = Provided Advanced Forum Percentage$/) do
  @latest_record['Score (Percent)'].should == '90'
end

Then(/^An Event for Grade Advanced Forum should get generated and sent to Tableau\.$/) do
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

And(/^Grade Advanced Forum Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Grade Advanced Forum Tableau \['Page'\] Column Value = 'hsuforum'$/) do
  @newest_record['Page'].should == 'hsuforum'
end

And(/^Grade Advanced Forum Tableau \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @newest_record['ActivityType'].should == 'hsuforum'
end

And(/^Grade Advanced Forum Tableau \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @newest_record['ActivityName'].should == configatron.advancedforumname+'updated'
end

And(/^Grade Advanced Forum Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Grade Advanced Forum Tableau \['Score'\] Column Value = Graded Score$/) do
  @newest_record['Score'].should == 90
end

And(/^Grade Advanced Forum Tableau \['Max Score'\] Column Value = Provided Advanced Forum Max Grade$/) do
  @newest_record['MaxScore'].should == 100
end

And(/^Grade Advanced Forum Tableau \['Score\(Percent\)'\] Column Value = Provided Advanced Forum Percentage$/) do
  @newest_record['Score_Percent_'].should == 90
end
