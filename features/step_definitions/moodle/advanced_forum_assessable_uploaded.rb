Given(/^Upload a File to a Topic under Advanced Forum as a Instructor$/) do
  #Create a topic(discussion) by teacher
  @currnetTimeStamp = Time.new.to_i * 1000
  @advancedForumId = configatron.advanced_forum_id

  @baseDir = File.absolute_path "./"
  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","testImage.jpg")

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
  @topicTeacherPost = 'Automated Topic Teacher Post'+@currnetTimeStamp.to_s
  configatron.topicinstructorsubject = @topicTeacherSubject
  configatron.topicinstructorpost = @topicTeacherPost
  @browser.goto(configatron.moodleURL+'/mod/hsuforum/view.php?id='+@advancedForumId)

  on CourseTopicPage do |page|
    page.topic_addanewdiscussion_btn.wait_until_present
    page.topic_addanewdiscussion_btn_clk

    @uploadFileInstructorAdvForumTopicStartTimeStamp = Time.new.to_i * 1000
    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicTeacherSubject

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys @topicTeacherPost
    sleep(3)

    @browser.file_field(:id,//).set(uploadfile_path)
    page.post_topic_submit_btn.wait_until_present
    page.post_topic_submit_btn_clk
  end
end

When(/^File got successfully uploaded in an Advanced Forum Topic by the Instructor$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.advancedforumname+'updated'
  end
  sleep(10)
  @uploadFileInstructorAdvForumTopicEndTimeStamp = Time.new.to_i * 1000
  sleep(5)
  moodle_logout
end

Then(/^An Event for Instructor Advanced Forum Assessable \(Topic File\) Uploaded should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @uploadFileInstructorAdvForumTopicStartTimeStamp
  @endTimeStamp = @uploadFileInstructorAdvForumTopicEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"hsuforum_assessable\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^The \['event'\]\.\['generated'\]\.\['name'\] = Provided Instructor Topic Subject$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].should == configatron.topicinstructorsubject
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum_assessable'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'hsuforum_assessable'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'hsuforum'
end

Given(/^Upload a File to a Topic under Advanced Forum as a Student$/) do
  #Create a discussion by student
  @currnetTimeStamp = Time.new.to_i * 1000
  @advancedForumId = configatron.advanced_forum_id

  @baseDir = File.absolute_path "./"
  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","testImage.jpg")

  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)

  @topicStudentSubject =  'at_topic_student_subject_'+@currnetTimeStamp.to_s
  @topicStudentMessage = 'Automated Topic Student Message'+@currnetTimeStamp.to_s
  configatron.topicstusubject = @topicStudentSubject
  configatron.topicstumessage = @topicStudentMessage
  @browser.goto(configatron.moodleURL+'/mod/hsuforum/view.php?id='+@advancedForumId)

  on CourseTopicPage do |page|
    page.topic_addanewdiscussion_btn.wait_until_present
    page.topic_addanewdiscussion_btn_clk

    @uploadFileStudentAdvForumTopicStartTimeStamp = Time.new.to_i * 1000
    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicStudentSubject

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys @topicStudentMessage
    sleep(3)

    @browser.file_field(:id,//).set(uploadfile_path)
    page.post_topic_submit_btn.wait_until_present

    page.post_topic_submit_btn_clk
  end
end

When(/^File got successfully uploaded in an Advanced Forum Topic by the Student$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.advancedforumname+'updated'
  end
  sleep(10)
  @uploadFileStudentAdvForumTopicEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Student Advanced Forum Assessable \(Topic File\) Uploaded should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @uploadFileStudentAdvForumTopicStartTimeStamp
  @endTimeStamp = @uploadFileStudentAdvForumTopicEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"hsuforum_assessable\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^The \['event'\]\.\['generated'\]\.\['name'\] = Provided Student Topic Subject$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].should == configatron.topicstusubject
end
