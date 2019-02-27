Given(/^Open an Assignment for a course by a student$/) do
  @courseId = configatron.courseId unless configatron.courseId == nil
  @assignmentId = configatron.assignmentId unless configatron.assignmentId == nil
  @assignmentName = configatron.assignmentName unless configatron.assignmentName == nil

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoStudentUsername
      @password = configatron.autoStudentPassword
      log_in_moodle(@username,@password)

      @browser.goto(configatron.moodleURL+'/course/view.php?id='+@courseId)
      page.policy_accept_btn.click if page.policy_accept_btn.exists?

    end unless (page.automation_site_Student.exists? && page.automation_site_Student.text.include?(configatron.autoStudentUsername))
  end

  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + @assignmentId.to_s)
  on AssignmentViewPage do |page|
    sleep(10)
    @openAssignmentStartTimeStamp = Time.new.to_i * 1000
    page.assignment_add_submission_btn.click
  end

end

When(/^The Assignment got Opened successfully by the student$/) do
  on AssignmentViewPage do |page|
    page.assignment_name_heading(@assignmentName).exists?.should be_true
  end
  sleep(10)
  @openAssignmentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Open an Assignment should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @openAssignmentStartTimeStamp
  @endTimeStamp = @openAssignmentEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.moduleType\":\"assign\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Open an Assignment \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Open an Assignment \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/NavigationEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
end

And(/^Open an Assignment \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should ==  'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Open an Assignment \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^Open an Assignment \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#NavigatedTo'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should ==  'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
end

And(/^Open an Assignment \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should ==  'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Open an Assignment \['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

Then(/^An Event for Open an Assignment should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Page']=='assign' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Open Assignment CSV \['Action'\] Column Value = 'Navigated To'$/) do
  @latest_record['Action'].should == 'Navigated To'
end

And(/^Open Assignment CSV \['Page'\] Column Value = 'assign'$/) do
  @latest_record['Page'].should == 'assign'
end

And(/^Open Assignment CSV \['Activity Type'\] Column Value = 'assign'$/) do
  @latest_record['Activity Type'].should == 'assign'
end

And(/^Open Assignment CSV \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @latest_record['Activity Name'].should == configatron.assignmentName
end

And(/^Open Assignment CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Open an Assignment should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Page']=='assign' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Open Assignment Tableau \['Action'\] Column Value = 'Navigated To'$/) do
  @newest_record['Action'].should == 'Navigated To'
end

And(/^Open Assignment Tableau \['Page'\] Column Value = 'assign'$/) do
  @newest_record['Page'].should == 'assign'
end

And(/^Open Assignment Tableau \['Activity Type'\] Column Value = 'assign'$/) do
  @newest_record['ActivityType'].should == 'assign'
end

And(/^Open Assignment Tableau \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @newest_record['ActivityName'].should == configatron.assignmentName
end

And(/^Open Assignment Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
