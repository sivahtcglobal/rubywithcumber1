class CourseSurveyPage < BasePage

  #Moodle Create Survey Page Elements
  element(:survey_name_txt) { |b| b.text_field(id:"id_name")}
  element(:survey_type_select) { |b| b.select_list(id:"id_template")}
  element(:survey_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Common Module Settings
  element(:common_module_link) { |b| b.a(text:"Common module settings")}
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
  element(:activity_require_view_chkbox_1) { |b| b.input(id:"id_completionview")}
  element(:activity_require_view_chkbox_2) { |b| b.input(id:"id_completionsubmit")}
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

  #Submit Buttons
  element(:survey_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:survey_saveandreturncourse_btn_clk) { |b| b.survey_saveandreturncourse_btn.click }
  element(:survey_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:survey_saveanddisplay_btn_clk) { |b| b.survey_saveanddisplay_btn.click }

end
