Given(/^View Notes of a Participant as an instructor$/) do

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

  on CourseDetailPage do |page|

   case configatron.environment

       when 'Master-DEV'
           #For Moodle Build Version 3.1 (Build: 20160523)
         begin

           page.participants_old_link.wait_until_present
           page.participants_old_link.click
           page.participants_stud_link("sname_").wait_until_present
           page.participants_stud_link("sname_").click

           @addCommentStartTimeStamp = Time.new.to_i * 1000

           page.participants_notes_link.wait_until_present
           page.participants_notes_link.click

         end

       when 'Master-PROD', 'Master-Staging'
           #For Moodle Build Version 3.2.3 (Build: 20170508)
         begin

           page.participants_link.wait_until_present
           page.participants_link.click
           page.participants_stud_link("sname_").wait_until_present
           page.participants_stud_link("sname_").click

           @addCommentStartTimeStamp = Time.new.to_i * 1000

           page.participants_notes_link.wait_until_present
           page.participants_notes_link.click

         end

   end

  end

end

When(/^Notes list page got viewed by an instructor$/) do
  on CourseDetailPage do |page|
    # page.participants_add_notes_link.wait_until_present
    # page.participants_add_notes_link.exists?.should be_true    # Should Assert that it got successfully saved
  end
  sleep(configatron.eventWaitTime)
  @addCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^Instructor Note viewed Event should get generated and sent to our Raw Event Index$/) do
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
  @hits.should == 1
end


And(/^Instructor Notes viewed Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Event'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Event'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Viewed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['object'\]\.\['@type'\] = 'h ttp:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'notes'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should  == 'notes'
end

And(/^Instructor Notes viewed Event \['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Instructor Notes viewed Event \['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'

end

And(/^Instructor Notes viewed Event \['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end

