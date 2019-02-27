Given(/^Add Block a Comment for a Given Course$/) do

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
  @blockcomment = 'Block Comment by automation ' + @currnetTimeStamp.to_s

  on CourseDetailPage do |page|


   case configatron.environment

       when 'Master-DEV'
           #For Moodle Build Version 3.1 (Build: 20160523)
           begin
             page.course_turn_editing_link.wait_until_present
             page.course_turn_editing_link.click
             page.add_block_select.wait_until_present
             page.add_block_select.select 'Comments'
             page.add_block_comment_old_text.wait_until_present
             page.add_block_comment_old_text.set @blockcomment
             @addCommentStartTimeStamp = Time.new.to_i * 1000
             page.add_block_savecomment_old_link.click
           end

       when 'Master-PROD', 'Master-Staging'
           #For Moodle Build Version 3.2.3 (Build: 20170508)

           begin
             page.master_edit_dropdown.wait_until_present
             page.master_edit_dropdown.click
             page.course_turn_editing_link.wait_until_present
             page.course_turn_editing_link.click
             page.add_block_old_link.wait_until_present
             page.add_block_old_link.click
             page.add_block_comment_old_link.wait_until_present
             page.add_block_comment_old_link.click
             page.add_block_comment_old_text.wait_until_present
             page.add_block_comment_old_text.set @blockcomment
             @addCommentStartTimeStamp = Time.new.to_i * 1000
             page.add_block_savecomment_old_link.click
           end

   end

  end

end

When(/^Block Comment Got successfully Added for a Given Course$/) do
  on AssignmentViewPage do |page|
    sleep(10)
    # Should Assert that it got successfully saved
  end
  @addCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^A Block Comment Event for the Given Course should get generated and sent to our Raw Event Index$/) do
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


And(/^Block Comment Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Block Comment Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/MessageEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MessageEvent'

end

And(/^Block Comment Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Block Comment Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'

end

And(/^Block Comment Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Posted'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['@type'\] = 'h ttp:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['body'\] = Provided Block Comment$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].should == @blockcomment
end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'block_comments'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'block_comments'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseSection'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseOffering'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Block Comment Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^Block Comment Event \['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Block Comment Event \['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'

end

And(/^Block Comment Event \['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end


