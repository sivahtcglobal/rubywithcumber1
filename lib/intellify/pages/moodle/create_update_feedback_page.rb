class CourseFeedbackPage < BasePage

  #Moodle Create Feedback Page Elements
  element(:feedback_name_txt) { |b| b.text_field(id:"id_name")}
  element(:feedback_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Availability
  element(:availability_link) { |b| b.a(text:"Availability")}
  element(:time_open_chkbox) { |b| b.input(id:"id_timeopen_enabled")}
  element(:time_open_day_select) { |b| b.select_list(id:"id_timeopen_day")}
  element(:time_open_month_select) { |b| b.select_list(id:"id_timeopen_month")}
  element(:time_open_year_select) { |b| b.select_list(id:"id_timeopen_year")}
  element(:time_open_hour_select) { |b| b.select_list(id:"id_timeopen_hour")}
  element(:time_open_minute_select) { |b| b.select_list(id:"id_timeopen_minute")}
  element(:time_close_chkbox) { |b| b.input(id:"id_timeclose_enabled")}
  element(:time_close_day_select) { |b| b.select_list(id:"id_timeclose_day")}
  element(:time_close_month_select) { |b| b.select_list(id:"id_timeclose_month")}
  element(:time_close_year_select) { |b| b.select_list(id:"id_timeclose_year")}
  element(:time_close_hour_select) { |b| b.select_list(id:"id_timeclose_hour")}
  element(:time_close_minute_select) { |b| b.select_list(id:"id_timeclose_minute")}

  #Question and submission settings
  element(:question_submission_settings_link) { |b| b.a(text:"Question and submission settings")}
  element(:record_user_names_select) { |b| b.select_list(id:"id_anonymous")}
  element(:allow_multiple_submissions_select) { |b| b.select_list(id:"id_multiple_submit")}
  element(:email_notification_select) { |b| b.select_list(id:"id_email_notification")}
  element(:auto_numbering_select) { |b| b.select_list(id:"id_autonumbering")}

  #After submission
  element(:after_submission_link) { |b| b.a(text:"After submission")}
  element(:publish_stats_select) { |b| b.select_list(id:"id_publish_stats")}
  element(:completion_message_txt) { |b| b.div(css:"div#id_page_after_submit_editoreditable")}
  element(:link_to_next_activity_txt) { |b| b.text_field(id:"id_site_after_submit")}

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
  element(:activity_require_view_chkbox) { |b| b.input(id:"id_completionview")}
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

  #Competencies
  element(:competencies_link) { |b| b.a(text:"Competencies")}
  element(:search_competencies) { |b| b.span(css:"fieldset#id_competenciessection div.fitem span.form-autocomplete-downarrow")}
  element(:select_first_competency) { |b| b.li(css:"ul.form-autocomplete-suggestions li:nth-child(1)")}
  element(:select_second_competency) { |b| b.li(css:"fieldset#id_competenciessection ul.form-autocomplete-suggestions li:nth-child(2)")}
  element(:delete_competency) { |b| b.span(css:"fieldset#id_competenciessection span.tag:nth-child(2) span")}

  #Submit Buttons
  element(:feedback_cancel_btn) { |b| b.input(id:"id_cancel")}
  action(:feedback_cancel_btn_clk) { |b| b.feedback_cancel_btn.click }
  element(:feedback_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:feedback_saveandreturncourse_btn_clk) { |b| b.feedback_saveandreturncourse_btn.click }
  element(:feedback_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:feedback_saveanddisplay_btn_clk) { |b| b.feedback_saveanddisplay_btn.click }

  #Add Questions
  element(:edit_questions_tab) { |b| b.a(title:"Edit questions")}
  element(:question_type_select) { |b| b.select(css:"select[name='typ']")}

  #Multiple Choice Question Parameters
  element(:question_name_txt) { |b| b.text_field(name:"name")}
  element(:multiple_choice_values_txt) { |b| b.textarea(id:"id_values")}
  element(:save_question_btn) { |b| b.input(id:"id_save_item") }
  action(:save_question_btn_clk) { |b| b.save_question_btn.click }

end
