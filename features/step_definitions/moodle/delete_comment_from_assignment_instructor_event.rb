Given(/^Deleted Comment from Assignment for a course$/) do
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

  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id='+@assignmentId.to_s)

  on AssignmentViewPage do |page|
    page.assignment_all_sub_link.wait_until_present
    page.assignment_all_sub_link.click
    page.expand_comment_link.click if page.expand_comment_link.exist?
    page.delete_comment_link.wait_until_present
    @deleteCommentStartTimeStamp = Time.new.to_i * 1000
    page.delete_comment_link.click
  end
end

When(/^The Comment got successfully deleted by instructor$/) do

  on AssignmentViewPage do |page|
    #sleep(3)
  end
  sleep(configatron.eventWaitTime)
  @deleteCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for Delete Comment should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @startTimeStamp = @deleteCommentStartTimeStamp
  @endTimeStamp = @deleteCommentEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Deleted'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Deleted'
end

And(/^\['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/MessageEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/MessageEvent'
end

And(/^\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'assign_comment'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'assign_comment'
end
