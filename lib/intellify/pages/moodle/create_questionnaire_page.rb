class CourseQuestionnairePage < BasePage

  #Moodle Questionnaire Page Elements
  element(:questionnaire_name_txt) { |b| b.text_field(id:"id_name")}
  element(:questionnaire_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Timing
  element(:timing_link) { |b| b.a(text:"Timing")}
  element(:use_open_date_chkbox) { |b| b.input(name:"useopendate")}
  element(:from_day_select) { |b| b.select_list(id:"id_opendate_day")}
  element(:from_month_select) { |b| b.select_list(id:"id_opendate_month")}
  element(:from_year_select) { |b| b.select_list(id:"id_opendate_year")}
  element(:from_hour_select) { |b| b.select_list(id:"id_opendate_hour")}
  element(:from_minute_select) { |b| b.select_list(id:"id_opendate_minute")}
  element(:use_close_date_chkbox) { |b| b.input(name:"useclosedate")}
  element(:to_day_select) { |b| b.select_list(id:"id_closedate_day")}
  element(:to_month_select) { |b| b.select_list(id:"id_closedate_month")}
  element(:to_year_select) { |b| b.select_list(id:"id_closedate_year")}
  element(:to_hour_select) { |b| b.select_list(id:"id_closedate_hour")}
  element(:to_minute_select) { |b| b.select_list(id:"id_closedate_minute")}

  #Response Options
  element(:response_options_link) { |b| b.a(text:"Response options")}
  element(:response_type_select) { |b| b.select_list(id:"id_qtype")}
  element(:respondent_type_select) { |b| b.select_list(id:"id_respondenttype")}
  element(:response_view_select) { |b| b.select_list(id:"id_resp_view")}
  element(:notifications_select) { |b| b.select_list(id:"id_notifications")}
  element(:resume_select) { |b| b.select_list(id:"id_resume")}
  element(:branching_question_select) { |b| b.select_list(id:"id_navigate")}
  element(:auto_numbering_select) { |b| b.select_list(id:"id_autonum")}
  element(:grade_select) { |b| b.select_list(id:"id_grade")}

  #Content Options
  element(:content_options_link) { |b| b.a(text:"Content options")}
  element(:create_new_radio) { |b| b.input(id:"id_create_new-0")}

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
  element(:activity_completion_submit_chkbox) { |b| b.input(id:"id_completionsubmit")}
  element(:activity_completion_expected_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  element(:activity_completion_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:activity_completion_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:activity_completion_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span.tag:nth-child(2) span")}

  #Submit Buttons
  element(:questionnaire_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:questionnaire_saveandreturncourse_btn_clk) { |b| b.questionnaire_saveandreturncourse_btn.click }
  element(:questionnaire_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:questionnaire_saveanddisplay_btn_clk) { |b| b.questionnaire_saveanddisplay_btn.click }

end
