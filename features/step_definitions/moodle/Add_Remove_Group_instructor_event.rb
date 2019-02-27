Given(/^Login as valid instructor-Group$/) do
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

Then(/^Create New Grouping name and Save grouping-group$/) do
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

Then(/^Add the Group for the Users$/) do
  on CourseGroupingPage do |page|
    @browser.goto(configatron.moodleURL + '/group/index.php?id=' + configatron.courseId)
   page.create_group.click
    page.group_name.set 'groupname'+"#{@currnetTimeStamp}"
    page.group_number.set "#{@currnetTimeStamp}"
    page.group_save.click
  end
end

   Then(/^Add Group in Grouping$/) do
     @browser.goto(configatron.moodleURL + '/group/groupings.php?id=' + configatron.courseId)
     on CourseGroupingPage do |page|
       puts 'autogrouping'+"#{@currnetTimeStamp}"
       row=0
       until page.group_table(row)== 'autogrouping'+"#{@currnetTimeStamp}"
         puts row
         row+=1
       end
       page.group_people(row).click
       page.group_select('groupname'+"#{@currnetTimeStamp}").click
       @startTimeStamp = Time.new.to_i * 1000
       page.add_group.click
     end
   end

 Then(/^Group Event should generated and send to Raw index$/) do
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

And(/^\['GROUP'\]\.\['event'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['GROUP'\]\.\['event'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Event'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Event'end

And(/^\['GROUP'\]\.\['event'\]\.\['action'\] == 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action#Added'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Added'
end
And(/^\['GROUP'\]\.\['event'\]\.\['action'\] == 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action#Removed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Removed'
end

And(/^\['GROUP'\]\.\['event'\]\.\['actor'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['GROUP'\]\.\['event'\]\.\['actor'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^\['GROUP'\]\.\['event'\]\.\['edApp'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['GROUP'\]\.\['event'\]\.\['edApp'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^\['GROUP'\]\.\['event'\]\.\['edApp'\]\.\['name'\] == 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end

And(/^\['GROUP'\]\.\['event'\]\.\['extensions'\]\.\['group'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['group']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['GROUP'\]\.\['event'\]\.\['extensions'\]\.\['group'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['group']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['GROUP'\]\.\['event'\]\.\['extensions'\]\.\['group'\]\.\['extensions'\]\.\['moduleType'\] == 'group'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['group']['extensions']['moduleType'].should == 'group'
end

And(/^\['GROUP'\]\.\['event'\]\.\['extensions'\]\.\['moduleType'\] == 'grouping_group'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['moduleType'].should == 'grouping_group'
end

And(/^\['GROUP'\]\.\['event'\]\.\['object'\]\.\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['GROUP'\]\.\['event'\]\.\['object'\]\.\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['GROUP'\]\.\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] == 'grouping$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'grouping'
end

Then(/^Remove added Group for the user$/) do
  on CourseGroupingPage do |page|
    page.group_select1('groupname'+"#{@currnetTimeStamp}").click
    @startTimeStamp = Time.new.to_i * 1000
    page.remove_group.click
  end
end

Then(/^Group Event should generated for Removed and send to Raw index$/) do
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



