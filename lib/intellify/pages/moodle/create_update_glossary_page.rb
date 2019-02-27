class CourseGlossaryPage < BasePage

  #Moodle Create Glossary Page Elements
  element(:glossary_name_txt) { |b| b.text_field(id:"id_name")}
  element(:glossary_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Entries
  element(:entries_link) { |b| b.a(text:"Entries")}
  element(:entries_default_approval_select) { |b| b.select_list(id:"id_defaultapproval")}
  element(:entries_edit_always_select) { |b| b.select_list(id:"id_editalways")}
  element(:entries_allow_duplicate_select) { |b| b.select_list(id:"id_allowduplicatedentries")}
  element(:entries_allow_comments_select) { |b| b.select_list(id:"id_allowcomments")}
  element(:entries_dynamic_link_select) { |b| b.select_list(id:"id_usedynalink")}

  #Appearance
  element(:appearance_link) { |b| b.a(text:"Appearance")}
  element(:appearance_display_format_select) { |b| b.select_list(id:"id_displayformat")}
  element(:appearance_approval_format_select) { |b| b.select_list(id:"id_approvaldisplayformat")}
  element(:appearance_entries_per_page_txt) { |b| b.text_field(id:"id_entbypage")}
  element(:appearance_show_alphabet_select) { |b| b.select_list(id:"id_showalphabet")}
  element(:appearance_show_all_select) { |b| b.select_list(id:"id_showall")}
  element(:appearance_show_special_select) { |b| b.select_list(id:"id_showspecial")}
  element(:appearance_allow_print_view_select) { |b| b.select_list(id:"id_allowprintview")}

  #Grade
  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:grade_category_select) { |b| b.select_list(id:"id_gradecat")}
  element(:grade_to_pass_txt) { |b| b.text_field(id:"id_gradepass")}

  #Ratings
  element(:ratings_link) { |b| b.a(text:"Ratings")}
  element(:ratings_assessed_select) { |b| b.select_list(id:"id_assessed")}
  element(:ratings_scale_grade_type_select) { |b| b.select_list(id:"id_scale_modgrade_type")}
  element(:ratings_scale_grade_scale_select) { |b| b.select_list(id:"id_scale_modgrade_scale")}
  element(:ratings_scale_grade_point_txt) { |b| b.text_field(id:"id_scale_modgrade_point")}
  element(:ratings_rating_time_chkbox) { |b| b.input(id:"id_ratingtime")}
  element(:ratings_from_day_select) { |b| b.select_list(id:"id_assesstimestart_day")}
  element(:ratings_from_month_select) { |b| b.select_list(id:"id_assesstimestart_month")}
  element(:ratings_from_year_select) { |b| b.select_list(id:"id_assesstimestart_year")}
  element(:ratings_from_hour_select) { |b| b.select_list(id:"id_assesstimestart_hour")}
  element(:ratings_from_minute_select) { |b| b.select_list(id:"id_assesstimestart_minute")}
  element(:ratings_to_day_select) { |b| b.select_list(id:"id_assesstimefinish_day")}
  element(:ratings_to_month_select) { |b| b.select_list(id:"id_assesstimefinish_month")}
  element(:ratings_to_year_select) { |b| b.select_list(id:"id_assesstimefinish_year")}
  element(:ratings_to_hour_select) { |b| b.select_list(id:"id_assesstimefinish_hour")}
  element(:ratings_to_minute_select) { |b| b.select_list(id:"id_assesstimefinish_minute")}

  #Common Module Settings
  element(:common_module_settings_link) { |b| b.a(text:"Common module settings")}
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
  element(:activity_completion_grade_chkbox) { |b| b.input(id:"id_completionusegrade")}
  element(:activity_completion_entries_chkbox) { |b| b.input(id:"id_completionentriesenabled")}
  element(:activity_completion_entries_txt) { |b| b.text_field(id:"id_completionentries")}
  element(:activity_completion_expected_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  element(:activity_completion_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:activity_completion_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:activity_completion_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}

  #Competencies
  element(:competencies_link) { |b| b.a(text:"Competencies")}

  #Submit Buttons
  element(:glossary_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:glossary_saveandreturncourse_btn_clk) { |b| b.glossary_saveandreturncourse_btn.click }
  element(:glossary_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:glossary_saveanddisplay_btn_clk) { |b| b.glossary_saveanddisplay_btn.click }

end
