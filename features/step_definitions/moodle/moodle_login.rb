Given(/^I am logging in as an Student in Moodle$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @stu_username =  configatron.autoStudentUname
  @stu_password = configatron.autoStudentPwd
  log_in_moodle(@stu_username,@stu_password)
end


When(/^I am Successfully logged in to the Moodle$/) do

  on MoodleHomePage do |page|

    page.profile_dropdown.wait_until_present
    page.profile_dropdown.exists?.should be true

  end

end

Then(/^An login event should get successfully sent to the Raw Index$/) do
  ENV['TZ'] = 'UTC'

  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000 + @streamDelayTime

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#LoggedIn\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']

  @hits.should == 1

end

And(/^The event should have \['event\.action'\] value as \['http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#LoggedIn'\]$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#LoggedIn'
end

And(/^The event should have \['event\.@type'\] value as \['http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SessionEvent'\]$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SessionEvent'
end

Given(/^I am logging out of the Moodle$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  moodle_logout
end


When(/^I am Successfully Logout from Moodle$/) do
  on MoodleLoginPage do |page|

    page.login_link.wait_until_present
    page.login_link.exists?.should be true

  end
end

Then(/^An logout event should get successfully sent to the Raw Index$/) do

  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000 + @streamDelayTime

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#LoggedOut\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']

  @hits.should == 1

end

And(/^The event should have \['event\.action'\] value as \['http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#LoggedOut'\]$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#LoggedOut'
end

