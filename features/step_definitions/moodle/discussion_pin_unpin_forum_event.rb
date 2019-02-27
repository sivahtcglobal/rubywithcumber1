Given(/^Unpin a Forum Discussion for a Given Course$/) do
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

  @browser.goto(configatron.moodleURL+'/mod/forum/view.php?id='+@forumId)
  sleep(3)

  on CourseForumDiscussionPage do |page|
    page.teacher_discussion_link(configatron.topicteachersubjectupdated).click
    sleep(2)
    @unpinDiscussionStartTimeStamp = Time.new.to_i * 1000
    sleep(3)
    page.pin_unpin_btn.click
    sleep(5)
    @unpinDiscussionEndTimeStamp = Time.new.to_i * 1000
    sleep(5)
  end
end

When(/^Forum Discussion Got successfully Unpinned for a Given Course$/) do
  on CourseForumDiscussionPage do |page|
    page.pin_unpin_btn.text.should == 'Pin'
  end
end

Then(/^Forum Discussion Unpinned Event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @unpinDiscussionStartTimeStamp
  @endTimeStamp = @unpinDiscussionEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Unpinned\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Unpinned'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Unpinned'
end

Given(/^Pin a Forum Discussion for a Given Course$/) do
  on CourseForumDiscussionPage do |page|
    @pinDiscussionStartTimeStamp = Time.new.to_i * 1000
    sleep(3)
    page.pin_unpin_btn.click
    sleep(5)
    @pinDiscussionEndTimeStamp = Time.new.to_i * 1000
    sleep(5)
  end
end

When(/^Forum Discussion Got successfully Pinned for a Given Course$/) do
  on CourseForumDiscussionPage do |page|
    page.pin_unpin_btn.text.should == 'Unpin'
  end
end

Then(/^Forum Discussion Pinned Event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @pinDiscussionStartTimeStamp
  @endTimeStamp = @pinDiscussionEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Pinned\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/ForumEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/ForumEvent'
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Pinned'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Pinned'
end
