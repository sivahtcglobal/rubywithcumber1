Given(/^Submitted Text to Assignment for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @assignmentId = configatron.assignmentId
  @assignmentText = 'at_assignment_text'+@currnetTimeStamp.to_s

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

  configatron.assignmenttext = @assignmentText
  @assignmentName = configatron.assignmentName
  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id='+@assignmentId)

  on AssignmentViewPage do |page|
    page.assignment_add_submission_btn.click
    sleep(10)
    @submitTextStartTimeStamp = Time.new.to_i * 1000

    page.assignment_onlinetext_editor.click
    page.assignment_onlinetext_editor.send_keys [:control, 'a']
    page.assignment_onlinetext_editor.send_keys @assignmentText

    page.assignment_submission_submit_btn.click
  end

end

When(/^The Text got successfully submitted by student$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @assignmentName
  end
  sleep(10)
  @submitTextEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Submitted Text should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @submitTextStartTimeStamp
  @endTimeStamp = @submitTextEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.moduleType\":\"assign_text\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentItemEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Completed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
end

And(/^\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentItem'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
end

And(/^\['event'\]\.\['generated'\]\.\['@id'\] value includes the assignment id submitted by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include?("id=" + @assignmentId)
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'assign_text'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'assign_text'
end

And(/^\['event'\]\.\['generated'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'assign'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'assign'
end

Then(/^An Event for Submitted Text should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Page']=='assign_text' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Submitted Text CSV \['Action'\] Column Value = 'Completed'$/) do
  @latest_record['Action'].should == 'Completed'
end

And(/^Submitted Text CSV \['Page'\] Column Value = 'assign_text'$/) do
  @latest_record['Page'].should == 'assign_text'
end

And(/^Submitted Text CSV \['Activity Type'\] Column Value = 'assign'$/) do
  @latest_record['Activity Type'].should == 'assign'
end

And(/^Submitted Text CSV \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @latest_record['Activity Name'].should == configatron.assignmentName
end

And(/^Submitted Text CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Submitted Text should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Page']=='assign_text' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Submitted Text Tableau \['Action'\] Column Value = 'Completed'$/) do
  @newest_record['Action'].should == 'Completed'
end

And(/^Submitted Text Tableau \['Page'\] Column Value = 'assign_text'$/) do
  @newest_record['Page'].should == 'assign_text'
end

And(/^Submitted Text Tableau \['Activity Type'\] Column Value = 'assign'$/) do
  @newest_record['ActivityType'].should == 'assign'
end

And(/^Submitted Text Tableau \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @newest_record['ActivityName'].should == configatron.assignmentName
end

And(/^Submitted Text Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
