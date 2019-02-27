Given(/^View Message as a Student sent by an Instructor$/) do

  ENV['TZ'] = 'UTC'
  @currnetTimeStamp = Time.new.to_i * 1000

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

  on MoodleHomePage do |page|

   case configatron.environment

       when 'Master-DEV'
           #For Moodle Build Version 3.1 (Build: 20160523)
         begin
           page.profile_dropdown_click
           page.message_old_link.wait_until_present
           page.message_old_link.click

           page.message_old_view_link.wait_until_present
           @addCommentStartTimeStamp = Time.new.to_i * 1000

           page.message_old_view_link.click

         end

       when 'Master-PROD', 'Master-Staging'
           #For Moodle Build Version 3.2.3 (Build: 20170508)
         begin

           page.message_icon_img.wait_until_present
           page.message_icon_img.click
           page.message_link.wait_until_present

           @addCommentStartTimeStamp = Time.new.to_i * 1000

           page.message_link.click

         end

   end

  end

end

When(/^Message got viewed by the Student$/) do
  on MoodleHomePage do |page|
    # page.participants_add_notes_link.wait_until_present
    # page.participants_add_notes_link.exists?.should be_true    # Should Assert that it got successfully saved
  end
  sleep(configatron.eventWaitTime)
  @addCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^Student Message Viewed Event should get generated and sent to our Raw Event Index$/) do
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

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"and\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}},{\"term\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}}]}}}}"
  puts @query.to_json
  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  @hits.should > 0
end


And(/^Student Message Viewed Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Student Message Viewed Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Event'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Event'

end

And(/^Student Message Viewed Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Student Message Viewed Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'

end

And(/^Student Message Viewed Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Viewed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'

end

And(/^Student Message Viewed Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Student Message Viewed Event \['event'\]\.\['object'\]\.\['@type'\] = 'h ttp:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'

end

And(/^Student Message Viewed Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should  == 'message'
end

And(/^Student Message Viewed Event \['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Student Message Viewed Event \['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'

end

And(/^Student Message Viewed Event \['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end

