class CourseSchedulerPage < BasePage

  #Moodle Create Scheduler Page Elements
  element(:scheduler_name_txt) { |b| b.text_field(id:"id_name")}
  element(:scheduler_introduction_txt) { |b| b.div(id:"id_introeditoreditable")}

  #Options
  element(:teacher_role_name_txt) { |b| b.input(id:"id_staffrolename")}
  element(:max_bookings_select) { |b| b.select_list(id:"id_maxbookings")}
  element(:scheduler_mode_select) { |b| b.select_list(id:"id_schedulermode")}
  element(:group_booking_select) { |b| b.select_list(id:"id_bookingrouping")}
  element(:guard_time_enable_chkbox) { |b| b.input(id:"id_guardtime_enabled")}
  element(:guard_time_number_txt) { |b| b.input(id:"id_guardtime_number")}
  element(:guard_time_timeunit) { |b| b.select_list(id:"id_guardtime_timeunit")}
  element(:default_slot_duration_txt) { |b| b.input(id:"id_defaultslotduration")}
  element(:notifications_select) { |b| b.select_list(id:"id_allownotifications")}
  element(:use_notes_select) { |b| b.select_list(id:"id_usenotes")}

  #Grade
  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:modgrade_type_select) { |b| b.select_list(id:"id_grade_modgrade_type")}
  element(:modgrade_scale_select) { |b| b.select_list(id:"id_grade_modgrade_scale")}
  element(:max_grade_txt) { |b| b.text_field(id:"id_grade_modgrade_point")}
  element(:grade_category_select) { |b| b.select_list(id:"id_gradecat")}
  element(:grade_to_pass_txt) { |b| b.text_field(id:"id_gradepass")}
  element(:grading_strategy_select) { |b| b.select_list(id:"id_gradingstrategy")}

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
  action(:rrestrict_access_cancel_btn_clk) { |b| b.restrict_access_cancel_btn.click }

  #Activity Completion
  element(:activity_completion_link) { |b| b.a(text:"Activity completion")}
  element(:activity_completion_tracking_select) { |b| b.select_list(id:"id_completion")}
  element(:activity_require_grade_chkbox) { |b| b.input(id:"id_completionusegrade")}
  element(:activity_completion_expected_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  element(:activity_completion_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:activity_completion_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:activity_completion_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span[role='listitem']:nth-child(2) span")}

  #Competencies
  element(:competencies_link) { |b| b.a(text:"Competencies")}
  element(:search_competencies) { |b| b.span(css:"fieldset#id_competenciessection div.fitem span.form-autocomplete-downarrow")}
  element(:select_first_competency) { |b| b.li(css:"ul.form-autocomplete-suggestions li:nth-child(1)")}
  element(:select_second_competency) { |b| b.li(css:"fieldset#id_competenciessection ul.form-autocomplete-suggestions li:nth-child(2)")}
  element(:delete_competency) { |b| b.span(css:"fieldset#id_competenciessection span.tag:nth-child(2) span")}

  #Submit Buttons
  element(:scheduler_cancel_btn) { |b| b.input(id:"id_cancel")}
  action(:scheduler_cancel_btn_clk) { |b| b.scheduler_cancel_btn.click }
  element(:scheduler_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:scheduler_saveandreturncourse_btn_clk) { |b| b.scheduler_saveandreturncourse_btn.click }
  element(:scheduler_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:scheduler_saveanddisplay_btn_clk) { |b| b.scheduler_saveanddisplay_btn.click }

end
