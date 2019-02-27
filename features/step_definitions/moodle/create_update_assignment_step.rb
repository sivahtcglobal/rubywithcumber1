Given(/^Created a New Assignment for a Given Course$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Creation a New Assignment for #{@courseId}"
  @assignmentName = 'AssignmentAuto_' + @currnetTimeStamp.to_s

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoTeacherUsername
      @password = configatron.autoTeacherPassword
      log_in_moodle(@username,@password)

      @browser.goto(configatron.moodleURL+'/course/view.php?id='+@courseId)
      page.policy_accept_btn.click if page.policy_accept_btn.exists?

    end unless (page.automation_site_Teacher.exists? && page.automation_site_Teacher.text.include?(configatron.autoTeacherUsername))
  end

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=assign&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseAssignmentPage do |page|
    page.assignment_name_txt.wait_until_present
    page.assignment_name_txt.set @assignmentName
    page.assignment_description_editor.send_keys @assignmentName + ' Description'
    page.assignment_description_editor.click
    page.availability_link_click unless page.allowsubmissionsfromdate_chkbox.visible?
    # page.allowsubmissionsfromdate_chkbox.click
    # page.duedate_chkbox.click
    page.cutoffdate_chkbox.click
    page.allowsubmissionsfromdate_day_select.select '3'
    page.allowsubmissionsfromdate_month_select.select 'January'
    page.allowsubmissionsfromdate_year_select.select '2018'
    page.allowsubmissionsfromdate_hour_select.select '09'
    page.allowsubmissionsfromdate_minute_select.select '45'

    page.duedate_day_select.select '15'
    page.duedate_month_select.select 'November'
    page.duedate_year_select.select '2018'
    page.duedate_hour_select.select '15'
    page.duedate_minute_select.select '25'

    page.cutoffdate_day_select.select '29'
    page.cutoffdate_month_select.select 'December'
    page.cutoffdate_year_select.select '2018'
    page.cutoffdate_hour_select.select '19'
    page.cutoffdate_minute_select.select '35'
    page.assignment_alwaysshowdescription_chkbox.click


    page.submission_types_link.click unless page.onlinetext_chkbtn.visible?
    page.onlinetext_chkbtn.click
    # page.file_chkbtn.click
    page.wordlimit_chkbtn.click
    page.onlinetext_txt.set '280'
    page.number_of_files_select.select '5'
    page.maxsizebytes_select.select '1MB'


    page.feedback_types_link.click unless page.feedback_comments_chkbox.visible?
    #page.feedback_comments_chkbox.click
    page.offline_chkbox.click
    page.feedback_file_chkbox.click
    page.commentinline_select.select 'Yes'

    page.submission_settings_link.click unless page.submissiondrafts_select.visible?
    page.submissiondrafts_select.select 'No'
    page.requiresubmissionstatement_select.select 'No'
    page.attemptreopenmethod_select.select 'Automatically until pass'
    page.maxattempts_select.select '7'

    page.group_submission_settings_link.click unless page.teamsubmission_select.visible?
    page.teamsubmission_select.select 'Yes'
    page.preventsubmissionnotingroup_select.select 'Yes'
    #page.requireallteammemberssubmit_select.select 'Yes'
    #page.teamsubmissiongroupingid_select.select

    page.notifications_link.click unless page.sendnotifications_select.visible?
    page.sendlatenotifications_select.select 'Yes'

    page.grade_link.click unless page.grade_modgrade_type_select.visible?
    # page.grade_modgrade_type_select.select 'Point'
    page.grade_modgrade_type_select.select 'Scale'
    page.grade_modgrade_scale_select.select 'Separate and Connected ways of knowing'
    # page.grade_modgrade_point_txt.set '90'
    page.advancedgradingmethod_submissions_select.option(:value => 'guide').select
    page.gradepass_txt.set '3'
    page.blindmarking_select.select 'No'
    page.markingworkflow_select.select 'Yes'
    page.markingallocation_select.select 'Yes'

    page.common_module_settings_link.click unless page.visible_select.visible?
    page.visible_select.select 'Hide'
    page.cmidnumber_txt.set 'Auto cmid' +  @currnetTimeStamp.to_s
    page.groupmode_select.select 'Visible groups'
    page.groupingid_select.select 'None'
    page.restrictbygroup_btn.click


    #page.activity_completion_link.click unless page.completion_select.visible?
    #page.completion_select.select 'Show activity as complete when conditions are met'
    #page.completionview_chkbox.click
    #page.completionusegrade_chkbox.click
    #page.completionsubmit_chkbox.click
    #page.completionexpected_enabled_chkbox.click
    #page.completionexpected_day_select.select '8'
    #page.completionexpected_month_select.select 'January'
    #page.completionexpected_year_select.select '2018'


    page.tags_link.click unless page.assignment_tags_txt.visible?
    page.assignment_tags_txt.set 'Tag 1'
    page.assignment_tags_txt.send_keys :enter
    page.assignment_tags_txt.set 'Tag 2'
    page.assignment_tags_txt.send_keys :enter
    page.assignment_tags_txt.set 'Tag 3'
    page.assignment_tags_txt.send_keys :enter


    page.competencies_link.click unless page.competencies_select.visible?
    # page.competencies_select.select 'Proficiency         16'
    # page.competencies_select.select '4         4'
    # page.competencies_select.select '3         3'
    page.competency_rule_select.select 'Send for review'
    page.assignment_save_return_btn_click

  end

end



When(/^The New Assignment Got successfully for a Given Course$/) do
  on CourseDetailPage do |page|
    page.assignment_link(@assignmentName).exists?.should be true
    page.assignment_link(@assignmentName).click
    configatron.assignmentId = page.url.split('?').last.split('=').last

  end


end

Then(/^A Course Entity for the New Assignment should get generated and sent to our Raw Entity Index\.$/) do
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

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^Assignment Name \['entity'\]\['name'\]\.should == Provided Assignment Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @assignmentName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'assign'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'assign'
end

And(/^Allow Submission From \['entity'\]\['dateToStartOn'\] == '2018\-02\-01T05:00:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['dateToStartOn'] == '2018-02-01T05:00:00.000Z'
end

And(/^Due Date \['entity'\]\['dateToSubmit'\] == '2018\-11\-24T05:00:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['dateToSubmit'] == '2018-11-24T05:00:00.000Z'
end

And(/^Cut\-off data \['entity'\]\['extensions'\]\['dateToCutOff'\] == '2018\-12\-31T10:40:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['dateToCutOff'] == '2018-12-31T10:40:00.000Z'
end

And(/^Submission types \['entity'\]\['extensions'\]\['submissionTypes'\] == Provided Options$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['submissionTypes'][0] == 'onlinetext'
  @response['hits']['hits'][0]['_source']['entity']['extensions']['submissionTypes'][1] == 'file'
end

And(/^Maximum number of uploaded files \['entity'\]\['extensions'\]\['maxUploadedFiles'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['maxUploadedFiles'] == 5
end

And(/^Require Students Click Submit Button \['entity'\]\['extensions'\]\['requireSubmitButton'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireSubmitButton'] == true
end

And(/^Require that students accept the submission statement \['entity'\]\['extensions'\]\['requireSubmissionStatement'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireSubmissionStatement'] == true
end

And(/^Maximum attempts \['_source'\]\['entity'\]\['maxAttempts'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['maxAttempts'] == 3
end

And(/^Grade \['entity'\]\['maxScore'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['maxScore'] == 90
end

And(/^Grading method \['entity'\]\['extensions'\]\['gradingMethod'\] == 'guide'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradingMethod'] == 'guide'
end

And(/^Visible \['entity'\]\['extensions'\]\['visible'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['visible'] == true
end

And(/^Completion tracking \['entity'\]\['extensions'\]\['completionTracking'\] == 'conditions'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'] == 'conditions'
end

And(/^Require View \['entity'\]\['extensions'\]\['requireView'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireView'] == true
end

And(/^Require Grade \['entity'\]\['extensions'\]\['requireGrade'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireGrade'] == true
end

And(/^Expect completed on \['entity'\]\['extensions'\]\['expectedCompletionDate'\] == '2018\-01\-16T05:00:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'] == '2018-01-16T05:00:00.000Z'
end

And(/^Max Score \['entity'\]\['maxScore'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['maxScore'] == 90
end

Given(/^Updated the New Assignment for the Given Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @assignmentId = configatron.assignmentId

  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + @assignmentId.to_s)
  on AssignmentViewPage do |page|
    page.assignment_edit_dropdown.click if page.assignment_edit_dropdown.exists?
    page.assignment_edit_link.click
  end

  @assignmentName = 'AutoUpdated' + @currnetTimeStamp.to_s
  configatron.assignmentName = @assignmentName
  @description =  @assignmentName + ' Description'
  on CourseAssignmentPage do |page|
    page.assignment_name_txt.wait_until_present
    page.assignment_name_txt.set @assignmentName
    page.assignment_description_editor.send_keys @description
    page.assignment_description_editor.click
    page.availability_link_click unless page.allowsubmissionsfromdate_chkbox.visible?
    # page.allowsubmissionsfromdate_chkbox.click
    # page.duedate_chkbox.click
    #page.cutoffdate_chkbox.click
    page.allowsubmissionsfromdate_day_select.select '13'
    page.allowsubmissionsfromdate_month_select.select 'January'
    page.allowsubmissionsfromdate_year_select.select '2018'
    page.allowsubmissionsfromdate_hour_select.select '21'
    page.allowsubmissionsfromdate_minute_select.select '55'

    page.duedate_day_select.select '12'
    page.duedate_month_select.select 'December'
    page.duedate_year_select.select '2018'
    page.duedate_hour_select.select '12'
    page.duedate_minute_select.select '25'

    page.cutoffdate_day_select.select '30'
    page.cutoffdate_month_select.select 'December'
    page.cutoffdate_year_select.select '2018'
    page.cutoffdate_hour_select.select '21'
    page.cutoffdate_minute_select.select '45'
    page.assignment_alwaysshowdescription_chkbox.click


    page.submission_types_link.click unless page.onlinetext_chkbtn.visible?
    # page.onlinetext_chkbtn.click
    # page.file_chkbtn.click
    #  page.wordlimit_chkbtn.click
    #  page.onlinetext_txt.set '250'
    # page.number_of_files_select.select '6'
    # page.maxsizebytes_select.select '5MB'


    page.feedback_types_link.click unless page.feedback_comments_chkbox.visible?
    # page.feedback_comments_chkbox.click
    page.offline_chkbox.click
    page.feedback_file_chkbox.click
    # page.commentinline_select.select 'No'

    page.submission_settings_link.click unless page.submissiondrafts_select.visible?
    page.submissiondrafts_select.select 'Yes'
    page.requiresubmissionstatement_select.select 'Yes'
    page.attemptreopenmethod_select.select 'Manually'
    page.maxattempts_select.select '3'

    page.group_submission_settings_link.click unless page.teamsubmission_select.visible?
    page.teamsubmission_select.select 'No'
    # page.preventsubmissionnotingroup_select.select 'No'
    # page.requireallteammemberssubmit_select.select 'No'
    #page.teamsubmissiongroupingid_select.select

    page.notifications_link.click unless page.sendnotifications_select.visible?
    page.sendlatenotifications_select.select 'Yes'

    page.grade_link.click unless page.grade_modgrade_type_select.visible?
    page.grade_modgrade_type_select.select 'Point'
    # page.grade_modgrade_scale_select.select
    # page.grade_modgrade_type_select.select 'Scale'
    # page.grade_modgrade_scale_select.select 'Separate and Connected ways of knowing'
    page.grade_modgrade_point_txt.set '95'
    page.advancedgradingmethod_submissions_select.select 'Simple direct grading'
    page.gradepass_txt.set '75'
    page.blindmarking_select.select 'No'
    page.markingworkflow_select.select 'No'
    # page.markingallocation_select.select 'No'

    page.common_module_settings_link.click unless page.visible_select.visible?
    page.visible_select.select 'Show'
    page.cmidnumber_txt.set 'Updated Auto cmid' +  @currnetTimeStamp.to_s
    page.groupmode_select.select 'Separate groups'
    # page.groupingid_select.select 'None'
    # page.restrictbygroup_btn.click


    #page.activity_completion_link.click unless page.completion_select.visible?
    #page.completion_select.select 'Students can manually mark the activity as completed'
    # page.completionview_chkbox.click
    # page.completionusegrade_chkbox.click
    # page.completionsubmit_chkbox.click
    # page.completionexpected_enabled_chkbox.click
    #page.completionexpected_day_select.select '15'
    #page.completionexpected_month_select.select 'December'
    #page.completionexpected_year_select.select '2018'
    page.tags_link.click unless page.assignment_tags_txt.visible?
    page.assignment_tags_txt.set 'Tag 4'
    page.assignment_tags_txt.send_keys :enter
    page.assignment_tags_txt.set 'Tag 5'
    page.assignment_tags_txt.send_keys :enter
    page.restrict_access_link.click unless page.restrict_type_select.visible?
    page.restrict_delete_icon.click
    page.competencies_link.click unless page.competencies_select.visible?
    # page.competencies_select.select 'Proficiency         16'
    # page.competencies_select.select '4         4'
    # page.competencies_select.select '3         3'
    page.competency_rule_select.select 'Send for review'
    @currnetTimeStamp = Time.new.to_i * 1000
    page.assignment_save_return_btn_click
  end
  sleep(10)
end

When(/^The Assignment Got successfully Updated for the Given Course$/) do
  on CourseDetailPage do |page|
    # puts page.url
    puts @assignmentName
    configatron.assignmentName = @assignmentName
    #page.assignment_link(@assignmentName.to_s).visible?.should be_true
  end
  moodle_logout
end

Then(/^A Course Entity for the Updated Assignment should get generated and sent to our Raw Entity Index\.$/) do
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

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated Assignment Name \['entity'\]\['name'\]\.should == Provided Assignment Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @assignmentName
end

And(/^Updated Allow Submission From \['entity'\]\['dateToStartOn'\] == '2018\-02\-01T05:00:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['dateToStartOn'] == '2018-02-01T05:00:00.000Z'
end

And(/^Updated Due Date \['entity'\]\['dateToSubmit'\] == '2018\-11\-24T05:00:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['dateToSubmit'] == '2018-11-24T05:00:00.000Z'
end

And(/^Updated Cut\-off data \['entity'\]\['extensions'\]\['dateToCutOff'\] == '2018\-12\-31T10:40:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['dateToCutOff'] == '2018-12-31T10:40:00.000Z'
end

And(/^Updated Submission types \['entity'\]\['extensions'\]\['submissionTypes'\] == Provided Options$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['submissionTypes'][0] == 'onlinetext'
  @response['hits']['hits'][0]['_source']['entity']['extensions']['submissionTypes'][1] == 'file'
end

And(/^Updated Maximum number of uploaded files \['entity'\]\['extensions'\]\['maxUploadedFiles'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['maxUploadedFiles'] == 5
end

And(/^Updated Require Students Click Submit Button \['entity'\]\['extensions'\]\['requireSubmitButton'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireSubmitButton'] == true
end

And(/^Updated Require that students accept the submission statement \['entity'\]\['extensions'\]\['requireSubmissionStatement'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireSubmissionStatement'] == true
end

And(/^Updated Maximum attempts \['_source'\]\['entity'\]\['maxAttempts'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['maxAttempts'] == 3
end

And(/^Updated Grade \['entity'\]\['maxScore'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['maxScore'] == 90
end

And(/^Updated Grading method \['entity'\]\['extensions'\]\['gradingMethod'\] == 'guide'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradingMethod'] == 'guide'
end

And(/^Updated Visible \['entity'\]\['extensions'\]\['visible'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['visible'] == true
end

And(/^Updated Completion tracking \['entity'\]\['extensions'\]\['completionTracking'\] == 'conditions'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'] == 'conditions'
end

And(/^Updated Require View \['entity'\]\['extensions'\]\['requireView'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireView'] == true
end

And(/^Updated Require Grade \['entity'\]\['extensions'\]\['requireGrade'\] == true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireGrade'] == true
end

And(/^Updated Expect completed on \['entity'\]\['extensions'\]\['expectedCompletionDate'\] == '2018\-01\-16T05:00:00\.000Z'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'] == '2018-12-15T05:00:00.000Z'
end

And(/^Updated Max Score \['entity'\]\['maxScore'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['maxScore'] == 90
end
