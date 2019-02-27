Given(/^Sent a Chat Message by Student$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @chatId = configatron.chat_id
  @chatName = configatron.chatnameupdated
  @chatMessage = 'Automated Student Chat Message'+@currnetTimeStamp.to_s

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
  @browser.goto(configatron.moodleURL+'/mod/chat/view.php?id='+@chatId)

  on CourseChatPage do |page|
    sleep(5)
    @studentChatMessageStartTimeStamp = Time.new.to_i * 1000
    page.chat_window_link.click
    sleep(3)
    @browser.driver.switch_to.window(@browser.driver.window_handles[1])

    page.enter_your_msg_text.click
    page.enter_your_msg_text.send_keys [:control, 'a']
    page.enter_your_msg_text.send_keys @chatMessage

    page.message_send_btn.click
    sleep(10)
    @studentChatMessageEndTimeStamp = Time.new.to_i * 1000
    @browser.driver.close
    @browser.driver.switch_to.window(@browser.driver.window_handles[0])
    sleep(5)
  end
end

When(/^The Chat Message got successfully sent by Student$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @chatName
  end
  moodle_logout

end

Then(/^An Event for Student Chat Message should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @studentChatMessageStartTimeStamp
  @endTimeStamp = @studentChatMessageEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'chat'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'chat'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'chat_message'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'chat_message'
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'chat'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'chat'
end

Then(/^An Event for Student Chat Message should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Student Chat Message CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Student Chat Message CSV \['Page'\] Column Value = 'chat_message'$/) do
  @latest_record['Page'].should == 'chat_message'
end

And(/^Student Chat Message CSV \['Activity Type'\] Column Value = 'chat'$/) do
  @latest_record['Activity Type'].should == 'chat'
end

And(/^Student Chat Message CSV \['Activity Name'\] Column Value = Provided Chat Name$/) do
  @latest_record['Activity Name'].should == configatron.chatnameupdated
end

And(/^Student Chat Message CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Student Chat Message should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Student Chat Message Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Student Chat Message Tableau \['Page'\] Column Value = 'chat_message'$/) do
  @newest_record['Page'].should == 'chat_message'
end

And(/^Student Chat Message Tableau \['Activity Type'\] Column Value = 'chat'$/) do
  @newest_record['ActivityType'].should == 'chat'
end

And(/^Student Chat Message Tableau \['Activity Name'\] Column Value = Provided Chat Name$/) do
  @newest_record['ActivityName'].should == configatron.chatnameupdated
end

And(/^Student Chat Message Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Given(/^View the Chat Sessions by Student$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @chatId = configatron.chat_id
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @browser.goto(configatron.moodleURL+'/mod/chat/view.php?id='+@chatId)

  on CourseChatPage do |page|
    sleep(5)
    @studentChatSessionsViewedStartTimeStamp = Time.new.to_i * 1000
    page.view_chat_sessions_link.click
    sleep(5)
    @studentChatSessionsViewedEndTimeStamp = Time.new.to_i * 1000
    sleep(5)
  end
end

When(/^The Chat Sessions got successfully viewed by Student$/) do

  on CourseItemPage do |page|
    page.view_past_chat_sessions_link.text.should == 'View past chat sessions'
  end
  moodle_logout
end

Then(/^An Event for Student Chat Sessions Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @studentChatSessionsViewedStartTimeStamp
  @endTimeStamp = @studentChatSessionsViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Given(/^Sent a Chat Message by Instructor$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @chatId = configatron.chat_id
  @chatName = configatron.chatnameupdated
  @chatMessage = 'Automated Instructor Chat Message'+@currnetTimeStamp.to_s

  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @browser.goto(configatron.moodleURL+'/mod/chat/view.php?id='+@chatId)

  on CourseChatPage do |page|
    sleep(5)
    @instructorChatMessageStartTimeStamp = Time.new.to_i * 1000
    page.chat_window_link.click
    sleep(3)
    @browser.driver.switch_to.window(@browser.driver.window_handles[1])

    page.enter_your_msg_text.click
    page.enter_your_msg_text.send_keys [:control, 'a']
    page.enter_your_msg_text.send_keys @chatMessage

    page.message_send_btn.click
    sleep(10)
    @instructorChatMessageEndTimeStamp = Time.new.to_i * 1000
    @browser.driver.close
    @browser.driver.switch_to.window(@browser.driver.window_handles[0])
    sleep(5)
  end
end

When(/^The Chat Message got successfully sent by Instructor$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @chatName
  end
  moodle_logout

end

Then(/^An Event for Instructor Chat Message should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @instructorChatMessageStartTimeStamp
  @endTimeStamp = @instructorChatMessageEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Given(/^View the Chat Sessions by Instructor$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @chatId = configatron.chat_id
  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @browser.goto(configatron.moodleURL+'/mod/chat/view.php?id='+@chatId)

  on CourseChatPage do |page|
    sleep(5)
    @instructorChatSessionsViewedStartTimeStamp = Time.new.to_i * 1000
    page.view_chat_sessions_link.click
    sleep(5)
    @instructorChatSessionsViewedEndTimeStamp = Time.new.to_i * 1000
    sleep(5)
  end
end

When(/^The Chat Sessions got successfully viewed by Instructor$/) do

  on CourseItemPage do |page|
    page.view_past_chat_sessions_link.text.should == 'View past chat sessions'
  end
  moodle_logout
end

Then(/^An Event for Instructor Chat Sessions Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @instructorChatSessionsViewedStartTimeStamp
  @endTimeStamp = @instructorChatSessionsViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Event'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Event'
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Viewed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'chat_sessions'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'chat_sessions'
end
