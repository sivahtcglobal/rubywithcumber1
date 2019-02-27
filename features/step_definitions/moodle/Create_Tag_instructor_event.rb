Given(/^Login as valid instructor$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
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
  end

Then(/^Click on the Edit setting page and Create new Tag$/) do
  on AssignmentViewPage do |page|
    @browser.goto(configatron.moodleURL + '/course/view.php?id=' + configatron.courseId)
  page.assignment_edit_link.click
  page.send_keys :page_down
  page.send_keys :page_down
  sleep(5)
  page.tag_clk.click
end
end

Then(/^Add Tag for the Instructor and Save the Changes$/) do
  on AssignmentViewPage do |page|
     page.tag_value.wait_until_present
     @timestamp = Time.new.to_i * 1000
     page.tag_value.set 'tag'+"#{@timestamp}"
     page.send_keys :enter
     @startTimeStamp = Time.new.to_i * 1000
     page.save_display.click
     @tokenhost = configatron.moodleWorkbench
     @tokenuser = configatron.tokenuser
     @tokenpass = configatron.tokenpass
     @intellistream = configatron.moodleEntityStream
     @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
     @posturl =  File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
     @streamDelayTime = configatron.streamDelayTime
     sleep(5)
     @endTimeStamp = Time.new.to_i * 1000
     @query1 = "{\"query\":{\"filtered\":{\"filter\":{\"and\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}},{\"term\":{\"entity.@type\":\"http://purl.imsglobal.org/caliper/v1/Entity\"}}]}}}}"
     puts @query1
     @response = post_request(@posturl,@query1,@apitoken)

     puts @response.to_json

     @hits = @response['hits']['total']
     @hits.should == 1
     @posturl = 'https://moodlestatic.intellifydev.net/intellisearch/data-moodle-manualtest-event-eventdata-5a69a47937c1225c01fd5bc4/_search'
     @query2 = "{\"query\":{\"filtered\":{\"filter\":{\"and\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}},{\"term\":{\"event.@type\":\"http://purl.imsglobal.org/caliper/v1/Event\"}}]}}}}"
     puts @query2
     @response1 = post_request(@posturl,@query2,@apitoken)
  end
end
Then (/^Remove Tag for the Instructor and Save the Changes$/) do
  on AssignmentViewPage do |page|
    @tagname = 'tag'+"#{@timestamp}"
    page.assignment_edit_link.click
    page.send_keys :page_down
    page.send_keys :page_down
    page.tag_clk.click
    sleep(3)
    page.tag_remove(@tagname).click
    @startTimeStamp = Time.new.to_i * 1000
    page.save_display.click
    @endTimeStamp = Time.new.to_i * 1000
    @tokenhost = configatron.moodleWorkbench
    @tokenuser = configatron.tokenuser
    @tokenpass = configatron.tokenpass
    @intellistream = configatron.moodleEventStream
    @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
    @posturl =  File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
    @streamDelayTime = configatron.streamDelayTime
    sleep(5)
    @query3 = "{\"query\":{\"filtered\":{\"filter\":{\"and\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}},{\"term\":{\"event.@type\":\"http://purl.imsglobal.org/caliper/v1/Event\"}}]}}}}"
    puts @query3
    @response2 = post_request(@posturl,@query3,@apitoken)
    end
end
And(/^\['entity' \]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['entity' \]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Entity'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Entity'
end

And(/^\['entity' \]\.\['extensions' \]\.\['edApp' \]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['entity' \]\.\['extensions' \]\.\['edApp' \]\.\['@id'\] == 'http:\/\/moodleserver\.dev\.master\.us\-west\-2\.prod\.aws\.intellify\.io'$/) do |arg|
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@id'].should == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
end

And(/^\['entity' \]\.\['extensions' \]\.\['edApp' \]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^\['entity' \]\.\['extensions' \]\.\['edApp' \]\.\['name'\] == 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['name'].should == 'IntellifyLearning'
end

And(/^\['entity' \]\.\['extensions' \]\.\['moduleType'\] == 'tag'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'tag'
end

And(/^\['entity' \]\.\['extensions' \]\.\['rawname'\] == 'tag'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['rawname'].should == 'tag'+"#{@timestamp}"
end

And(/^\['entity' \]\.\['name'\] == 'tag'$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == 'tag'+"#{@timestamp}"
end
# Add Tag Event data Validation

And(/^\['event'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response1['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Event'$/) do
  @response1['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Event'
end

And(/^\['event'\]\.\['action'\] == 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Added'$/) do
  @response1['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Added'
end

And(/^\['event'\]\.\['actor'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response1['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['actor'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response1['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^\['event'\]\.\['edApp'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response1['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['edApp'\]\.\['@id'\] == 'http:\/\/moodleserver\.dev\.master\.us\-west\-2\.prod\.aws\.intellify\.io'$/) do
  @response1['hits']['hits'][0]['_source']['event']['edApp']['@id'].should == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
end

And(/^\['event'\]\.\['edApp'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response1['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^\['event'\]\.\['edApp'\]\.\['name'\] == 'IntellifyLearning'$/) do
  @response1['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end

And(/^\['event'\]\.\['extensions'\]\.\['entity'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response1['hits']['hits'][0]['_source']['event']['extensions']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['extensions'\]\.\['entity'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response1['hits']['hits'][0]['_source']['event']['extensions']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['event'\]\.\['extensions'\]\.\['moduleType'\] == 'course'$/) do
  @response1['hits']['hits'][0]['_source']['event']['extensions']['moduleType'].should == 'course'
end

And(/^\['event'\]\.\['object'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response1['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['object'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response1['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] == 'tab'$/) do
  @response1['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'tab'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['name'\] == 'tag'$/) do
  @response1['hits']['hits'][0]['_source']['event']['object']['extensions']['name'].should == 'tag'+"#{@timestamp}"
end