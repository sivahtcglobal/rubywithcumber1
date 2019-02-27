Given(/^Created a New Workshop Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Workshop for #{@courseId}"
  @workshopName = 'WorkshopAuto_' + @currnetTimeStamp.to_s
  configatron.workshopname = @workshopName

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

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=workshop&type=&course='+@courseId+'&section=1&return=0&sr=0')
  @currnetTimeStamp = Time.new.to_i * 1000
  on CourseWorkshopPage do |page|
    page.workshop_name_txt.set @workshopName
    page.workshop_description_txt.send_keys @workshopName + ' Description'
    page.show_description_chkbox.click

    page.strategy_select.select 'Accumulative grading'
    page.grade_select.select '80'
    page.submission_grade_to_pass_txt.set '30'
    page.grading_grade_select.select '20'
    page.assessment_grade_to_pass_txt.set '2'
    page.grade_decimals_select.select '2'

    page.submission_settings_link.click
    page.instructions_for_submission_txt.send_keys 'Instructions for submission'
    page.n_attachments_select.select '1'
    page.allowed_file_types_txt.set 'txt'
    page.max_bytes_select.select '20MB'
    page.late_submissions_chkbox.click

    page.assessment_settings_link.click
    page.instructions_for_assessment_txt.send_keys 'Instructions for assessment'
    page.use_self_assessment_chkbox.click

    page.feedback_link.click
    page.overall_feedback_mode_select.select 'Enabled and optional'
    page.overall_feedback_files_select.select '1'
    page.overall_feedback_files_types_txt.set 'txt'
    page.overall_feedback_max_bytes_select.select '20MB'
    page.conclusion_txt.send_keys 'Conclusion'

    page.example_submissions_link.click
    page.use_examples_chkbox.click
    page.examples_mode_select.select 'Assessment of example submission is voluntary'

    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set @currnetTimeStamp
    page.common_module_group_mode_select.select 'Separate groups'
    page.common_module_grouping_select.select 'None'

    page.restrict_access_link.click

    page.activity_completion_link.click
    page.completion_select.select 'Show activity as complete when conditions are met'
    page.completion_view_chkbox.click
    page.completion_use_grade_chkbox.click
    page.completion_expected_enabled_chkbox.click

    page.tags_link.click
    page.enter_tags.send_keys '2'
    @browser.send_keys :enter

    page.competencies_link.click
    page.competency_rule_select.select 'Send for review'

    page.workshop_saveanddisplay_btn.click
    page.edit_assessment_form_lnk.click
    page.aspect1_description_txt.send_keys 'Aspect Description'
    @browser.execute_script('arguments[0].scrollIntoView();', page.blanks_for_more_aspects_btn)
    sleep(3)
    page.saveandclose_btn_clk

    page.switch_to_the_next_phase_link.click
    page.continue_btn_clk
  end

end

When(/^The New Workshop Page Got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @workshopName
  end
  sleep(15)
  configatron.workshop_id = get_item_id()

end

Then(/^An Entity for New Workshop Page should get generated and sent to our Raw Entity Index\.$/) do
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
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1

end

And(/^\['entity'\]\.\['name'\] = Provided Workshop Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.workshopname
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'workshop'
end

Given(/^Updated the New Workshop for the Given Course$/) do
  @workshop_id = configatron.workshop_id
  @currnetTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  on CourseWorkshopPage do |page|
    page.workshop_edit_dropdown.click if page.workshop_edit_dropdown.exists?
    page.workshop_edit_link.click
  end

  @workshopName = 'AutoUpdated' + @currnetTimeStamp.to_s
  configatron.workshopname = @workshopName
  @description =  @workshopName + ' Description'
  on CourseWorkshopPage do |page|
    page.workshop_name_txt.set @workshopName
    page.workshop_description_txt.send_keys @description
    page.workshop_saveanddisplay_btn.click
  end
  sleep(10)
end

When(/^The Workshop Got successfully Updated for the Given Course$/) do
  on CourseDetailPage do |page|
    puts @workshopName
    configatron.workshopname = @workshopName
  end
  moodle_logout
end

Then(/^A Course Entity for the Updated Workshop should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated Name \['entity'\]\.\['name'\] = Provided Workshop Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.workshopname
end
