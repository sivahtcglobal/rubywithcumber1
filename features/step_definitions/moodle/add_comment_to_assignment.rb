Given(/^Add Comment to Assignment for a Given Course$/) do
  ENV['TZ'] = 'UTC'
  @currnetTimeStamp = Time.new.to_i * 1000
  @assignmentId = 397
  @assignmentId = configatron.assignmentId unless configatron.assignmentId == nil

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

  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + @assignmentId.to_s)
  @assincomment = 'Auto Comment' + @currnetTimeStamp.to_s
  on AssignmentViewPage do |page|


    page.assignment_all_sub_link.wait_until_present
    page.assignment_all_sub_link.click
    page.assignment_comment_link.click unless page.assignment_content_txt.visible?
    page.assignment_comment_link.click unless page.assignment_content_txt.visible?
    page.assignment_content_txt.set @assincomment

    @addCommentStartTimeStamp = Time.new.to_i * 1000
    page.assignment_save_comment_link.click

  end

end

When(/^Comment Got successfully Added to the Assignment for a Given Course$/) do
  on AssignmentViewPage do |page|
    # page.saved_successful_msg.exists?.should be_true
    # page.confirm_ok_btn.click
    #   @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + @assignmentId.to_s)
  end
  sleep(configatron.eventWaitTime)
  @addCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^A Assignment Comment Event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @addCommentStartTimeStamp
  @endTimeStamp = @addCommentEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end


And(/^Assignment Comment Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Comment Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/MessageEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
end

And(/^Assignment Comment Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Comment Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^Assignment Comment Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Posted'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
end

And(/^Assignment Comment Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Assignment Comment Event \['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'
end

And(/^Assignment Comment Event \['event'\]\.\['object'\]\.\['body'\] = Provided Comment$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].should == @assincomment
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'assign_comment'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'assign_comment'
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['assignable'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['assignable']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['assignable'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['assignable']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'assign'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['assignable']['extensions']['moduleType'].should == 'assign'
end
