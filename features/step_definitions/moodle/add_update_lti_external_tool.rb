Given(/^Added a New LTI External Tool for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil

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

  @activityName = 'at_lti_external_tool_'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.activityname = @activityName
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=lti&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on AddAndUpdateLtiExternalToolPage do |page|
    page.activity_name_txt.wait_until_present
    page.activity_name_txt.send_keys @activityName
    page.preconfigured_tool_select.select 'Kaltura'

    #Provide Grade Parameters
    page.grade_link.click
    page.modgrade_type_select.select 'Scale'
    page.modgrade_scale_select.select 'Separate and Connected ways of knowing'
    page.gradepass_txt.send_keys '2'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Hide'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Students can manually mark the activity as completed'
    page.activity_completion_expected_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'October'
    page.activity_completion_year_select.select '2019'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.external_tool_saveanddisplay_btn_clk
  end
end

When(/^The New LTI External Tool got successfully added$/) do

  on CourseItemPage do |page|
    page.lti_external_tool_txt.text.should == @activityName
  end
  configatron.lti_external_tool_id = get_item_id()

end

Then(/^A Course Entity for New LTI External Tool should get generated and sent to our Raw Entity Index\.$/) do
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
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = LTI External Tool Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @activityName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'lti'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'lti'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradeType'\] = 'scale'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'scale'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Grade To Pass value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 2
end

And(/^\['entity'\]\.\['extensions'\]\.\['preconfiguredTool'\] = 'Kaltura'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['preconfiguredTool'].should == 'Kaltura'
end

And(/^\['entity'\]\.\['extensions'\]\.\['preconfiguredToolUrl'\] = Preconfigured Tool Url$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['preconfiguredToolUrl'].include? 'kaf.kaltura.com'
end

And(/^\['entity'\]\.\['extensions'\]\.\['privacyShareLauncherNameWithTheTool'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['privacyShareLauncherNameWithTheTool'].should == true
end

And(/^\['entity'\]\.\['extensions'\]\.\['privacyShareLauncherEmailWithTheTool'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['privacyShareLauncherEmailWithTheTool'].should == true
end

And(/^\['entity'\]\.\['extensions'\]\.\['acceptGradesFromTheTool'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['acceptGradesFromTheTool'].should == true
end

Given(/^Updated the LTI External Tool for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @ltiExternalToolId = configatron.lti_external_tool_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@ltiExternalToolId+"&return=0&sr=0")
  @activityName = configatron.activityname+'updated'
  configatron.activitynameupdated = @activityName

  on AddAndUpdateLtiExternalToolPage do |page|
    page.activity_name_txt.wait_until_present
    page.activity_name_txt.click
    page.activity_name_txt.send_keys [:control, 'a']
    page.activity_name_txt.send_keys @activityName

    #Provide Grade Parameters
    page.grade_link.click
    page.modgrade_type_select.select 'Point'
    page.maxgrade_txt.clear
    page.maxgrade_txt.set '100'
    page.gradepass_txt.click
    page.gradepass_txt.send_keys [:control, 'a']
    page.gradepass_txt.send_keys '79'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_require_view_chkbox.click
    page.activity_require_grade_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'November'
    page.activity_completion_year_select.select '2019'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.external_tool_saveanddisplay_btn_clk
  end
end

When(/^The LTI External Tool got successfully updated$/) do

  on CourseItemPage do |page|
    page.lti_external_tool_txt.text.should == @activityName
  end

  @browser.goto(configatron.moodleURL)
  moodle_logout
end

Then(/^A Course Entity for Update LTI External Tool should get generated and sent to our Raw Entity Index\.$/) do
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
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = LTI External Tool Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.activitynameupdated
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['gradeType'\] = 'point'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'point'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Updated Grade To Pass value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 79
end
