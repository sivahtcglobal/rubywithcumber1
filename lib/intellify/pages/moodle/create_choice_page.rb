class CourseChoicePage < BasePage

  #Moodle Choice Page Elements
  element(:choice_name_txt) { |b| b.text_field(id:"id_name")}
  element(:choice_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}
  element(:display_mode_select) { |b| b.select_list(id:"id_display")}

  #Options
  element(:allow_update_select) { |b| b.select_list(id:"id_allowupdate")}
  element(:allow_multiple_choice_select) { |b| b.select_list(id:"id_allowmultiple")}
  element(:response_limit_select) { |b| b.select_list(id:"id_limitanswers")}
  element(:option_1_txt) { |b| b.text_field(id:"id_option_0")}
  element(:limit_1_txt) { |b| b.text_field(id:"id_limit_0")}
  element(:option_2_txt) { |b| b.text_field(id:"id_option_1")}
  element(:limit_2_txt) { |b| b.text_field(id:"id_limit_1")}
  element(:option_3_txt) { |b| b.text_field(id:"id_option_2")}
  element(:limit_3_txt) { |b| b.text_field(id:"id_limit_2")}
  element(:option_4_txt) { |b| b.text_field(id:"id_option_3")}
  element(:limit_4_txt) { |b| b.text_field(id:"id_limit_3")}
  element(:option_5_txt) { |b| b.text_field(id:"id_option_4")}
  element(:limit_5_txt) { |b| b.text_field(id:"id_limit_4")}

  #Availability
  element(:availability_link) { |b| b.a(text:"Availability")}
  element(:time_restrict_chkbox) { |b| b.input(id:"id_timerestrict")}
  element(:allow_responses_from_chkbox) { |b| b.input(name:"timeopen[enabled]")}
  element(:from_day_select) { |b| b.select_list(id:"id_timeopen_day")}
  element(:from_month_select) { |b| b.select_list(id:"id_timeopen_month")}
  element(:from_year_select) { |b| b.select_list(id:"id_timeopen_year")}
  element(:from_hour_select) { |b| b.select_list(id:"id_timeopen_hour")}
  element(:from_minute_select) { |b| b.select_list(id:"id_timeopen_minute")}
  element(:allow_responses_until_chkbox) { |b| b.input(name:"timeclose[enabled]")}
  element(:to_day_select) { |b| b.select_list(id:"id_timeclose_day")}
  element(:to_month_select) { |b| b.select_list(id:"id_timeclose_month")}
  element(:to_year_select) { |b| b.select_list(id:"id_timeclose_year")}
  element(:to_hour_select) { |b| b.select_list(id:"id_timeclose_hour")}
  element(:to_minute_select) { |b| b.select_list(id:"id_timeclose_minute")}
  element(:show_preview_chkbox) { |b| b.input(id:"id_showpreview")}

  #Results
  element(:results_link) { |b| b.a(text:"Results")}
  element(:publish_results_select) { |b| b.select_list(id:"id_showresults")}
  element(:privacy_results_select) { |b| b.select_list(id:"id_publish")}
  element(:show_unanswered_column_select) { |b| b.select_list(id:"id_showunanswered")}
  element(:include_inactive_select) { |b| b.select_list(id:"id_includeinactive")}

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
  element(:activity_completion_view_chkbox) { |b| b.input(id:"id_completionview")}
  element(:activity_completion_submit_chkbox) { |b| b.input(id:"id_completionsubmit")}
  element(:activity_completion_expected_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  element(:activity_completion_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:activity_completion_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:activity_completion_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span[role='listitem']:nth-child(2) span")}

  #Submit Buttons
  element(:choice_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:choice_saveandreturncourse_btn_clk) { |b| b.choice_saveandreturncourse_btn.click }
  element(:choice_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:choice_saveanddisplay_btn_clk) { |b| b.choice_saveanddisplay_btn.click }

end
