Given(/^Submitted a Post under a Forum Discussion for a course$/) do
  #Create a discussion by teacher
  @currnetTimeStamp = Time.new.to_i * 1000
  @forumId = configatron.forum_id

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

  @topicTeacherSubject =  'at_topic_teacher_subject_'+@currnetTimeStamp.to_s
  @topicTeacherMessage = 'Automated Topic Teacher Message'+@currnetTimeStamp.to_s
  configatron.topicteachersubject = @topicTeacherSubject
  configatron.topicteachermessage = @topicTeacherMessage
  @browser.goto(configatron.moodleURL+'/mod/forum/view.php?id='+@forumId)

  on CourseForumDiscussionPage do |page|
    page.topic_addanewdiscussion_btn_clk

    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicTeacherSubject

    page.topic_message.click
    page.topic_message.send_keys [:control, 'a']
    page.topic_message.send_keys @topicTeacherMessage

    page.pinned_chkbx.click
    page.send_forum_post_notification_chkbx.click
    page.time_start_chkbx.click
    page.from_day_select.select '1'
    page.from_month_select.select 'January'
    page.from_year_select.select '2017'
    page.from_hour_select.select '08'
    page.from_minute_select.select '05'
    page.time_end_chkbx.click
    page.to_day_select.select '31'
    page.to_month_select.select 'December'
    page.to_year_select.select '2018'
    page.to_hour_select.select '18'
    page.to_minute_select.select '05'

    page.post_to_forum_btn_clk
  end
  moodle_logout

  #Submit a post by student
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  @topicStudentMessage = 'Automated Topic Student Message'+@currnetTimeStamp.to_s
  sleep(10)
  @submitPostStartTimeStamp = Time.new.to_i * 1000
  configatron.topicstudentmessage = @topicStudentMessage
  @browser.goto(configatron.moodleURL+'/mod/forum/view.php?id='+@forumId)

  on CourseForumDiscussionPage do |page|
    sleep(3)
    @navigateToForumDiscussionStartTimeStamp = Time.new.to_i * 1000
    page.teacher_discussion_link(configatron.topicteachersubject).click
    sleep(3)
    @navigateToForumDiscussionEndTimeStamp = Time.new.to_i * 1000
    @browser.execute_script('arguments[0].scrollIntoView();', page.display_replies_form)
    sleep(3)
    page.student_reply_link.click

    page.topic_message.click
    page.topic_message.send_keys [:control, 'a']
    page.topic_message.send_keys @topicStudentMessage

    page.post_to_forum_btn_clk
  end
end

When(/^The Forum Post got successfully submitted$/) do

  on CourseItemPage do |page|
    page.student_message_txt.text.should == configatron.topicstudentmessage
  end
  configatron.post_id = get_item_id()
  sleep(10)
  @submitPostEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for student Forum post should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @submitPostStartTimeStamp
  @endTimeStamp = @submitPostEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"forum_post\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'forum'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'forum'
end

And(/^\['event'\]\.\['generated'\]\.\['@id'\] value includes the forum post id submitted by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include? configatron.post_id
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] includes the student forum post subject name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].include? configatron.topicteachersubject
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'forum_post'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'forum_post'
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'forum'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'forum'
end

Then(/^An Event for Navigate to Forum Discussion should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @navigateToForumDiscussionStartTimeStamp
  @endTimeStamp = @navigateToForumDiscussionEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.moduleType\":\"forum_discussions\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'forum_discussions'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'forum_discussions'
end

Then(/^An Event for student forum post should get generated and sent to CSV\.$/) do
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

And(/^Student Forum Post CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Student Forum Post CSV \['Page'\] Column Value = 'forum_post'$/) do
  @latest_record['Page'].should == 'forum_post'
end

And(/^Student Forum Post CSV \['Activity Type'\] Column Value = 'forum'$/) do
  @latest_record['Activity Type'].should == 'forum'
end

And(/^Student Forum Post CSV \['Activity Name'\] Column Value = Provided Forum Name$/) do
  @latest_record['Activity Name'].should == configatron.forumname+'updated'
end

And(/^Student Forum Post CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for student forum post should get generated and sent to Tableau\.$/) do
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

And(/^Student Forum Post Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Student Forum Post Tableau \['Page'\] Column Value = 'forum_post'$/) do
  @newest_record['Page'].should == 'forum_post'
end

And(/^Student Forum Post Tableau \['Activity Type'\] Column Value = 'forum'$/) do
  @newest_record['ActivityType'].should == 'forum'
end

And(/^Student Forum Post Tableau \['Activity Name'\] Column Value = Provided Forum Name$/) do
  @newest_record['ActivityName'].should == configatron.forumname+'updated'
end

And(/^Student Forum Post Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
