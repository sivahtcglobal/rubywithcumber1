Given(/^Opened a Folder for a course$/) do
  @folderId = configatron.folder_id
  @folderName = configatron.foldername

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

  sleep(10)
  @openFolderStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/folder/view.php?id='+@folderId)
end

When(/^The Folder got successfully opened$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.include? @folderName
  end
  sleep(10)
  @openFolderEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Open Folder should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @openFolderStartTimeStamp
  @endTimeStamp = @openFolderEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['@id'\] value includes the folder id opened by student$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@id'].include?("id=" + @folderId)
end

And(/^\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Entity'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Entity'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'folder'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'folder'
end

And(/^\['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^\['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end

Then(/^An Event for Open Folder should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Navigated To' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Open Folder CSV \['Action'\] Column Value = 'Navigated To'$/) do
  @latest_record['Action'].should == 'Navigated To'
end

And(/^Open Folder CSV \['Page'\] Column Value = 'folder'$/) do
  @latest_record['Page'].should == 'folder'
end

And(/^Open Folder CSV \['Activity Type'\] Column Value = 'folder'$/) do
  @latest_record['Activity Type'].should == 'folder'
end

And(/^Open Folder CSV \['Activity Name'\] Column Value = Provided Folder Name$/) do
  @latest_record['Activity Name'].should == configatron.foldername+'updated'
end

And(/^Open Folder CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Open Folder should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Navigated To' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Open Folder Tableau \['Action'\] Column Value = 'Navigated To'$/) do
  @newest_record['Action'].should == 'Navigated To'
end

And(/^Open Folder Tableau \['Page'\] Column Value = 'folder'$/) do
  @newest_record['Page'].should == 'folder'
end

And(/^Open Folder Tableau \['Activity Type'\] Column Value = 'folder'$/) do
  @newest_record['ActivityType'].should == 'folder'
end

And(/^Open Folder Tableau \['Activity Name'\] Column Value = Provided Folder Name$/) do
  @newest_record['ActivityName'].should == configatron.foldername+'updated'
end

And(/^Open Folder Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
