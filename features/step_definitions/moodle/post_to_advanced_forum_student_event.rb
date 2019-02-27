Given(/^Submitted a Post under a Topic\(Discussion\) for a course$/) do
  #Create a topic(discussion) by teacher
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
  end
  moodle_logout

  #Submit a post by student
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  @topicStudentSubject =  'at_topic_student_subject_'+@currnetTimeStamp.to_s
  @topicStudentPost = 'Automated Topic Student Post'+@currnetTimeStamp.to_s
  sleep(10)
  @submitPostStartTimeStamp = Time.new.to_i * 1000
  configatron.topicstudentsubject = @topicStudentSubject
  configatron.topicstudentpost = @topicStudentPost
  @browser.goto(configatron.moodleURL+'/mod/hsuforum/view.php?id='+@advancedForumId)

  on CourseTopicPage do |page|
    sleep(3)
    @navigateToAdvancedForumDiscussionStartTimeStamp = Time.new.to_i * 1000
    page.topic_new_link_clk
    sleep(3)
    @navigateToAdvancedForumDiscussionEndTimeStamp = Time.new.to_i * 1000

    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicStudentSubject

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys @topicStudentPost

    page.post_topic_submit_btn_clk
  end

end

When(/^The Post got successfully submitted$/) do
  on CourseItemPage do |page|
    page.student_post_txt.text.should == @topicStudentPost
  end
  configatron.post_id = get_item_id()
  sleep(10)
  @submitPostEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for student post should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"hsuforum_post\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'hsuforum'
end

And(/^\['event'\]\.\['generated'\]\.\['@id'\] value includes the post id submitted by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include? configatron.post_id
end

And(/^\['event'\]\.\['generated'\]\.\['name'\] includes the student post subject name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].include? @topicStudentSubject
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum_post'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'hsuforum_post'
end

And(/^\['event'\]\.\['generated'\]\.\['count'\] = '1'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['count'].should == 1
end

Then(/^An Event for Navigate to Advanced Forum Discussion should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @navigateToAdvancedForumDiscussionStartTimeStamp
  @endTimeStamp = @navigateToAdvancedForumDiscussionEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.moduleType\":\"hsuforum_discussions\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum_discussions'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'hsuforum_discussions'
end

Then(/^An Event for student advanced forum post should get generated and sent to CSV\.$/) do
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

And(/^Student Advanced Forum Post CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Student Advanced Forum Post CSV \['Page'\] Column Value = 'hsuforum_post'$/) do
  @latest_record['Page'].should == 'hsuforum_post'
end

And(/^Student Advanced Forum Post CSV \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @latest_record['Activity Type'].should == 'hsuforum'
end

And(/^Student Advanced Forum Post CSV \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @latest_record['Activity Name'].should == configatron.advancedforumname+'updated'
end

And(/^Student Advanced Forum Post CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for student advanced forum post should get generated and sent to Tableau\.$/) do
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

And(/^Student Advanced Forum Post Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Student Advanced Forum Post Tableau \['Page'\] Column Value = 'hsuforum_post'$/) do
  @newest_record['Page'].should == 'hsuforum_post'
end

And(/^Student Advanced Forum Post Tableau \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @newest_record['ActivityType'].should == 'hsuforum'
end

And(/^Student Advanced Forum Post Tableau \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @newest_record['ActivityName'].should == configatron.advancedforumname+'updated'
end

And(/^Student Advanced Forum Post Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
