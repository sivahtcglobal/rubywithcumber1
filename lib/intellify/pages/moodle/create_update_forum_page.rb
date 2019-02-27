class CourseForumPage < BasePage

  #Moodle Forum Page Elements
  element(:forum_name_txt) { |b| b.text_field(id:"id_name")}
  element(:forum_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}

  element(:forum_type_select) { |b| b.select_list(id:"id_type")}

  #Attachments and word count
  element(:attachments_link) { |b| b.a(text:"Attachments and word count")}
  element(:max_size_select) { |b| b.select_list(id:"id_maxbytes")}
  element(:max_attachments_select) { |b| b.select_list(id:"id_maxattachments")}
  element(:display_word_count_select) { |b| b.select_list(id:"id_displaywordcount")}

  #Subscription and tracking
  element(:subscription_link) { |b| b.a(text:"Subscription and tracking")}
  element(:subscription_mode_select) { |b| b.select_list(id:"id_forcesubscribe")}
  element(:read_tracking_select) { |b| b.select_list(id:"id_trackingtype")}

  #Discussion locking
  element(:discussion_locking_link) { |b| b.a(text:"Discussion locking")}
  element(:lock_discussion_select) { |b| b.select_list(id:"id_lockdiscussionafter")}

  #Post threshold for blocking
  element(:post_threshold_link) { |b| b.a(text:"Post threshold for blocking")}
  element(:block_period_select) { |b| b.select_list(id:"id_blockperiod")}
  element(:block_after_txt) { |b| b.input(id:"id_blockafter")}
  element(:warn_after_txt) { |b| b.input(id:"id_warnafter")}

  #Grade
  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:grade_category_select) { |b| b.select_list(id:"id_gradecat")}
  element(:grade_to_pass_txt) { |b| b.input(id:"id_gradepass")}

  #Ratings
  element(:ratings_link) { |b| b.a(text:"Ratings")}
  element(:aggregate_type_select) { |b| b.select_list(id:"id_assessed")}
  element(:ratings_scale_grade_type_select) { |b| b.select_list(id:"id_scale_modgrade_type")}
  element(:ratings_scale_grade_scale_select) { |b| b.select_list(id:"id_scale_modgrade_scale")}
  element(:ratings_scale_grade_point_txt) { |b| b.text_field(id:"id_scale_modgrade_point")}
  element(:rating_time_chkbox) { |b| b.input(id:"id_ratingtime")}
  element(:from_day_select) { |b| b.select_list(id:"id_assesstimestart_day")}
  element(:from_month_select) { |b| b.select_list(id:"id_assesstimestart_month")}
  element(:from_year_select) { |b| b.select_list(id:"id_assesstimestart_year")}
  element(:from_hour_select) { |b| b.select_list(id:"id_assesstimestart_hour")}
  element(:from_minute_select) { |b| b.select_list(id:"id_assesstimestart_minute")}
  element(:to_day_select) { |b| b.select_list(id:"id_assesstimefinish_day")}
  element(:to_month_select) { |b| b.select_list(id:"id_assesstimefinish_month")}
  element(:to_year_select) { |b| b.select_list(id:"id_assesstimefinish_year")}
  element(:to_hour_select) { |b| b.select_list(id:"id_assesstimefinish_hour")}
  element(:to_minute_select) { |b| b.select_list(id:"id_assesstimefinish_minute")}

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
  element(:activity_completion_grade_chkbox) { |b| b.input(id:"id_completionusegrade")}
  element(:activity_completion_posts_chkbox) { |b| b.input(id:"id_completionpostsenabled")}
  element(:activity_completion_posts_txt) { |b| b.text_field(id:"id_completionposts")}
  element(:activity_completion_discussions_chkbox) { |b| b.input(id:"id_completiondiscussionsenabled")}
  element(:activity_completion_discussions_txt) { |b| b.text_field(id:"id_completiondiscussions")}
  element(:activity_completion_replies_chkbox) { |b| b.input(id:"id_completionrepliesenabled")}
  element(:activity_completion_replies_txt) { |b| b.text_field(id:"id_completionreplies")}
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
  element(:forum_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:forum_saveandreturncourse_btn_clk) { |b| b.forum_saveandreturncourse_btn.click }
  element(:forum_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:forum_saveanddisplay_btn_clk) { |b| b.forum_saveanddisplay_btn.click }

end
