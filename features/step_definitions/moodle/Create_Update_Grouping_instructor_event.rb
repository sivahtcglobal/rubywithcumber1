Given(/^Login as valid instructor-Grouping$/) do
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


Then(/^Create New Grouping name and Save grouping$/) do
 on CourseGroupingPage do |page|

         @browser.goto(configatron.moodleURL + '/group/groupings.php?id=' + configatron.courseId)
         page.grouping_icon.wait_until_present
         page.grouping_icon.click
         page.group_name.set 'autogrouping'+"#{@currnetTimeStamp}"
         page.group_number.set "#{@currnetTimeStamp}"
         @startTimeStamp = Time.new.to_i * 1000
         page.group_save.click
end
end
Then(/^Grouping Event should generated and send to Raw index$/) do
   ENV['TZ'] = 'UTC'
   #Get API Token for Preceding POST Requests
   @tokenhost = configatron.moodleWorkbench
   @tokenuser = configatron.tokenuser
   @tokenpass = configatron.tokenpass
   @intellistream = configatron.moodleEntityStream
   @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
   @posturl =  File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
   @streamDelayTime = configatron.streamDelayTime
   @endTimeStamp = Time.new.to_i * 1000
   @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

@response = post_request(@posturl,@query,@apitoken)

puts @response.to_json

@hits = @response['hits']['total']
# @hits.should_not == 0
@hits.should == 1
    end

And(/^\['GROUPING'\]\.\['entity'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Entity'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Entity'
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['extensions'\]\.\['edApp'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['extensions'\]\.\['edApp'\]\.\['@id'\] == 'http:\/\/moodleserver\.dev\.master\.us\-west\-2\.prod\.aws\.intellify\.io'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@id'].should == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['extensions'\]\.\['edApp'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['extensions'\]\.\['edApp'\]\.\['name'\] == 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['name'].should == 'IntellifyLearning'
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['extensions'\]\.\['moduleType'\] == 'grouping'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'grouping'
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['extensions'\]\.\['idname'\] == 'grouping'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['idNumber'].should == "#{@currnetTimeStamp}"
end

And(/^\['GROUPING'\]\.\['entity'\]\.\['name'\] == 'grouping'$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == 'autogrouping'+"#{@currnetTimeStamp}"

  And(/^\['GROUPING'\]\.\['entity'\]\.\['name'\] == 'groupingupdate'$/) do
    @response['hits']['hits'][0]['_source']['entity']['name'].should == 'autogroupingupdate'+"#{@currnetTimeStamp}"
end

Then(/^Update Created Grouping name and Save grouping$/) do
  on CourseGroupingPage do |page|
    @browser.goto(configatron.moodleURL + '/group/groupings.php?id=' + configatron.courseId)
    page.grouping_icon.wait_until_present
    row=0
    until page.group_table(row)== 'autogrouping'+"#{@currnetTimeStamp}"
      puts row
      row+=1
    end
    page.group_edit(row).click
    page.group_name.set 'autogroupingupdate'+"#{@currnetTimeStamp}"
    page.group_number.set "#{@currnetTimeStamp}"
    @startTimeStamp = Time.new.to_i * 1000
    page.group_save.click
  end
end

Then(/^Grouping Event should generated for Update and send to Raw index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl =  File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @endTimeStamp = Time.new.to_i * 1000
  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
  end
end