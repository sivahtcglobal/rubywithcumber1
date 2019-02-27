Given(/^Created a New Choice Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Choice for #{@courseId}"
  @choiceName = 'ChoiceAuto_' + @currnetTimeStamp.to_s
  @choiceText = 'Choice_Text' + (Time.new.to_i * 1000).to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.choicename = @choiceName
  configatron.choicetext = @choiceText
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

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=choice&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseChoicePage do |page|
    page.choice_name_txt.wait_until_present
    page.choice_name_txt.set @choiceName
    page.choice_description_txt.send_keys @choiceName + ' Description'
    page.display_description_chkbox.click

    page.allow_update_select.select 'Yes'
    page.allow_multiple_choice_select.select 'Yes'
    page.response_limit_select.select 'Yes'
    page.option_1_txt.set '1'
    page.limit_1_txt.set '1'
    page.option_2_txt.set '2'
    page.limit_2_txt.set '2'
    page.option_3_txt.set '3'
    page.limit_3_txt.set '3'
    page.option_4_txt.set '4'
    page.limit_4_txt.set '4'
    page.option_5_txt.set '5'
    page.limit_5_txt.set '5'

    page.availability_link.click
    page.time_restrict_chkbox.click if page.time_restrict_chkbox.exists?
    page.allow_responses_from_chkbox.click if page.allow_responses_from_chkbox.exists?
    page.from_day_select.select '3'
    page.from_month_select.select 'April'
    page.from_year_select.select '2017'
    page.from_hour_select.select '09'
    page.from_minute_select.select '45'
    page.allow_responses_until_chkbox.click if page.allow_responses_until_chkbox.exists?
    page.to_day_select.select '15'
    page.to_month_select.select 'November'
    page.to_year_select.select '2018'
    page.to_hour_select.select '15'
    page.to_minute_select.select '25'
    @browser.execute_script('arguments[0].scrollIntoView();', page.to_day_select)
    page.show_preview_chkbox.click

    page.results_link.click
    page.publish_results_select.select 'Show results to students after they answer'
    page.privacy_results_select.select 'Publish full results, showing names and their choices'
    page.show_unanswered_column_select.select 'Yes'
    page.include_inactive_select.select 'Yes'

    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set 'New_Choice'+ @currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_completion_submit_chkbox.click
    page.activity_completion_expected_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'October'
    page.activity_completion_year_select.select '2018'

    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.choice_saveanddisplay_btn_clk
  end

end

When(/^The New Choice Page Got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @choiceName
  end
  sleep(15)
  configatron.choice_id = get_item_id()
  moodle_logout

end

Then(/^An Entity for New Choice Page should get generated and sent to our Raw Entity Index\.$/) do
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
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = Provided Choice Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.choicename
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'choice'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'choice'
end

And(/^\['entity'\]\.\['extensions'\]\.\['allowResponsesFromDate'\] = Provided Responses From Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['allowResponsesFromDate'].include? '2017-04-03'
end

And(/^\['entity'\]\.\['extensions'\]\.\['allowResponsesUntilDate'\] = Provided Responses Until Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['allowResponsesUntilDate'].include? '2018-11-15'
end

And(/^\['entity'\]\.\['extensions'\]\.\['previewOptions'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['previewOptions'].should == true
end

And(/^\['entity'\]\.\['extensions'\]\.\['publishResults'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['publishResults'].should == 'afterStudentAnswer'
end

And(/^\['entity'\]\.\['extensions'\]\.\['resultsPrivacy'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['resultsPrivacy'].should == 'full'
end
