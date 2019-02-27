Given(/^Updated an Advanced Forum Discussion for a course$/) do
  #Update a discussion by teacher
  @currnetTimeStamp = Time.new.to_i * 1000
  @advancedForumId = configatron.advanced_forum_id

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
  configatron.topicteachersubject = @topicTeacherSubject
  configatron.topicteacherpost = @topicTeacherPost
  configatron.topicteachersubjectupdated = @topicTeacherSubject + 'updated'
  configatron.topicteacherpostupdated = @topicTeacherPost + 'updated'
  @browser.goto(configatron.moodleURL+'/mod/hsuforum/view.php?id='+@advancedForumId)

  on CourseTopicPage do |page|
    page.topic_addanewdiscussion_btn_clk

    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicTeacherSubject

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys @topicTeacherPost

    page.post_topic_submit_btn_clk

    configatron.discussion_id = get_item_id()

    page.teacher_discussion_link(configatron.topicteachersubject).click
    page.edit_link.click

    sleep(5)
    @editDiscussionStartTimeStamp = Time.new.to_i * 1000
    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys configatron.topicteachersubjectupdated

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys configatron.topicteacherpostupdated
    @browser.execute_script('arguments[0].scrollIntoView();', page.topic_post)

    page.submit_btn_clk
    sleep(5)
  end
end

When(/^The Advanced Forum Discussion got successfully updated$/) do

  on CourseItemPage do |page|
    (page.teacher_subject_txt.text).include? configatron.topicteachersubjectupdated
  end
  sleep(10)
  @editDiscussionEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for Advanced Forum discussion should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"hsuforum_discussion\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['generated'\]\.\['@id'\] value includes the advanced forum discussion id updated by instructor$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include? configatron.discussion_id
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] includes the updated advanced forum discussion name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].include? configatron.topicteachersubjectupdated
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum_discussion'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'hsuforum_discussion'
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'hsuforum'
end

Given(/^Updated a Post under an Advanced Forum Discussion for a course$/) do
  #Update a post by student
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  @topicStudentSubject =  'at_topic_student_subject_'+@currnetTimeStamp.to_s
  @topicStudentPost = 'Automated Topic Student Post'+@currnetTimeStamp.to_s
  sleep(10)
  configatron.topicstudentpost = @topicStudentPost
  configatron.topicstudentpostupdated = @topicStudentPost + 'updated'
  configatron.topicstudentsubject = @topicStudentSubject
  configatron.topicstudentsubjectupdated = @topicStudentSubject + 'updated'
  @browser.goto(configatron.moodleURL+'/mod/hsuforum/view.php?id='+configatron.advanced_forum_id)

  on CourseTopicPage do |page|
    page.topic_new_link_clk

    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicStudentSubject

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys @topicStudentPost

    page.post_topic_submit_btn_clk

    configatron.post_id = get_item_id()

    @browser.execute_script('arguments[0].scrollIntoView();', page.reply_btn)
    page.edit_link.click
    sleep(3)

    @editPostStartTimeStamp = Time.new.to_i * 1000
    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys configatron.topicstudentsubjectupdated

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys configatron.topicstudentpostupdated

    page.post_topic_submit_btn_clk
  end
end


When(/^The Advanced Forum Post got successfully updated$/) do

  on CourseItemPage do |page|
    page.student_updated_post_txt.text.should == configatron.topicstudentpostupdated
  end
  sleep(10)
  @editPostEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for student Advanced Forum post should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"hsuforum_post\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['generated'\]\.\['@id'\] value includes the advanced forum post id updated by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include? configatron.post_id
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] includes the updated student advanced forum post subject name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].include? configatron.topicstudentsubjectupdated
end

Then(/^An Event for update student advanced forum post should get generated and sent to CSV\.$/) do
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

Then(/^An Event for update student advanced forum post should get generated and sent to Tableau\.$/) do
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
