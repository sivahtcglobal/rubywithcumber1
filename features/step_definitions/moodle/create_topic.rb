Given(/^Added a New Topic\(Discussion\) under Advanced Forum for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @advancedForumId = configatron.advanced_forum_id

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

  @topicSubject =  'at_topic_subject_'+@currnetTimeStamp.to_s
  @topicPost = 'Automated Topic Post'+@currnetTimeStamp.to_s
  sleep(10)
  @createTopicStartTimeStamp = Time.new.to_i * 1000
  configatron.topicsubject = @topicSubject
  configatron.topicpost = @topicPost
  @browser.goto(configatron.moodleURL+'/mod/hsuforum/view.php?id='+@advancedForumId)

  on CourseTopicPage do |page|

    page.topic_addanewdiscussion_btn_clk

    page.topic_subject.click
    page.topic_subject.send_keys [:control, 'a']
    page.topic_subject.send_keys @topicSubject

    page.topic_post.click
    page.topic_post.send_keys [:control, 'a']
    page.topic_post.send_keys @topicPost

    page.post_topic_submit_btn_clk

  end
end

When(/^The New Topic got successfully added$/) do

  on CourseItemPage do |page|
    page.topic_subject_link.text.should == @topicSubject
  end
  sleep(10)
  configatron.topic_id = get_item_id()
  @createTopicEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for New Topic should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @createTopicStartTimeStamp
  @endTimeStamp = @createTopicEndTimeStamp


  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.moduleType\":\"hsuforum_discussion\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'hsuforum'
end

And(/^The \['event'\]\.\['generated'\]\.\['@id'\] value includes the topic id created by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include? configatron.topic_id
end

And(/^The \['event'\]\.\['generated'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

And(/^The \['event'\]\.\['generated'\]\.\['name'\] = Provided value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['name'].should == configatron.topicsubject
end

And(/^The \['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum_discussion'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'hsuforum_discussion'
end

Then(/^An Event for student create topic should get generated and sent to CSV\.$/) do
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

And(/^Student Create Topic CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Student Create Topic CSV \['Page'\] Column Value = 'hsuforum_discussion'$/) do
  @latest_record['Page'].should == 'hsuforum_discussion'
end

And(/^Student Create Topic CSV \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @latest_record['Activity Type'].should == 'hsuforum'
end

And(/^Student Create Topic CSV \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @latest_record['Activity Name'].should == configatron.advancedforumname+'updated'
end

And(/^Student Create Topic CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for student create topic should get generated and sent to Tableau\.$/) do
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

And(/^Student Create Topic Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Student Create Topic Tableau \['Page'\] Column Value = 'hsuforum_discussion'$/) do
  @newest_record['Page'].should == 'hsuforum_discussion'
end

And(/^Student Create Topic Tableau \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @newest_record['ActivityType'].should == 'hsuforum'
end

And(/^Student Create Topic Tableau \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @newest_record['ActivityName'].should == configatron.advancedforumname+'updated'
end

And(/^Student Create Topic Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
