Given(/^Upload a File to a Topic under Forum as a Instructor$/) do
  #Create a discussion by teacher
  @currnetTimeStamp = Time.new.to_i * 1000
  @forumId = configatron.forum_id

  @baseDir = File.absolute_path "./"
  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","testImage.jpg")

  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)

  @topicTeacherSubject =  'at_topic_teacher_subject_'+@currnetTimeStamp.to_s
  @topicTeacherMessage = 'Automated Topic Teacher Message'+@currnetTimeStamp.to_s
  configatron.topicteachersub = @topicTeacherSubject
  configatron.topicteachermsg = @topicTeacherMessage
  @browser.goto(configatron.moodleURL+'/mod/forum/view.php?id='+@forumId)

  on CourseForumDiscussionPage do |page|
    page.topic_addanewdiscussion_btn_clk

    @uploadFileInstructorForumTopicStartTimeStamp = Time.new.to_i * 1000
    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicTeacherSubject

    page.topic_message.click
    page.topic_message.send_keys [:control, 'a']
    page.topic_message.send_keys @topicTeacherMessage

    page.select_files_link.click
    sleep(5)
    page.upload_files_link.click
    sleep(5)
    @browser.file_field(:id,//).set(uploadfile_path)
    sleep(5)
    page.upload_files_btn.click
    sleep(5)

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
end

When(/^File got successfully uploaded in a Forum Topic by the Instructor$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.forumname+'updated'
  end
  sleep(10)
  @uploadFileInstructorForumTopicEndTimeStamp = Time.new.to_i * 1000
  sleep(5)
  moodle_logout
end

Then(/^An Event for Instructor Forum Assessable \(Topic File\) Uploaded should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @uploadFileInstructorForumTopicStartTimeStamp
  @endTimeStamp = @uploadFileInstructorForumTopicEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"forum_assessable\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'file'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'file'
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] = Provided Instructor Topic Subject$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].should == configatron.topicteachersub
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'forum_assessable'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'forum_assessable'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'forum'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'forum'
end

Given(/^Upload a File to a Topic under Forum as a Student$/) do
  #Create a discussion by student
  @currnetTimeStamp = Time.new.to_i * 1000
  @forumId = configatron.forum_id

  @baseDir = File.absolute_path "./"
  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","testImage.jpg")

  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)

  @topicStudentSubject =  'at_topic_student_subject_'+@currnetTimeStamp.to_s
  @topicStudentMessage = 'Automated Topic Student Message'+@currnetTimeStamp.to_s
  configatron.topicstudentsub = @topicStudentSubject
  configatron.topicstudentmsg = @topicStudentMessage
  @browser.goto(configatron.moodleURL+'/mod/forum/view.php?id='+@forumId)

  on CourseForumDiscussionPage do |page|
    page.topic_addanewdiscussion_btn_clk

    @uploadFileStudentForumTopicStartTimeStamp = Time.new.to_i * 1000
    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicStudentSubject

    page.topic_message.click
    page.topic_message.send_keys [:control, 'a']
    page.topic_message.send_keys @topicStudentMessage

    page.select_files_link.click
    sleep(5)
    page.upload_files_link.click
    sleep(5)
    @browser.file_field(:id,//).set(uploadfile_path)
    sleep(5)
    page.upload_files_btn.click
    sleep(5)

    page.post_to_forum_btn_clk
  end
end

When(/^File got successfully uploaded in a Forum Topic by the Student$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.forumname+'updated'
  end
  sleep(10)
  @uploadFileStudentForumTopicEndTimeStamp = Time.new.to_i * 1000
  sleep(5)
  moodle_logout
end

Then(/^An Event for Student Forum Assessable \(Topic File\) Uploaded should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @uploadFileStudentForumTopicStartTimeStamp
  @endTimeStamp = @uploadFileStudentForumTopicEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"forum_assessable\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] = Provided Student Topic Subject$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].should == configatron.topicstudentsub
end
