Given(/^Created a New Survey under a course$/) do
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

  @surveyName =  'at_survey_'+@currnetTimeStamp.to_s
  @surveyDescription = 'Automated Survey Description'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.surveyname = @surveyName
  configatron.surveydescription = @surveyDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=survey&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseSurveyPage do |page|

    page.survey_name_txt.set @surveyName

    page.survey_description_txt.click
    page.survey_type_select.select 'COLLES (Preferred)'
    page.survey_description_txt.send_keys [:control, 'a']
    page.survey_description_txt.send_keys @surveyDescription

    #Provide Common Module Settings Parameters
    page.common_module_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set '345'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'No groups'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Students can manually mark the activity as completed'
    page.activity_completion_expected_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'October'
    page.activity_completion_year_select.select '2018'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.survey_saveanddisplay_btn_clk

  end
end

When(/^The New Survey got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @surveyName
  end
  configatron.survey_id = get_item_id()

end

Then(/^A Course Entity for New Survey should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Survey name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @surveyName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'survey'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'survey'
end

And(/^\['entity'\]\['extensions'\]\['groupMode'\] == 'none'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'none'
end

And(/^\['entity'\]\.\['extensions'\]\.\['surveyType'\] = Provided Survey Type$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['surveyType'].should == 'colles_preferred'
end

Given(/^Updated the existing Survey under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @surveyId = configatron.survey_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@surveyId+"&return=0&sr=0")
  @surveyName = configatron.surveyname+'updated'
  @surveyDescription = configatron.surveydescription+'updated'
  configatron.surveynameupdated = @surveyName
  configatron.surveydescriptionupdated = @surveyDescription

  on CourseSurveyPage do |page|

    page.survey_name_txt.clear
    page.survey_name_txt.set @surveyName

    page.survey_type_select.select 'Critical incidents'

    page.survey_description_txt.click
    page.survey_description_txt.send_keys [:control, 'a']
    page.survey_description_txt.send_keys @surveyDescription

    #Update Common Module Settings Parameters
    page.common_module_link.click
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

    #Update Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_require_view_chkbox_1.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'December'
    page.activity_completion_year_select.select '2018'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.survey_saveanddisplay_btn_clk
  end
end

When(/^The existing Survey got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.surveynameupdated
  end
  sleep(10)
  moodle_logout
end

Then(/^A Course Entity for Update Survey should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Survey name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @surveyName
end

And(/^Updated \['entity'\]\['extensions'\]\['groupMode'\] == 'visible'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'visible'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['surveyType'\] = Provided Survey Type$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['surveyType'].should == 'critical_incidents'
end
