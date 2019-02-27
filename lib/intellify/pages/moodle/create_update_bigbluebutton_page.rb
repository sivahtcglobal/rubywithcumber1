class CourseBigBlueButtonPage < BasePage

  #Moodle Create BigBlueButton Page Elements
  #General settings
  element(:show_more_link) { |b| b.a(css:"a.moreless-toggler")}
  element(:virtual_classroom_name_txt) { |b| b.text_field(id:"id_name")}
  element(:description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:show_description_chkbox) { |b| b.input(id:"id_showdescription")}
  element(:welcome_message_txt) { |b| b.textarea(id:"id_welcome")}
  element(:wait_moderator_chkbox) { |b| b.input(id:"id_wait")}
  element(:record_chkbox) { |b| b.input(id:"id_record")}
  element(:tagging_chkbox) { |b| b.input(id:"id_tagging")}
  element(:send_notification_chkbox) { |b| b.input(id:"id_notification")}

  #Participants
  element(:participants_link) { |b| b.a(text:"Participants")}
  element(:bigbluebuttonbn_participant_selection_type_select) { |b| b.select_list(id:"bigbluebuttonbn_participant_selection_type")}
  element(:addselection_btn) { |b| b.input(id:"id_addselectionid")}
  element(:all_participant_list_role_select) { |b| b.select_list(id:"participant_list_role_all-all")}
  element(:user_list_role_select) { |b| b.select_list(css:"table[id='participant_list_table'] tr:nth-child(2) select")}

  #Schedule for session
  element(:schedule_for_session_link) { |b| b.a(text:"Schedule for session")}
  element(:start_enable_chkbox) { |b| b.input(id:"id_openingtime_enabled")}
  element(:start_day_select) { |b| b.select_list(id:"id_openingtime_day")}
  element(:start_month_select) { |b| b.select_list(id:"id_openingtime_month")}
  element(:start_year_select) { |b| b.select_list(id:"id_openingtime_year")}
  element(:start_hour_select) { |b| b.select_list(id:"id_openingtime_hour")}
  element(:start_min_select) { |b| b.select_list(id:"id_openingtime_minute")}
  element(:end_enable_chkbox) { |b| b.input(id:"id_closingtime_enabled")}
  element(:end_day_select) { |b| b.select_list(id:"id_closingtime_day")}
  element(:end_month_select) { |b| b.select_list(id:"id_closingtime_month")}
  element(:end_year_select) { |b| b.select_list(id:"id_closingtime_year")}
  element(:end_hour_select) { |b| b.select_list(id:"id_closingtime_hour")}
  element(:end_min_select) { |b| b.select_list(id:"id_closingtime_minute")}

  #Common module settings
  element(:common_module_settings_link) { |b| b.a(text:"Common module settings")}
  element(:common_module_visible_select) { |b| b.select_list(id:"id_visible")}
  element(:common_module_id_number_txt) { |b| b.text_field(id:"id_cmidnumber")}
  element(:common_module_group_mode_select) { |b| b.select_list(id:"id_groupmode")}
  element(:common_module_grouping_select) { |b| b.select_list(id:"id_groupingid")}

  #Restrict access
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

  #Activity completion
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
  element(:search_competencies) { |b| b.span(css:"fieldset#id_competenciessection div.fitem span.form-autocomplete-downarrow")}
  element(:select_first_competency) { |b| b.li(css:"ul.form-autocomplete-suggestions li:nth-child(1)")}
  element(:select_second_competency) { |b| b.li(css:"fieldset#id_competenciessection ul.form-autocomplete-suggestions li:nth-child(2)")}
  element(:delete_competency) { |b| b.span(css:"fieldset#id_competenciessection span.tag:nth-child(2) span")}
  element(:competency_rule_select) { |b| b.select_list(id:"id_competency_rule")}

  #Submit Buttons
  element(:bigbluebutton_cancel_btn) { |b| b.input(id:"id_cancel")}
  action(:bigbluebutton_cancel_btn_clk) { |b| b.bigbluebutton_cancel_btn.click }
  element(:bigbluebutton_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:bigbluebutton_saveandreturncourse_btn_clk) { |b| b.bigbluebutton_saveandreturncourse_btn.click }
  element(:bigbluebutton_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:bigbluebutton_saveanddisplay_btn_clk) { |b| b.bigbluebutton_saveanddisplay_btn.click }

  #Create and Join BigBlueButton Meeting Elements
  element(:join_session_btn) { |b| b.input(id:"join_button_input")}
  action(:join_session_btn_clk) { |b| b.join_session_btn.click }

  element(:name_recording_txt) { |b| b.input(id:"recording_name")}
  element(:description_recording_txt) { |b| b.input(id:"recording_description")}
  element(:tags_recording_txt) { |b| b.input(id:"recording_tags")}

  element(:apply_btn) { |b| b.button(text:"Apply")}
  action(:apply_btn_clk) { |b| b.apply_btn.click }

  element(:end_session_btn) { |b| b.input(id:"end_button_input")}
  action(:end_session_btn_clk) { |b| b.end_session_btn.click }

end
