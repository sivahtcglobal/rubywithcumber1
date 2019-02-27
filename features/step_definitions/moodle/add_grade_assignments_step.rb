Given(/^Add Grade and Feedback Comment to Assignment for a Given Course$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  @assignmentId = configatron.assignmentId
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

  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + @assignmentId.to_s)

  on AssignmentViewPage do |page|
    page.assignment_grade_btn.wait_until_present
    page.assignment_grade_btn.click
    #To wait for all the elements on the to render
    sleep(10)
    page.next_user_link.wait_until_present
    page.next_user_link.click
    sleep(20)
    page.assignment_grade_txt.wait_until_present
    page.assignment_grade_txt.set '65'
    page.assignment_comment_editor.wait_until_present
    page.assignment_comment_editor.send_keys [:control, 'a']
    page.assignment_comment_editor.send_keys 'Automated Grade Feedback comments'
    page.allow_another_attempt_select.select 'Yes'
    page.assignment_graded_btn.wait_until_present
    @addGradeAssignmentStartTimeStamp = Time.new.to_i * 1000
    page.assignment_graded_btn.click
  end
end

When(/^Grade and Feedback Comment Got successfully Added to the Assignment for a Given Course$/) do
  on AssignmentViewPage do |page|
    page.saved_successful_msg.wait_until_present
    page.saved_successful_msg.exists?.should be true
    page.confirm_ok_btn.click
    @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + @assignmentId.to_s)
    @browser.alert.ok if @browser.alert.exists?
  end
  sleep(configatron.eventWaitTime)
  @addGradeAssignmentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^A Assignment Grade and Feedback Comment Event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @addGradeAssignmentStartTimeStamp
  @endTimeStamp = @addGradeAssignmentEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']

  @hits.should == 1
end


And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/OutcomeEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Graded'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'assign_submission'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'assign_submission'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['generated'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['generated'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Result'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/Result'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Assignment Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 95
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Assignment Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 100
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Assignment Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 68.42
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Assignment Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 68.42
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['generated'\]\.\['normalScore'\] = (\d+)$/) do |arg|
  @response['hits']['hits'][0]['_source']['event']['generated']['normalScore'].should == arg.to_i
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['generated'\]\.\['totalScore'\] = (\d+)$/) do |arg|
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == arg.to_i
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['generated'\]\.\['scoredBy'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['scoredBy']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Grade and Feedback Comment Event \['event'\]\.\['generated'\]\.\['scoredBy'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['scoredBy']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

Then(/^An Event for Grade Assignment should get generated and sent to CSV\.$/) do
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

And(/^Grade Assignment CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Grade Assignment CSV \['Page'\] Column Value = 'assign'$/) do
  @latest_record['Page'].should == 'assign'
end

And(/^Grade Assignment CSV \['Activity Type'\] Column Value = 'assign'$/) do
  @latest_record['Activity Type'].should == 'assign'
end

And(/^Grade Assignment CSV \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @latest_record['Activity Name'].should == configatron.assignmentName
end

And(/^Grade Assignment CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Grade Assignment CSV \['Score'\] Column Value = (\d+)$/) do |arg|
  @latest_record['Score'].should == arg.to_s
end

And(/^Grade Assignment CSV \['Max Score'\] Column Value = Provided Assignment Max Grade$/) do
  @latest_record['Max Score'].should == '95'
end

And(/^Grade Assignment CSV \['Score\(Percent\)'\] Column Value = Provided Assignment Percentage$/) do
  @latest_record['Score (Percent)'].should == '68.42'
end

Then(/^An Event for Grade Assignment should get generated and sent to Tableau\.$/) do
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

And(/^Grade Assignment Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Grade Assignment Tableau \['Page'\] Column Value = 'assign'$/) do
  @newest_record['Page'].should == 'assign'
end

And(/^Grade Assignment Tableau \['Activity Type'\] Column Value = 'assign'$/) do
  @newest_record['ActivityType'].should == 'assign'
end

And(/^Grade Assignment Tableau \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @newest_record['ActivityName'].should == configatron.assignmentName
end

And(/^Grade Assignment Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Grade Assignment Tableau \['Score'\] Column Value = (\d+)$/) do |arg|
  @newest_record['Score'].should == arg.to_i
end

And(/^Grade Assignment Tableau \['Max Score'\] Column Value = Provided Assignment Max Grade$/) do
  @newest_record['MaxScore'].should == 95
end

And(/^Grade Assignment Tableau \['Score\(Percent\)'\] Column Value = Provided Assignment Percentage$/) do
  @newest_record['Score_Percent_'].should == 68.42
end
