Given(/^Created a New BigBlueButton for a course$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New BigBlueButton for #{@courseId}"
  @bigBlueButtonName = 'BigBlueButtonAuto_' + @currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.bigbluebuttonname = @bigBlueButtonName
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

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
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=bigbluebuttonbn&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseBigBlueButtonPage do |page|

    #General settings
    page.show_more_link.wait_until_present
    page.show_more_link.click
    page.virtual_classroom_name_txt.set @bigBlueButtonName
    page.description_txt.send_keys  @bigBlueButtonName + ' Description'
    page.show_description_chkbox.click
    page.welcome_message_txt.send_keys @bigBlueButtonName + ' Welcome'
    page.wait_moderator_chkbox.click
    page.tagging_chkbox.click
    page.send_notification_chkbox.click

    #Participants
    page.participants_link.click
    page.bigbluebuttonbn_participant_selection_type_select.select 'All users enrolled'
    page.addselection_btn.click
    page.all_participant_list_role_select.select 'Moderator'
    page.user_list_role_select.select 'Moderator'

    #Schedule for session
    page.schedule_for_session_link.click
    page.start_enable_chkbox.click
    page.end_enable_chkbox.click
    page.end_year_select.select '2019'

    #Common module settings
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set @currnetTimeStamp
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

    #Restrict access
    #page.restrict_access_link.click

    #Activity completion
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Students can manually mark the activity as completed'
    page.activity_completion_expected_chkbox.click
    page.activity_completion_year_select.select '2019'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    #Competencies
    page.competencies_link.click
    page.competency_rule_select.select 'Send for review'
    @startTimeStamp = Time.new.to_i * 1000
    page.bigbluebutton_saveanddisplay_btn_clk
  end
end

When(/^The New BigBlueButton got successfully created$/) do

  on CourseItemPage do |page|
    page.error_continue_link.click if page.error_continue_link.exists?
    page.course_item_breadcrumb.wait_until_present
    page.course_item_breadcrumb.text.should == @bigBlueButtonName
  end
  configatron.bigbluebutton_id = get_item_id()

end

Then(/^A Course Entity for New BigBlueButton should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"
  puts @posturl
  puts @apitoken
  puts @query
  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = BigBlueButton Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @bigBlueButtonName
end

And(/^\['entity'\]\.\['extensions'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'bigbluebuttonbn'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'bigbluebuttonbn'
end

And(/^\['entity'\]\.\['extensions'\]\.\['groupMode'\] = Provided Group$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'visible'
end

And(/^\['entity'\]\.\['extensions'\]\.\['completionTracking'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'].should == 'manual'
end

And(/^\['entity'\]\.\['extensions'\]\.\['requireView'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireView'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['requireGrade'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireGrade'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Provided Expected Completion Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2019'
end

And(/^\['entity'\]\.\['extensions'\]\.\['participants'\]\.\[0\]\.\['type'\] = 'all'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['participants'][0]['type'].should == 'all'
end

And(/^\['entity'\]\.\['extensions'\]\.\['participants'\]\.\[0\]\.\['id'\] = 'all'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['participants'][0]['type'].should == 'all'
end

And(/^\['entity'\]\.\['extensions'\]\.\['joinClosed'\] = Provided Join Closed Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['joinClosed'].include? '2019'
end

Given(/^Updated the Existing BigBlueButton for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @bigBlueButtonId = configatron.bigbluebutton_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?sr&return=1&update="+@bigBlueButtonId)
  @bigBlueButtonName = configatron.bigbluebuttonname+'updated'

  on CourseBigBlueButtonPage do |page|

    #Update Name
    page.show_more_link.wait_until_present
    page.show_more_link.click
    page.virtual_classroom_name_txt.clear
    page.virtual_classroom_name_txt.set @bigBlueButtonName
    page.description_txt.send_keys  @bigBlueButtonName + ' Description'

    #Update schedule for session
    page.end_year_select.select '2020'

    #Update Common module settings
    page.common_module_settings_link.click
    page.common_module_group_mode_select.select 'Separate groups'

    #Update Activity completion
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_completion_view_chkbox.click
    page.activity_completion_year_select.select '2020'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    #Update Competencies
    page.competencies_link.click
    page.bigbluebutton_saveanddisplay_btn_clk

  end
end

When(/^The Existing BigBlueButton got successfully updated$/) do

  on CourseItemPage do |page|
    page.error_continue_link.click if page.error_continue_link.exists?
    page.course_item_breadcrumb.text.should == @bigBlueButtonName
  end
  moodle_logout
end

Then(/^A Course Entity for Update BigBlueButton should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = BigBlueButton Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @bigBlueButtonName
end

And(/^\['entity'\]\.\['extensions'\]\.\['groupMode'\] = Updated Group$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'separate'
end

And(/^\['entity'\]\.\['extensions'\]\.\['completionTracking'\] = Updated Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'].should == 'conditions'
end

And(/^\['entity'\]\.\['extensions'\]\.\['requireView'\] = Updated Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireView'].should == true
end

And(/^\['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Updated Expected Completion Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2020'
end

And(/^\['entity'\]\.\['extensions'\]\.\['joinClosed'\] = Updated Join Closed Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['joinClosed'].include? '2020'
end
