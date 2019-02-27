Given(/^Uploaded File to an Assignment as a Student$/) do
  @baseDir = File.absolute_path "./"

  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","testImage.jpg")
  puts uploadfile_path
  ENV['TZ'] = 'UTC'
  @currnetTimeStamp = Time.new.to_i * 1000
  @assignmentId = 487
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
    page.assignment_add_submission_btn.click
    sleep(5)
    page.select_files_link.click
    sleep(5)
    page.upload_files_link.click
    sleep(5)
    @browser.file_field(:id,//).set(uploadfile_path)
    page.upload_files_btn.click
    page.overwrite_btn.click if page.overwrite_btn.exists?
    sleep(5)
    @uploadFileStartTimeStamp = Time.new.to_i * 1000
    page.assignment_submission_submit_btn.click
  end
end

When(/^File got uploaded successfully to the Assignment by the Student$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.assignmentName
  end
  sleep(10)
  @uploadFileEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An AssessmentItemEvent should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @uploadFileStartTimeStamp
  @endTimeStamp = @uploadFileEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.moduleType\":\"assign_file\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":3,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']

  @hits.should == 1
end


And(/^AssessmentItemEvent submitted Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentItemEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal.org\/vocab\/caliper\/v1\/action#Completed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should.should === 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentItem'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'assign_file'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'assign_file'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['generated'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@context'].should.should === 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^AssessmentItemEvent submitted Event \['event'\]\.\['generated'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should.should === 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

Then(/^An Event for Upload File should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Page']=='assign_file' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Upload File CSV \['Action'\] Column Value = 'Completed'$/) do
  @latest_record['Action'].should == 'Completed'
end

And(/^Upload File CSV \['Page'\] Column Value = 'assign_file'$/) do
  @latest_record['Page'].should == 'assign_file'
end

And(/^Upload File CSV \['Activity Type'\] Column Value = 'assign'$/) do
  @latest_record['Activity Type'].should == 'assign'
end

And(/^Upload File CSV \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @latest_record['Activity Name'].should == configatron.assignmentName
end

And(/^Upload File CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Upload File should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Page']=='assign_file' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Upload File Tableau \['Action'\] Column Value = 'Completed'$/) do
  @newest_record['Action'].should == 'Completed'
end

And(/^Upload File Tableau \['Page'\] Column Value = 'assign_file'$/) do
  @newest_record['Page'].should == 'assign_file'
end

And(/^Upload File Tableau \['Activity Type'\] Column Value = 'assign'$/) do
  @newest_record['ActivityType'].should == 'assign'
end

And(/^Upload File Tableau \['Activity Name'\] Column Value = Provided Assignment Name$/) do
  @newest_record['ActivityName'].should == configatron.assignmentName
end

And(/^Upload File Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
