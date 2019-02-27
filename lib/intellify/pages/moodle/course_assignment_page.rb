class CourseAssignmentPage < BasePage


  element(:assignment_name_txt) { |b| b.text_field(id:"id_name")}
  element(:assignment_description_editor) { |b| b.div(id:"id_introeditoreditable")}
  element(:assignment_display_chkbtn) { |b| b.input(id:"id_showdescription")}

  #Link Availability
  element(:availability_link) { |b| b.a(text:"Availability")}
  element(:availability_link_click) { |b| b.availability_link.click}

  element(:allowsubmissionsfromdate_chkbox) { |b| b.input(id:"id_allowsubmissionsfromdate_enabled")}
  element(:duedate_chkbox) { |b| b.input(id:"id_duedate_enabled")}
  element(:cutoffdate_chkbox) { |b| b.input(id:"id_cutoffdate_enabled")}

  #Allow submissions
  element(:allowsubmissionsfromdate_day_select) { |b| b.select_list(id:"id_allowsubmissionsfromdate_day")}
  element(:allowsubmissionsfromdate_month_select) { |b| b.select_list(id:"id_allowsubmissionsfromdate_month")}
  element(:allowsubmissionsfromdate_year_select) { |b| b.select_list(id:"id_allowsubmissionsfromdate_year")}
  element(:allowsubmissionsfromdate_hour_select) { |b| b.select_list(id:"id_allowsubmissionsfromdate_hour")}
  element(:allowsubmissionsfromdate_minute_select) { |b| b.select_list(id:"id_allowsubmissionsfromdate_minute")}

  #Due date
  element(:duedate_day_select) { |b| b.select_list(id:"id_duedate_day")}
  element(:duedate_month_select) { |b| b.select_list(id:"id_duedate_month")}
  element(:duedate_year_select) { |b| b.select_list(id:"id_duedate_year")}
  element(:duedate_hour_select) { |b| b.select_list(id:"id_duedate_hour")}
  element(:duedate_minute_select) { |b| b.select_list(id:"id_duedate_minute")}

  #Cut-off date
  element(:cutoffdate_day_select) { |b| b.select_list(id:"id_cutoffdate_day")}
  element(:cutoffdate_month_select) { |b| b.select_list(id:"id_cutoffdate_month")}
  element(:cutoffdate_year_select) { |b| b.select_list(id:"id_cutoffdate_year")}
  element(:cutoffdate_hour_select) { |b| b.select_list(id:"id_cutoffdate_hour")}
  element(:cutoffdate_minute_select) { |b| b.select_list(id:"id_cutoffdate_minute")}

  # Always show description
  element(:assignment_alwaysshowdescription_chkbox) { |b| b.input(id:"id_alwaysshowdescription")}


  #Link Submission types
  element(:submission_types_link) { |b| b.a(text:"Submission types")}
  element(:onlinetext_chkbtn) { |b| b.input(id:"id_assignsubmission_onlinetext_enabled")}
  element(:file_chkbtn) { |b| b.input(id:"id_assignsubmission_file_enabled")}
  element(:wordlimit_chkbtn) { |b| b.input(id:"id_assignsubmission_onlinetext_wordlimit_enabled")}
  element(:onlinetext_txt) { |b| b.text_field(id:"id_assignsubmission_onlinetext_wordlimit")}
  element(:number_of_files_select) { |b| b.select_list(id:"id_assignsubmission_file_maxfiles")}
  element(:maxsizebytes_select) { |b| b.select_list(id:"id_assignsubmission_file_maxsizebytes")}


  #Link Feedback types
  element(:feedback_types_link) { |b| b.a(text:"Feedback types")}
  element(:feedback_comments_chkbox) { |b| b.input(id:"id_assignfeedback_comments_enabled")}
  element(:offline_chkbox) { |b| b.input(id:"id_assignfeedback_offline_enabled")}
  element(:feedback_file_chkbox) { |b| b.input(id:"id_assignfeedback_file_enabled")}
  element(:commentinline_select) { |b| b.select_list(id:"id_assignfeedback_comments_commentinline")}

  #Link Submission settings
  element(:submission_settings_link) { |b| b.a(text:"Submission settings")}
  element(:submissiondrafts_select) { |b| b.select_list(id:"id_submissiondrafts")}
  element(:requiresubmissionstatement_select) { |b| b.select_list(id:"id_requiresubmissionstatement")}
  element(:attemptreopenmethod_select) { |b| b.select_list(id:"id_attemptreopenmethod")}
  #Never
  #Manually
  #Automatically until pass
  element(:maxattempts_select) { |b| b.select_list(id:"id_maxattempts")}
  #Unlimited 1 2 3 ...30

  #Link Group submission settings
  element(:group_submission_settings_link) { |b| b.a(text:"Group submission settings")}
  element(:teamsubmission_select) { |b| b.select_list(id:"id_teamsubmission")}
  element(:preventsubmissionnotingroup_select) { |b| b.select_list(id:"id_preventsubmissionnotingroup")}
  element(:requireallteammemberssubmit_select) { |b| b.select_list(id:"id_requireallteammemberssubmit")}
  element(:teamsubmissiongroupingid_select) { |b| b.select_list(id:"id_teamsubmissiongroupingid")}

  #Link Notifications
  element(:notifications_link) { |b| b.a(text:"Notifications")}
  element(:sendnotifications_select) { |b| b.select_list(id:"id_sendnotifications")}
  element(:sendlatenotifications_select) { |b| b.select_list(id:"id_sendlatenotifications")}
  element(:sendstudentnotifications_select) { |b| b.select_list(id:"id_sendstudentnotifications")}


  #Link Grade
  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:grade_modgrade_type_select) { |b| b.select_list(id:"id_grade_modgrade_type")}
  element(:grade_modgrade_scale_select) { |b| b.select_list(id:"id_grade_modgrade_scale")}
  element(:grade_modgrade_point_txt) { |b| b.text_field(id:"id_grade_modgrade_point")}
  element(:advancedgradingmethod_submissions_select) { |b| b.select_list(id:"id_advancedgradingmethod_submissions")}
  element(:gradecat_select) { |b| b.select_list(id:"id_gradecat")}
  element(:gradepass_txt) { |b| b.text_field(id:"id_gradepass")}
  element(:blindmarking_select) { |b| b.select_list(id:"id_blindmarking")}
  element(:markingworkflow_select) { |b| b.select_list(id:"id_markingworkflow")}
  element(:markingallocation_select) { |b| b.select_list(id:"id_markingallocation")}


  #Link Common module settings
  element(:common_module_settings_link) { |b| b.a(text:"Common module settings")}
  element(:visible_select) { |b| b.select_list(id:"id_visible")}
  element(:cmidnumber_txt) { |b| b.text_field(id:"id_cmidnumber")}
  element(:groupmode_select) { |b| b.select_list(id:"id_groupmode")}
  element(:groupingid_select) { |b| b.select_list(id:"id_groupingid")}
  element(:restrictbygroup_btn) { |b| b.button(id:"restrictbygroup")}



  #Link Restrict access
  element(:restrict_access_link) { |b| b.a(text:"Restrict access")}
  element(:restrict_type_select) { |b| b.select_list(title:"Restriction type")}
  element(:restrict_delete_icon) { |b| b.a(title:"Delete")}


  #Link Activity completion
  element(:activity_completion_link) { |b| b.a(text:"Activity completion")}
  element(:completion_select) { |b| b.select_list(id:"id_completion")}
  element(:completionview_chkbox) { |b| b.input(id:"id_completionview")}
  element(:completionusegrade_chkbox) { |b| b.input(id:"id_completionusegrade")}
  element(:completionsubmit_chkbox) { |b| b.input(id:"id_completionsubmit")}
  element(:completionexpected_enabled_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  #Expect completed On
  element(:completionexpected_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:completionexpected_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:completionexpected_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Link Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:assignment_tags_txt) { |b| b.text_field(placeholder:"Enter tags...")}

  #Link Competencies
  element(:competencies_link) { |b| b.a(text:"Competencies")}
  element(:competencies_select) { |b| b.select_list(id:"id_competencies")}
  #     3         3
  #     Proficiency         16
  #     4         4

  element(:competency_rule_select) { |b| b.select_list(id:"id_competency_rule")}
  #Do nothing
  #Attach evidence
  #Send for review
  #Complete the competency


  #Save Button
  element(:assignment_save_btn) { |b| b.input(id:"id_submitbutton")}
  action(:assignment_save_btn_click) { |b| b.assignment_save_btn.click }

  element(:assignment_save_return_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:assignment_save_return_btn_click) { |b| b.assignment_save_return_btn.click }


end
