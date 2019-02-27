Given(/^Created a New Questionnaire Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Questionnaire for #{@courseId}"
  @questionnaireName = 'QuestionnaireAuto_' + @currnetTimeStamp.to_s
  @questionName = 'Question_Name' + (Time.new.to_i * 1000).to_s
  @questionText = 'Question_Text' + (Time.new.to_i * 1000).to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.questionnairename = @questionnaireName
  configatron.questionname = @questionName
  configatron.questiontext = @questionText
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

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=questionnaire&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseQuestionnairePage do |page|
    page.questionnaire_name_txt.wait_until_present
    page.questionnaire_name_txt.set @questionnaireName
    page.questionnaire_description_txt.send_keys @questionnaireName + ' Description'
    page.display_description_chkbox.click

    page.timing_link.click
    page.use_open_date_chkbox.click
    page.from_day_select.select '3'
    page.from_month_select.select 'April'
    page.from_year_select.select '2017'
    page.from_hour_select.select '09'
    page.from_minute_select.select '45'
    page.use_close_date_chkbox.click
    page.to_day_select.select '15'
    page.to_month_select.select 'November'
    page.to_year_select.select '2018'
    page.to_hour_select.select '15'
    page.to_minute_select.select '25'

    page.response_options_link.click
    page.response_type_select.select 'respond once'
    page.respondent_type_select.select 'fullname'
    page.response_view_select.select 'After answering the questionnaire'
    page.resume_select.select 'Yes'
    page.branching_question_select.select 'Yes'
    page.auto_numbering_select.select 'Auto number pages and questions'
    page.grade_select.select '100'

    page.content_options_link.click
    page.create_new_radio.click

    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set 'New_Question'+ @currnetTimeStamp.to_s
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

    page.questionnaire_saveanddisplay_btn_clk

    configatron.questionnaire_id = get_item_id()
  end

  on AddQuestionsPage do |page|
    page.add_questions_link.click
    page.question_type_select.select 'Yes/No'
    page.add_selected_question_type_btn.click
    page.question_name_txt.send_keys configatron.questionname
    page.response_required_radio.click
    page.question_txt.send_keys configatron.questiontext
    page.save_changes_btn_clk
    page.question_type_select.select '----- Page Break -----'
    page.add_selected_question_type_btn.click
    page.question_type_select.select 'Yes/No'
    page.add_selected_question_type_btn.click
    page.question_name_txt.send_keys configatron.questionname + @currnetTimeStamp.to_s
    page.response_required_radio.click
    page.question_txt.send_keys configatron.questiontext + @currnetTimeStamp.to_s
    page.save_changes_btn_clk
  end
end

When(/^The New Questionnaire Page Got successfully created$/) do

  on AddQuestionsPage do |page|
    page.manage_question_name.text.should == configatron.questiontext
  end

  moodle_logout

end

Then(/^A Entity for New Questionnaire Page should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Provided Questionnaire Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.questionnairename
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'questionnaire'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'questionnaire'
end

And(/^\['entity'\]\.\['extensions'\]\.\['completionTracking'\] = 'conditions'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'].should == 'conditions'
end

And(/^Require View \['entity'\]\['extensions'\]\['requireView'\] == false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireView'].should == false
end

And(/^Require Grade \['entity'\]\['extensions'\]\['requireGrade'\] == false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireGrade'].should == false
end

And(/^Expect completed on \['entity'\]\['extensions'\]\['expectedCompletionDate'\] == '2017\-10\-08'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2018-10-08'
end

And(/^\['entity'\]\.\['extensions'\]\.\['openDate'\] = Provided Open Date Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['openDate'].include? '2017-04-03'
end

And(/^\['entity'\]\.\['extensions'\]\.\['closeDate'\] = Provided Close Date Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['closeDate'].include? '2018-11-15'
end

And(/^\['entity'\]\.\['extensions'\]\.\['responseType'\] = 'once'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['responseType'].should == 'once'
end

And(/^\['entity'\]\.\['extensions'\]\.\['respondentType'\] = 'fullname'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['respondentType'].should == 'fullname'
end

And(/^\['entity'\]\.\['extensions'\]\.\['submissionGrade'\] = Provided Grade$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['submissionGrade'].should == 100
end

And(/^\['entity'\]\.\['extensions'\]\.\['groupMode'\] = 'visible'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'visible'
end
