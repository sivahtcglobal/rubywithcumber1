Given(/^Created a New Scheduler under a course$/) do
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

  @schedulerName =  'at_scheduler_'+@currnetTimeStamp.to_s
  @schedulerIntroduction = 'Automated Scheduler Description'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.schedulername = @schedulerName
  configatron.schedulerintroduction = @schedulerIntroduction
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=scheduler&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseSchedulerPage do |page|

    page.scheduler_name_txt.set @schedulerName

    page.scheduler_introduction_txt.click
    page.scheduler_introduction_txt.send_keys [:control, 'a']
    page.scheduler_introduction_txt.send_keys @schedulerIntroduction

    #Provide Options Parameters
    page.teacher_role_name_txt.send_keys 'Teacher'
    page.max_bookings_select.select '4'
    page.scheduler_mode_select.select 'in this scheduler'
    page.group_booking_select.select 'No'
    page.guard_time_enable_chkbox.click

    page.guard_time_number_txt.click
    page.guard_time_number_txt.send_keys [:control, 'a']
    page.guard_time_number_txt.send_keys '15'

    page.guard_time_timeunit.select 'seconds'

    page.default_slot_duration_txt.click
    page.default_slot_duration_txt.send_keys [:control, 'a']
    page.default_slot_duration_txt.send_keys '20'

    page.notifications_select.select 'Yes'
    page.use_notes_select.select 'Confidential note, visible to teachers only'

    #Provide Grade Parameters
    page.grade_link.click
    page.modgrade_type_select.select 'Scale'
    page.modgrade_scale_select.select 'Separate and Connected ways of knowing'
    page.grade_to_pass_txt.send_keys '2'
    page.grading_strategy_select.select 'Take the highest grade'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Hide'
    page.common_module_id_number_txt.set '567'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Separate groups'
    page.common_module_grouping_select.select 'None'

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

    page.scheduler_saveanddisplay_btn_clk

  end
end

When(/^The New Scheduler got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @schedulerName
  end
  configatron.scheduler_id = get_item_id()

end

Then(/^A Course Entity for New Scheduler should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Scheduler Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @schedulerName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'scheduler'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'scheduler'
end

And(/^\['entity'\]\['extensions'\]\['groupMode'\] == 'separate'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'separate'
end

And(/^\['entity'\]\.\['extensions'\]\.\['requireView'\] = false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireView'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['requireGrade'\] = false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireGrade'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['rolenameOfTeacher'\] = Provided Role Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['rolenameOfTeacher'].should == 'Teacher'
end

And(/^\['entity'\]\.\['extensions'\]\.\['studentsCanRegister'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['studentsCanRegister'].should == '4'
end

And(/^\['entity'\]\.\['extensions'\]\.\['appointment'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['appointment'].should == 'in_this_scheduler'
end

And(/^\['entity'\]\.\['extensions'\]\.\['guardtime'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['guardtime'].should == '15'
end

And(/^\['entity'\]\.\['extensions'\]\.\['bookinGrouping'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['bookinGrouping'].should == 'no'
end

And(/^\['entity'\]\.\['extensions'\]\.\['defaultSlotDuration'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['defaultSlotDuration'].should == '20'
end

And(/^\['entity'\]\.\['extensions'\]\.\['notifications'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['notifications'].should == 'yes'
end

And(/^\['entity'\]\.\['extensions'\]\.\['useNotesAppointments'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['useNotesAppointments'].should == 'confidential_note_visible_teachers_only'
end

Given(/^Updated the existing Scheduler under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @schedulerId = configatron.scheduler_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@schedulerId+"&return=0&sr=0")
  @schedulerName = configatron.schedulername+'updated'
  configatron.schedulernameupdated = @schedulerName
  @schedulerIntroduction = configatron.schedulerintroduction+'updated'
  configatron.schedulerintroductionupdated = @schedulerIntroduction

  on CourseSchedulerPage do |page|

    page.scheduler_name_txt.set @schedulerName

    page.scheduler_introduction_txt.click
    page.scheduler_introduction_txt.send_keys [:control, 'a']
    page.scheduler_introduction_txt.send_keys @schedulerIntroduction

    #Provide Options Parameters
    page.teacher_role_name_txt.click
    page.teacher_role_name_txt.send_keys [:control, 'a']
    page.teacher_role_name_txt.send_keys 'Instructor'
    page.max_bookings_select.select '6'
    page.scheduler_mode_select.select 'at a time'
    page.group_booking_select.select 'Yes, for all groups'

    page.guard_time_number_txt.click
    page.guard_time_number_txt.send_keys [:control, 'a']
    page.guard_time_number_txt.send_keys '10'

    page.guard_time_timeunit.select 'minutes'

    page.default_slot_duration_txt.click
    page.default_slot_duration_txt.send_keys [:control, 'a']
    page.default_slot_duration_txt.send_keys '25'

    page.notifications_select.select 'No'
    page.use_notes_select.select 'Appointment note, visible to teacher and student'

    #Provide Grade Parameters
    page.grade_link.click
    page.modgrade_type_select.select 'Point'
    page.max_grade_txt.clear
    page.max_grade_txt.set '100'
    page.grade_to_pass_txt.click
    page.grade_to_pass_txt.send_keys [:control, 'a']
    page.grade_to_pass_txt.send_keys '67'
    page.grading_strategy_select.select 'Take the mean grade'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set '567'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_require_grade_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'November'
    page.activity_completion_year_select.select '2020'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.scheduler_saveanddisplay_btn_clk
  end
end

When(/^The existing Scheduler got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @schedulerName
  end
  sleep(10)
  moodle_logout
end

Then(/^A Course Entity for Update Scheduler should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Scheduler Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.schedulernameupdated
end


And(/^Updated \['entity'\]\.\['extensions'\]\.\['gradeType'\] = point$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'point'
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Grade To Pass value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 67
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['requireGrade'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['requireGrade'].should == true
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['rolenameOfTeacher'\] = Provided Role Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['rolenameOfTeacher'].should == 'Instructor'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['studentsCanRegister'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['studentsCanRegister'].should == '6'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['appointment'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['appointment'].should == 'at_a_time'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['guardtime'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['guardtime'].should == '600'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['bookinGrouping'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['bookinGrouping'].should == 'yes_all_groups'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['defaultSlotDuration'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['defaultSlotDuration'].should == '25'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['notifications'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['notifications'].should == 'no'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['useNotesAppointments'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['useNotesAppointments'].should == 'appointment_note_visible_teacher_and_student'
end
