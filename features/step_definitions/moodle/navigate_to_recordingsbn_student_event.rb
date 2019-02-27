Given(/^Navigated to RecordingsBN for a course$/) do
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

  sleep(3)
  @navigateToRecordingsBnStartTimeStamp = Time.new.to_i * 1000
  sleep(3)
  @browser.goto(configatron.moodleURL+'/mod/recordingsbn/view.php?id='+configatron.recordingsbn_id)

end

When(/^The RecordingsBN successfully navigated by student$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.recordingsnameupdated
  end
  sleep(10)
  @navigateToRecordingsBnEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Navigate to RecordingsBN should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @navigateToRecordingsBnStartTimeStamp
  @endTimeStamp = @navigateToRecordingsBnEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.moduleType\":\"recordingsbn\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'recordingsbn'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'recordingsbn'
end

Then(/^An Event for Navigate to RecordingsBN should get generated and sent to CSV\.$/) do
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

And(/^Navigate to RecordingsBN CSV \['Action'\] Column Value = 'Navigated To'$/) do
  @latest_record['Action'].should == 'Navigated To'
end

And(/^Navigate to RecordingsBN CSV \['Page'\] Column Value = 'recordingsbn'$/) do
  @latest_record['Page'].should == 'recordingsbn'
end

And(/^Navigate to RecordingsBN CSV \['Activity Type'\] Column Value = 'recordingsbn'$/) do
  @latest_record['Activity Type'].should == 'recordingsbn'
end

And(/^Navigate to RecordingsBN CSV \['Activity Name'\] Column Value = Provided RecordingsBN Name$/) do
  @latest_record['Activity Name'].should == configatron.recordingsnameupdated
end

And(/^Navigate to RecordingsBN CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Navigate to RecordingsBN should get generated and sent to Tableau\.$/) do
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

And(/^Navigate to RecordingsBN Tableau \['Action'\] Column Value = 'Navigated To'$/) do
  @newest_record['Action'].should == 'Navigated To'
end

And(/^Navigate to RecordingsBN Tableau \['Page'\] Column Value = 'recordingsbn'$/) do
  @newest_record['Page'].should == 'recordingsbn'
end

And(/^Navigate to RecordingsBN Tableau \['Activity Type'\] Column Value = 'recordingsbn'$/) do
  @newest_record['ActivityType'].should == 'recordingsbn'
end

And(/^Navigate to RecordingsBN Tableau \['Activity Name'\] Column Value = Provided RecordingsBN Name$/) do
  @newest_record['ActivityName'].should == configatron.recordingsnameupdated
end

And(/^Navigate to RecordingsBN Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
