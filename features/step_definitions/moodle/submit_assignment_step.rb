Given(/^Submit an Assignment as a Student$/) do

  ENV['TZ'] = 'UTC'
  @currnetTimeStamp = Time.new.to_i * 1000
  @assignmentId = 489
  @assignmentId = configatron.assignmentId unless configatron.assignmentId == nil

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

  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + @assignmentId.to_s)
  @assinonlinetxt = 'Auto Online Test by the Student ' + @currnetTimeStamp.to_s
  on AssignmentViewPage do |page|
    page.assignment_add_submission_btn.wait_until_present
    page.assignment_add_submission_btn.click
    page.assignment_onlinetext_editor.send_keys @assinonlinetxt
    page.assignment_submission_submit_btn.wait_until_present
    @submitAssignmentStartTimeStamp = Time.new.to_i * 1000
    page.assignment_submission_submit_btn.click
    page.error_continue_link.click if page.error_continue_link.exists?
    page.submit_assignment_btn.wait_until_present
    page.submit_assignment_btn.click
    page.submission_statement_chkbx.wait_until_present
    page.submission_statement_chkbx.click
    page.assignment_submission_submit_btn.click

  end
end

When(/^Assignment got submitted successfully by the Student$/) do
  on AssignmentViewPage do |page|
    # page.assignment_submission_status_msg.wait_until_present
    # page.assignment_submission_status_msg.exists?.should be_true
  end
  sleep(configatron.eventWaitTime)
  @submitAssignmentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An AssignableEvent should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @submitAssignmentStartTimeStamp
  @endTimeStamp = @submitAssignmentEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"assign_submission\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^Assignment submitted Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment submitted Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
end

And(/^Assignment submitted Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment submitted Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^Assignment submitted Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Submitted'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
end

And(/^Assignment submitted Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment submitted Event \['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'assign'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'assign'
end

And(/^Assignment submitted Event \['event'\]\.\['generated'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment submitted Event \['event'\]\.\['generated'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'assign_submission'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'assign_submission'
end

Then(/^An Event for Submit Assignment should get generated and sent to CSV\.$/) do
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

And(/^Submit Assignment CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Submit Assignment CSV \['Page'\] Column Value = 'assign_submission'$/) do
  @latest_record['Page'].should == 'assign_submission'
end

And(/^Submit Assignment CSV \['Activity Type'\] Column Value = 'assign'$/) do
  @latest_record['Activity Type'].should == 'assign'
end

And(/^Submit Assignment CSV \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @latest_record['Activity Name'].should == configatron.assignmentName
end

And(/^Submit Assignment CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Submit Assignment should get generated and sent to Tableau\.$/) do
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

And(/^Submit Assignment Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Submit Assignment Tableau \['Page'\] Column Value = 'assign_submission'$/) do
  @newest_record['Page'].should == 'assign_submission'
end

And(/^Submit Assignment Tableau \['Activity Type'\] Column Value = 'assign'$/) do
  @newest_record['ActivityType'].should == 'assign'
end

And(/^Submit Assignment Tableau \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @newest_record['ActivityName'].should == configatron.assignmentName
end

And(/^Submit Assignment Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
