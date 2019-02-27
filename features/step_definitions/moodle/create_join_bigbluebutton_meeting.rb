Given(/^Attended a New BigBlueButton Meeting by Instructor$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @bigBlueButtonId = configatron.bigbluebutton_id
  @nameInstructor = 'Instructor Name' + @currnetTimeStamp.to_s
  @descriptionInstructor = 'Instructor Description' + @currnetTimeStamp.to_s
  @tagsInstructor = 'Instructor Tags' + @currnetTimeStamp.to_s

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
  puts  "#{configatron.autoTeacherUsername} / #{configatron.autoTeacherPassword}"
  puts "Button Id : #{@bigBlueButtonId}"
  @browser.goto(configatron.moodleURL+'/mod/bigbluebuttonbn/view.php?id='+@bigBlueButtonId)

  on CourseBigBlueButtonPage do |page|
    page.join_session_btn.wait_until_present
    page.join_session_btn_clk
    page.name_recording_txt.wait_until_present
    page.name_recording_txt.send_keys @nameInstructor
    page.description_recording_txt.send_keys @descriptionInstructor
    page.tags_recording_txt.send_keys @tagsInstructor
    page.apply_btn_clk
    sleep(15)
    @browser.driver.switch_to.window(@browser.driver.window_handles[1])
    sleep(60)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :enter
    sleep(5)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    #@browser.send_keys :tab
    @browser.send_keys :enter
    sleep(5)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :enter
    sleep(5)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :enter
    sleep(5)

    @browser.driver.switch_to.window(@browser.driver.window_handles[0])

    page.end_session_btn_clk
    sleep(3)
  end
end

When(/^The New BigBlueButton Meeting got successfully attended$/) do
  on CourseBigBlueButtonPage do |page|
    page.end_session_btn.exists?.should be_false
  end
  moodle_logout
end

Then(/^An Event for New BigBlueButton Meeting Create should get generated and sent to our Raw Event Index\.$/) do
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
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"bigbluebuttonbn_meeting_created\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'bigbluebuttonbn'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'bigbluebuttonbn'
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'bigbluebuttonbn_meeting_created'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'bigbluebuttonbn_meeting_created'
end

Then(/^An Event for BigBlueButton Meeting Join should get generated and sent to our Raw Event Index\.$/) do
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
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"bigbluebuttonbn_meeting_joined\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'bigbluebuttonbn_meeting_joined'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'bigbluebuttonbn_meeting_joined'
end

Then(/^An Event for BigBlueButton Meeting Left should get generated and sent to our Raw Event Index\.$/) do
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
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"bigbluebuttonbn_meeting_left\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'bigbluebuttonbn_meeting_left'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'bigbluebuttonbn_meeting_left'
end

Then(/^An Event for BigBlueButton Meeting End should get generated and sent to our Raw Event Index\.$/) do
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
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"bigbluebuttonbn_meeting_ended\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'bigbluebuttonbn_meeting_ended'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'bigbluebuttonbn_meeting_ended'
end

Given(/^Attended a New BigBlueButton Meeting by Student$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @bigBlueButtonId = configatron.bigbluebutton_id
  @nameStudent = 'Student Name' + @currnetTimeStamp.to_s
  @descriptionStudent = 'Student Description' + @currnetTimeStamp.to_s
  @tagsStudent = 'Student Tags' + @currnetTimeStamp.to_s

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

  @browser.goto(configatron.moodleURL+'/mod/bigbluebuttonbn/view.php?id='+@bigBlueButtonId)

  on CourseBigBlueButtonPage do |page|
    page.join_session_btn.wait_until_present
    page.join_session_btn_clk
    page.name_recording_txt.wait_until_present
    page.name_recording_txt.send_keys @nameStudent
    page.description_recording_txt.send_keys @descriptionStudent
    page.tags_recording_txt.send_keys @tagsStudent
    page.apply_btn.wait_until_present
    page.apply_btn_clk
    sleep(15)
    @browser.driver.switch_to.window(@browser.driver.window_handles[1])
    sleep(5)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :enter
    sleep(2)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :tab
    #@browser.send_keys :tab
    @browser.send_keys :enter
    sleep(2)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :enter
    sleep(2)
    @browser.send_keys :tab
    @browser.send_keys :tab
    @browser.send_keys :enter
    sleep(5)

    @browser.driver.switch_to.window(@browser.driver.window_handles[0])

    page.end_session_btn_clk
    sleep(3)
  end
end

Then(/^Events for BigBlueButton Meeting should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Modified' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^BigBlueButton Meeting CSV \['Action'\] Column Value = 'Modified'$/) do
  @latest_record['Action'].should == 'Modified'
end

And(/^BigBlueButton Meeting CSV \['Activity Type'\] Column Value = 'bigbluebuttonbn'$/) do
  @latest_record['Activity Type'].should == 'bigbluebuttonbn'
end

And(/^BigBlueButton Meeting CSV \['Activity Name'\] Column Value = Provided BigBlueButton Meeting Name$/) do
  @latest_record['Activity Name'].should == configatron.bigbluebuttonname+'updated'
end

And(/^BigBlueButton Meeting CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^Events for BigBlueButton Meeting should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Modified' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^BigBlueButton Meeting Tableau \['Action'\] Column Value = 'Modified'$/) do
  @newest_record['Action'].should == 'Modified'
end

And(/^BigBlueButton Meeting Tableau \['Activity Type'\] Column Value = 'bigbluebuttonbn'$/) do
  @newest_record['ActivityType'].should == 'bigbluebuttonbn'
end

And(/^BigBlueButton Meeting Tableau \['Activity Name'\] Column Value = Provided BigBlueButton Meeting Name$/) do
  @newest_record['ActivityName'].should == configatron.bigbluebuttonname+'updated'
end

And(/^BigBlueButton Meeting Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
