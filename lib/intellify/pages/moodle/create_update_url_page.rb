class CourseURLPage < BasePage

  #Moodle Create URL Page Elements
  element(:url_name_txt) { |b| b.text_field(id:"id_name")}
  element(:external_url_txt) { |b| b.text_field(id:"id_externalurl")}
  element(:url_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Appearance
  element(:appearance_link) { |b| b.a(text:"Appearance")}
  element(:appearance_display_select) { |b| b.select_list(id:"id_display")}
  element(:appearance_popup_width_txt) { |b| b.text_field(id:"id_popupwidth")}
  element(:appearance_popup_height_txt) { |b| b.text_field(id:"id_popupheight")}
  element(:display_url_description_chkbox) { |b| b.input(id:"id_printintro")}

  #URL Variables
  element(:url_variables_link) { |b| b.a(text:"URL variables")}
  element(:url_variable_parameter_0_txt) { |b| b.text_field(id:"id_parameter_0")}
  element(:url_variable_0_select) { |b| b.select_list(id:"id_variable_0")}
  element(:url_variable_parameter_1_txt) { |b| b.text_field(id:"id_parameter_1")}
  element(:url_variable_1_select) { |b| b.select_list(id:"id_variable_1")}
  element(:url_variable_parameter_2_txt) { |b| b.text_field(id:"id_parameter_2")}
  element(:url_variable_2_select) { |b| b.select_list(id:"id_variable_2")}
  element(:url_variable_parameter_3_txt) { |b| b.text_field(id:"id_parameter_3")}
  element(:url_variable_3_select) { |b| b.select_list(id:"id_variable_3")}
  element(:url_variable_parameter_4_txt) { |b| b.text_field(id:"id_parameter_4")}
  element(:url_variable_4_select) { |b| b.select_list(id:"id_variable_4")}

  #Common Module Settings
  element(:common_module_link) { |b| b.a(text:"Common module settings")}
  element(:common_module_visible_select) { |b| b.select_list(id:"id_visible")}
  element(:common_module_id_number_txt) { |b| b.text_field(id:"id_cmidnumber")}

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
  element(:activity_completion_view_chkbox) { |b| b.input(id:"id_completionview")}
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
  element(:url_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:url_saveandreturncourse_btn_clk) { |b| b.url_saveandreturncourse_btn.click }
  element(:url_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:url_saveanddisplay_btn_clk) { |b| b.url_saveanddisplay_btn.click }

end
