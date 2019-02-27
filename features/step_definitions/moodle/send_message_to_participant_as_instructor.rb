Given(/^Send Message to a Participant as an instructor$/) do

  ENV['TZ'] = 'UTC'
  @currnetTimeStamp = Time.new.to_i * 1000
  @course_Id = 397
  @course_Id = configatron.courseId unless configatron.courseId == nil

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

  @browser.goto(configatron.moodleURL + '/course/view.php?id=' + configatron.courseId)
  @message = 'Instructor Message by automation ' + @currnetTimeStamp.to_s

  on CourseDetailPage do |page|

   case configatron.environment

       when 'Master-DEV'
           #For Moodle Build Version 3.1 (Build: 20160523)
         begin

           page.participants_old_link.wait_until_present
           page.participants_old_link.click
           page.participants_stud_link("sname_").wait_until_present
           page.participants_stud_link("sname_").click
           page.participants_msg_link.wait_until_present
           page.participants_msg_link.click
           page.msg_text.wait_until_present
           page.msg_text.set @message
           @addCommentStartTimeStamp = Time.new.to_i * 1000
           page.msg_send_old_btn.click
         end

       when 'Master-PROD', 'Master-Staging'
           #For Moodle Build Version 3.2.3 (Build: 20170508)
         begin

           page.participants_link.wait_until_present
           page.participants_link.click
           page.participants_stud_link("sname_").wait_until_present
           page.participants_stud_link("sname_").click
           page.participants_msg_link.wait_until_present
           page.participants_msg_link.click
           page.msg_text.wait_until_present
           page.msg_text.set @message
           @addCommentStartTimeStamp = Time.new.to_i * 1000
           page.msg_send_btn.click
         end

   end

  end

end

When(/^Message got created to a Participant as an instructor$/) do
  on AssignmentViewPage do |page|

    # Should Assert that it got successfully saved
  end
  sleep(20)
  @addCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^Instructor Message creation Event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @startTimeStamp = @addCommentStartTimeStamp
  @endTimeStamp = @addCommentEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"
  puts @query.to_json
  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should > 0
end


And(/^Instructor Message Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Message Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/MessageEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MessageEvent'

end

And(/^Instructor Message Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Message Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'

end

And(/^Instructor Message Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Posted'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['@type'\] = 'h ttp:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['body'\] = Provided Instructor Message$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].should == @message
end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['subject'\] include 'New message from'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['subject'].should include 'New message from'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseSection'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseOffering'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Message Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^Instructor Message Event \['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Instructor Message Event \['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'

end

And(/^Instructor Message Event \['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end


