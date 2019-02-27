class CourseWorkshopPage < BasePage

  #Moodle Workshop Page Elements
  element(:workshop_name_txt) { |b| b.text_field(id:"id_name")}
  element(:workshop_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:show_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Grading Settings
  element(:strategy_select) { |b| b.select_list(id:"id_strategy")}
  element(:grade_select) { |b| b.select_list(id:"id_grade")}
  element(:grade_category_select) { |b| b.select_list(id:"id_gradecategory")}
  element(:submission_grade_to_pass_txt) { |b| b.text_field(id:"id_submissiongradepass")}
  element(:grading_grade_select) { |b| b.select_list(id:"id_gradinggrade")}
  element(:grading_grade_category_select) { |b| b.select_list(id:"id_gradinggradecategory")}
  element(:assessment_grade_to_pass_txt) { |b| b.text_field(id:"id_gradinggradepass")}
  element(:grade_decimals_select) { |b| b.select_list(id:"id_gradedecimals")}

  #Submission Settings
  element(:submission_settings_link) { |b| b.a(text:"Submission settings")}
  element(:instructions_for_submission_txt) { |b| b.div(id:"id_instructauthorseditoreditable")}
  element(:n_attachments_select) { |b| b.select_list(id:"id_nattachments")}
  element(:allowed_file_types_txt) { |b| b.text_field(id:"id_submissionfiletypes")}
  element(:max_bytes_select) { |b| b.select_list(id:"id_maxbytes")}
  element(:late_submissions_chkbox) { |b| b.input(id:"id_latesubmissions")}

  #Assessment Settings
  element(:assessment_settings_link) { |b| b.a(text:"Assessment settings")}
  element(:instructions_for_assessment_txt) { |b| b.div(id:"id_instructreviewerseditoreditable")}
  element(:use_self_assessment_chkbox) { |b| b.input(id:"id_useselfassessment")}

  #Feedback
  element(:feedback_link) { |b| b.a(text:"Feedback")}
  element(:overall_feedback_mode_select) { |b| b.select_list(id:"id_overallfeedbackmode")}
  element(:overall_feedback_files_select) { |b| b.select_list(id:"id_overallfeedbackfiles")}
  element(:overall_feedback_files_types_txt) { |b| b.text_field(id:"id_overallfeedbackfiletypes")}
  element(:overall_feedback_max_bytes_select) { |b| b.select_list(id:"id_overallfeedbackmaxbytes")}
  element(:conclusion_txt) { |b| b.div(id:"id_conclusioneditoreditable")}

  #Example Submissions
  element(:example_submissions_link) { |b| b.a(text:"Example submissions")}
  element(:use_examples_chkbox) { |b| b.input(id:"id_useexamples")}
  element(:examples_mode_select) { |b| b.select_list(id:"id_examplesmode")}

  #Availability
  element(:availability_link) { |b| b.a(text:"Availability")}
  element(:submission_start_chkbox) { |b| b.input(name:"submissionstart[enabled]")}
  element(:from_day_select) { |b| b.select_list(id:"id_submissionstart_day")}
  element(:from_month_select) { |b| b.select_list(id:"id_submissionstart_month")}
  element(:from_year_select) { |b| b.select_list(id:"id_submissionstart_year")}
  element(:from_hour_select) { |b| b.select_list(id:"id_submissionstart_hour")}
  element(:from_minute_select) { |b| b.select_list(id:"id_submissionstart_minute")}
  element(:submissions_end_chkbox) { |b| b.input(name:"submissionend[enabled]")}
  element(:to_day_select) { |b| b.select_list(id:"id_submissionend_day")}
  element(:to_month_select) { |b| b.select_list(id:"id_submissionend_month")}
  element(:to_year_select) { |b| b.select_list(id:"id_submissionend_year")}
  element(:to_hour_select) { |b| b.select_list(id:"id_submissionend_hour")}
  element(:to_minute_select) { |b| b.select_list(id:"id_submissionend_minute")}
  element(:phase_switch_assessment_chkbox) { |b| b.input(id:"id_phaseswitchassessment")}
  element(:assessment_start_chkbox) { |b| b.input(name:"assessmentstart[enabled]")}
  element(:assessment_start_from_day_select) { |b| b.select_list(id:"id_assessmentstart_day")}
  element(:assessment_start_from_month_select) { |b| b.select_list(id:"id_assessmentstart_month")}
  element(:assessment_start_from_year_select) { |b| b.select_list(id:"id_assessmentstart_year")}
  element(:assessment_start_from_hour_select) { |b| b.select_list(id:"id_assessmentstart_hour")}
  element(:assessment_start_from_minute_select) { |b| b.select_list(id:"id_assessmentstart_minute")}
  element(:assessment_end_chkbox) { |b| b.input(name:"assessmentend[enabled]")}
  element(:assessment_end_from_day_select) { |b| b.select_list(id:"id_assessmentend_day")}
  element(:assessment_end_from_month_select) { |b| b.select_list(id:"id_assessmentend_month")}
  element(:assessment_end_from_year_select) { |b| b.select_list(id:"id_assessmentend_year")}
  element(:assessment_end_from_hour_select) { |b| b.select_list(id:"id_assessmentend_hour")}
  element(:assessment_end_from_minute_select) { |b| b.select_list(id:"id_assessmentend_minute")}

  #Common Module Settings
  element(:common_module_settings_link) { |b| b.a(text:"Common module settings")}
  element(:common_module_visible_select) { |b| b.select_list(id:"id_visible")}
  element(:common_module_id_number_txt) { |b| b.text_field(id:"id_cmidnumber")}
  element(:common_module_group_mode_select) { |b| b.select_list(id:"id_groupmode")}
  element(:common_module_grouping_select) { |b| b.select_list(id:"id_groupingid")}

  #Restrict Access
  element(:restrict_access_link) { |b| b.a(text:"Restrict access")}
  element(:restrict_access_add_restriction_btn) { |b| b.button(text:"Add restriction...")}
  action(:restrict_access_add_restriction_btn_clk) { |b| b.restrict_access_add_restriction_btn.click }
  element(:restrict_access_activity_completion_btn) { |b| b.button(text:"Activity completion")}
  action(:restrict_access_activity_completion_btn_clk) { |b| b.restrict_access_activity_completion_btn.click }
  element(:restrict_access_date_btn) { |b| b.button(text:"Date")}
  action(:restrict_access_date_btn_clk) { |b| b.restrict_access_date_btn.click }
  element(:restrict_access_grade_btn) { |b| b.button(text:"Grade")}
  action(:restrict_access_grade_btn_clk) { |b| b.restrict_access_grade_btn.click }
  element(:restrict_access_user_profile_btn) { |b| b.button(text:"User profile")}
  action(:restrict_access_user_profile_btn_clk) { |b| b.restrict_access_user_profile_btn.click }
  element(:restrict_access_restriction_set_btn) { |b| b.button(text:"Restriction set")}
  action(:restrict_access_restriction_set_btn_clk) { |b| b.restrict_access_restriction_set_btn.click }
  element(:restrict_access_cancel_btn) { |b| b.button(text:"Cancel")}
  action(:restrict_access_cancel_btn_clk) { |b| b.restrict_access_cancel_btn.click }

  #Activity completion
  element(:activity_completion_link) { |b| b.a(text:"Activity completion")}
  element(:completion_select) { |b| b.select_list(id:"id_completion")}
  element(:completion_view_chkbox) { |b| b.input(id:"id_completionview")}
  element(:completion_use_grade_chkbox) { |b| b.input(id:"id_completionusegrade")}
  element(:completion_expected_enabled_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  element(:activity_completion_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:activity_completion_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:activity_completion_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span.tag:nth-child(2) span")}

  #Competencies
  element(:competencies_link) { |b| b.a(text:"Competencies")}
  element(:competency_rule_select) { |b| b.select_list(id:"id_competency_rule")}

  #Submit Buttons
  element(:workshop_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:workshop_saveandreturncourse_btn_clk) { |b| b.workshop_saveandreturncourse_btn.click }
  element(:workshop_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:workshop_saveanddisplay_btn_clk) { |b| b.workshop_saveanddisplay_btn.click }

  #Edit assessment form
  element(:edit_assessment_form_lnk) { |b| b.a(css:"ul.tasks li:nth-child(3) a[href*='editform']")}
  element(:aspect1_description_txt) { |b| b.div(id:"id_description__idx_0_editoreditable")}
  element(:blanks_for_more_aspects_btn) { |b| b.input(css:"input[value='Blanks for 2 more aspects']")}
  element(:saveandclose_btn) { |b| b.input(id:"id_saveandclose") }
  action(:saveandclose_btn_clk) { |b| b.saveandclose_btn.click }

  #Switch to the next phase
  element(:switch_to_the_next_phase_link) { |b| b.img(css:".phase20 a img[title='Switch phase']")}
  element(:continue_btn) { |b| b.button(type:"submit") }
  action(:continue_btn_clk) { |b| b.continue_btn.click }

  #Edit
  element(:workshop_edit_dropdown) { |b| b.a(css:"#page-content .dropdown-toggle")}
  element(:workshop_edit_link) { |b| b.a(text:"Edit settings")}

end
