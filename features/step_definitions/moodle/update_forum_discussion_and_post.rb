Given(/^Updated a Discussion for a course$/) do
  #Update a discussion by teacher
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
  configatron.topicteachersubjectupdated = @topicTeacherSubject + 'updated'
  configatron.topicteachermessageupdated = @topicTeacherMessage + 'updated'
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

    configatron.discussion_id = get_item_id()

    on CourseForumDiscussionPage do |page|
      page.teacher_discussion_link(configatron.topicteachersubject).click
      @browser.execute_script('arguments[0].scrollIntoView();', page.display_replies_form)
      sleep(3)
      page.edit_link.click

      @editDiscussionStartTimeStamp = Time.new.to_i * 1000
      page.topic_subject.click
      page.topic_subject.send_keys [:control, 'a']
      page.topic_subject.send_keys configatron.topicteachersubjectupdated

      page.topic_message.click
      page.topic_message.send_keys [:control, 'a']
      page.topic_message.send_keys configatron.topicteachermessageupdated

      page.save_changes_btn_clk
    end

  end
end

When(/^The Forum Discussion got successfully updated$/) do

  on CourseItemPage do |page|
    page.teacher_message_txt.text.should == configatron.topicteachermessageupdated
  end
  sleep(10)
  @editDiscussionEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for student Forum discussion should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @editDiscussionStartTimeStamp
  @endTimeStamp = @editDiscussionEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.moduleType\":\"forum\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['generated'\]\.\['@id'\] value includes the forum discussion id updated by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include? configatron.discussion_id
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] includes the student updated forum discussion name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].include? configatron.topicteachersubjectupdated
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'forum_discussion'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'forum_discussion'
end

Given(/^Updated a Post under a Forum Discussion for a course$/) do
  #Update a post by student
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  @topicStudentMessage = 'Automated Topic Student Message'+@currnetTimeStamp.to_s
  sleep(10)
  configatron.topicstudentmessage = @topicStudentMessage
  configatron.topicstudentmessageupdated = @topicStudentMessage + 'updated'
  @browser.goto(configatron.moodleURL+'/mod/forum/view.php?id='+configatron.forum_id)

  on CourseForumDiscussionPage do |page|
    page.teacher_discussion_link(configatron.topicteachersubjectupdated).click
    @browser.execute_script('arguments[0].scrollIntoView();', page.display_replies_form)
    sleep(3)
    page.student_reply_link.click

    page.topic_message.click
    page.topic_message.send_keys [:control, 'a']
    page.topic_message.send_keys @topicStudentMessage

    page.post_to_forum_btn_clk

    configatron.post_id = get_item_id()

    @browser.execute_script('arguments[0].scrollIntoView();', page.display_replies_form)
    sleep(3)
    page.edit_link.click

    @editPostStartTimeStamp = Time.new.to_i * 1000

    page.topic_message.click
    page.topic_message.send_keys [:control, 'a']
    page.topic_message.send_keys configatron.topicstudentmessageupdated

    page.save_changes_btn_clk
  end
end

When(/^The Forum Post got successfully updated$/) do

  on CourseItemPage do |page|
    page.student_message_txt.text.should == configatron.topicstudentmessageupdated
  end
  sleep(10)
  @editPostEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for update student Forum post should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @editPostStartTimeStamp
  @endTimeStamp = @editPostEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"forum_post\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['generated'\]\.\['@id'\] value includes the forum post id updated by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include? configatron.post_id
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] includes the updated student forum post subject name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].include? configatron.topicteachersubjectupdated
end

Then(/^An Event for update student forum post should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

Then(/^An Event for update student forum post should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end
