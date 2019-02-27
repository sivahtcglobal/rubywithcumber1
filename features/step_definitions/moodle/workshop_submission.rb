Given(/^Created a New Workshop Submission Page for a Course$/) do
  @baseDir = File.absolute_path "./"
  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","emptyTextFile.txt")
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Workshop Submission for #{@courseId}"
  @workshopSubmissionName = 'WorkshopAuto_' + @currnetTimeStamp.to_s
  configatron.workshopsubmissionname = @workshopSubmissionName
  @workshop_id = configatron.workshop_id unless configatron.workshop_id == nil
  @workshopName = configatron.workshopname unless configatron.workshopname == nil

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

  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)

  on CourseWorkshopSubmissionPage do |page|
    page.submit_your_work_link.click
    page.start_preparing_your_submission_btn.click
    page.title_name_txt.send_keys @workshopSubmissionName
    page.submission_content_txt.send_keys @workshopSubmissionName + ' Description'
    sleep(5)
    #Upload a file to a course
    page.select_files_link.click
    sleep(5)
    page.upload_files_link.click
    sleep(5)
    @browser.file_field(:id,//).set(uploadfile_path)
    page.upload_files_btn.click
    sleep(5)
    page.submission_save_btn_clk
    sleep(10)
  end
end

When(/^The New Workshop Submission Page Got successfully submitted$/) do

  on CourseWorkshopSubmissionPage do |page|
    page.submission_title.text.should == @workshopSubmissionName
  end
  sleep(15)
  configatron.workshop_submission_id = get_item_id()
  moodle_logout
end

Then(/^An Event for New Workshop Submission Page should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['@context'\] ='http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['@type'\] ='http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] = Provided Workshop Submission Name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].should == configatron.workshopsubmissionname
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop_submission'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'workshop_submission'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'workshop'
end

Then(/^An Event for New Workshop Submission Page should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^New Workshop Submission Page CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^New Workshop Submission Page CSV \['Page'\] Column Value = 'workshop_submission'$/) do
  @latest_record['Page'].should == 'workshop_submission'
end

And(/^New Workshop Submission Page CSV \['Activity Type'\] Column Value = 'workshop'$/) do
  @latest_record['Activity Type'].should == 'workshop'
end

And(/^New Workshop Submission Page CSV \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @latest_record['Activity Name'].should == configatron.workshopname
end

And(/^New Workshop Submission Page CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for New Workshop Submission Page should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^New Workshop Submission Page Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^New Workshop Submission Page Tableau \['Page'\] Column Value = 'workshop_submission'$/) do
  @newest_record['Page'].should == 'workshop_submission'
end

And(/^New Workshop Submission Page Tableau \['Activity Type'\] Column Value = 'workshop'$/) do
  @newest_record['ActivityType'].should == 'workshop'
end

And(/^New Workshop Submission Page Tableau \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @newest_record['ActivityName'].should == configatron.workshopname
end

And(/^New Workshop Submission Page Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Then(/^An Event for Upload Workshop Submission Page should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Completed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['@type'\] ='http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentItemEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop_submission_file'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'workshop_submission_file'
end

Then(/^An Event for Upload Workshop Submission Page should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Completed' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Upload Workshop Submission Page CSV \['Action'\] Column Value = 'Completed'$/) do
  @latest_record['Action'].should == 'Completed'
end

And(/^Upload Workshop Submission Page CSV \['Page'\] Column Value = 'workshop_submission_file'$/) do
  @latest_record['Page'].should == 'workshop_submission_file'
end

And(/^Upload Workshop Submission Page CSV \['Activity Type'\] Column Value = 'workshop'$/) do
  @latest_record['Activity Type'].should == 'workshop'
end

And(/^Upload Workshop Submission Page CSV \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @latest_record['Activity Name'].should == configatron.workshopname
end

And(/^Upload Workshop Submission Page CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Upload Workshop Submission Page should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Completed' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Upload Workshop Submission Page Tableau \['Action'\] Column Value = 'Completed'$/) do
  @newest_record['Action'].should == 'Completed'
end

And(/^Upload Workshop Submission Page Tableau \['Page'\] Column Value = 'workshop_submission_file'$/) do
  @newest_record['Page'].should == 'workshop_submission_file'
end

And(/^Upload Workshop Submission Page Tableau \['Activity Type'\] Column Value = 'workshop'$/) do
  @newest_record['ActivityType'].should == 'workshop'
end

And(/^Upload Workshop Submission Page Tableau \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @newest_record['ActivityName'].should == configatron.workshopname
end

And(/^Upload Workshop Submission Page Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Given(/^Updated the New Workshop Submission for the Given Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  @workshop_id = configatron.workshop_id
  @workshop_submission_id = configatron.workshop_submission_id
  @workshopSubmissionName = 'AutoUpdated' + @currnetTimeStamp.to_s
  configatron.workshopsubmissionname = @workshopSubmissionName

  @browser.goto(configatron.moodleURL+'/mod/workshop/submission.php?cmid=' + @workshop_id.to_s + '&id=' + @workshop_submission_id.to_s)
  sleep(3)
  on CourseWorkshopSubmissionPage do |page|
    page.edit_submission_btn.click
    sleep(2)
    page.title_name_txt.clear
    page.title_name_txt.send_keys @workshopSubmissionName
    sleep(2)
    @browser.execute_script('arguments[0].scrollIntoView();', page.download_all_btn)
    page.submission_save_btn_clk
  end
end

When(/^The Workshop Submission Got successfully Updated for the Given Course$/) do
  on CourseDetailPage do |page|
    puts @workshopSubmissionName
    configatron.workshopsubmissionname = @workshopSubmissionName
  end
  sleep(10)
  moodle_logout
end

Then(/^A Course Event for the Updated Workshop Submission should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^Updated Name \['event'\]\.\['generated'\]\.\['name'\] = Provided Workshop Submission Name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].should == configatron.workshopsubmissionname
end

Then(/^An Event for Updated Workshop Submission should get generated and sent to CSV\.$/) do
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

And(/^Updated Workshop Submission CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Updated Workshop Submission CSV \['Page'\] Column Value = 'workshop_submission'$/) do
  @latest_record['Page'].should == 'workshop_submission'
end

And(/^Updated Workshop Submission CSV \['Activity Type'\] Column Value = 'workshop'$/) do
  @latest_record['Activity Type'].should == 'workshop'
end

And(/^Updated Workshop Submission CSV \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @latest_record['Activity Name'].should == configatron.workshopname
end

And(/^Updated Workshop Submission CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Updated Workshop Submission should get generated and sent to Tableau\.$/) do
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

And(/^Updated Workshop Submission Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Updated Workshop Submission Tableau \['Page'\] Column Value = 'workshop_submission'$/) do
  @newest_record['Page'].should == 'workshop_submission'
end

And(/^Updated Workshop Submission Tableau \['Activity Type'\] Column Value = 'workshop'$/) do
  @newest_record['ActivityType'].should == 'workshop'
end

And(/^Updated Workshop Submission Tableau \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @newest_record['ActivityName'].should == configatron.workshopname
end

And(/^Updated Workshop Submission Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
