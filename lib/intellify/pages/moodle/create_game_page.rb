class CourseGamePage < BasePage

  #Moodle Game Page Elements
  element(:game_name_txt) { |b| b.text_field(id:"id_name")}
  element(:source_module_select) { |b| b.select_list(id:"id_sourcemodule")}
  element(:glossary_select) { |b| b.select_list(id:"id_glossaryid")}
  element(:glossary_category_select) { |b| b.select_list(id:"id_glossarycategoryid")}
  element(:only_approved_select) { |b| b.select_list(id:"id_glossaryonlyapproved")}
  element(:question_category_select) { |b| b.select_list(id:"id_questioncategoryid")}
  element(:quiz_select) { |b| b.select_list(id:"id_quizid")}
  element(:book_select) { |b| b.select_list(id:"id_bookid")}
  element(:max_attempts_txt) { |b| b.text_field(id:"id_maxattempts")}
  element(:disable_summarize_select) { |b| b.select_list(id:"id_disablesummarize")}
  element(:show_high_score_txt) { |b| b.text_field(id:"id_highscore")}

  #Grade
  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:grade_category_select) { |b| b.select_list(id:"id_gradecat")}
  element(:gradepass_txt) { |b| b.text_field(id:"id_gradepass")}
  element(:max_grade_txt) { |b| b.text_field(id:"id_grade")}
  element(:grading_method_select) { |b| b.select_list(id:"id_grademethod")}
  element(:open_game_chkbox) { |b| b.input(id:"id_timeopen_enabled")}
  element(:open_game_day_select) { |b| b.select_list(id:"id_timeopen_day")}
  element(:open_game_month_select) { |b| b.select_list(id:"id_timeopen_month")}
  element(:open_game_year_select) { |b| b.select_list(id:"id_timeopen_year")}
  element(:open_game_hour_select) { |b| b.select_list(id:"id_timeopen_hour")}
  element(:open_game_minute_select) { |b| b.select_list(id:"id_timeopen_minute")}
  element(:close_game_chkbox) { |b| b.input(id:"id_timeclose_enabled")}
  element(:close_game_day_select) { |b| b.select_list(id:"id_timeclose_day")}
  element(:close_game_month_select) { |b| b.select_list(id:"id_timeclose_month")}
  element(:close_game_year_select) { |b| b.select_list(id:"id_timeclose_year")}
  element(:close_game_hour_select) { |b| b.select_list(id:"id_timeclose_hour")}
  element(:close_game_minute_select) { |b| b.select_list(id:"id_timeclose_minute")}

  #Book Quiz Options
  element(:bookquiz_options_link) { |b| b.a(text:"Bookquiz options")}
  element(:layout_select) { |b| b.select_list(id:"id_param3")}

  #Crossword options
  element(:crossword_options_link) { |b| b.a(text:"Crossword options")}
  element(:max_cols_rows_txt) { |b| b.text_field(id:"id_param1")}
  element(:min_words_txt) { |b| b.text_field(id:"id_param4")}
  element(:max_words_txt) { |b| b.text_field(id:"id_param2")}
  element(:allow_spaces_select) { |b| b.select_list(id:"id_param7")}
  element(:disable_transform_select) { |b| b.select_list(id:"id_param6")}
  element(:max_compute_time_txt) { |b| b.text_field(id:"id_param8")}

  #Header/Footer Options
  element(:header_footer_options_link) { |b| b.a(text:"Header/Footer Options")}
  element(:text_at_top_description_txt) { |b| b.div(id:"id_toptexteditable")}
  element(:text_at_bottom_description_txt) { |b| b.div(id:"id_bottomtexteditable")}

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
  element(:activity_completion_user_grade_chkbox) { |b| b.input(id:"id_completionusegrade")}
  element(:activity_completion_pass_chkbox) { |b| b.input(id:"id_completionpass")}
  element(:activity_completion_group_attempts_chkbox) { |b| b.input(id:"id_completionattemptsexhausted")}
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
  element(:game_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:game_saveandreturncourse_btn_clk) { |b| b.game_saveandreturncourse_btn.click }
  element(:game_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:game_saveanddisplay_btn_clk) { |b| b.game_saveanddisplay_btn.click }

  element(:attempt_game_now_btn) { |b| b.button(text:"Attempt game now") }
  action(:attempt_game_now_btn_clk) { |b| b.attempt_game_now_btn.click }

end
