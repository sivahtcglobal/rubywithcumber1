class CourseAdvancedForumPage < BasePage

  #Moodle Advanced Forum Page Elements
  element(:advanced_forum_name_txt) { |b| b.text_field(id:"id_name")}
  element(:advanced_forum_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}
  element(:display_post_chkbox) { |b| b.input(id:"id_showrecent")}

  element(:forum_type_select) { |b| b.select_list(id:"id_type")}

  #Post Options
  element(:post_options_link) { |b| b.a(text:"Post options")}
  element(:post_options_substantive_chkbox) { |b| b.input(id:"id_showsubstantive")}
  element(:post_options_bookmarking_chkbox) { |b| b.input(id:"id_showbookmark")}
  element(:post_options_private_replies_chkbox) { |b| b.input(id:"id_allowprivatereplies")}
  element(:post_options_anonymous_chkbox) { |b| b.input(id:"id_anonymous")}
  element(:post_options_word_count_chkbox) { |b| b.input(id:"id_displaywordcount")}

  #Attachments
  element(:attachments_link) { |b| b.a(text:"Attachments")}
  element(:max_size_select) { |b| b.select_list(id:"id_maxbytes")}
  element(:max_attachments_select) { |b| b.select_list(id:"id_maxattachments")}

  #Subscription
  element(:subscription_link) { |b| b.a(text:"Subscription")}
  element(:subscription_mode_select) { |b| b.select_list(id:"id_forcesubscribe")}

  #Post threshold for blocking
  element(:post_threshold_link) { |b| b.a(text:"Post threshold for blocking")}
  element(:block_period_select) { |b| b.select_list(id:"id_blockperiod")}
  element(:block_after_txt) { |b| b.input(id:"id_blockafter")}
  element(:warn_after_txt) { |b| b.input(id:"id_warnafter")}

  #Grade
  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:grade_type_select) { |b| b.select_list(id:"id_gradetype")}
  element(:scale_grade_type_select) { |b| b.select_list(id:"id_scale_modgrade_type")}
  element(:scale_grade_scale_select) { |b| b.select_list(id:"id_scale_modgrade_scale")}
  element(:scale_grade_point_txt) { |b| b.input(id:"id_scale_modgrade_point")}
  element(:grade_category_select) { |b| b.select_list(id:"id_gradecat")}
  element(:grade_to_pass_txt) { |b| b.input(id:"id_gradepass")}

  #Ratings
  element(:ratings_link) { |b| b.a(text:"Ratings")}
  element(:aggregate_type_select) { |b| b.select_list(id:"id_assessed")}
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

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span[role='listitem']:nth-child(2) span")}

  #Submit Buttons
  element(:advanced_forum_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:advanced_forum_saveandreturncourse_btn_clk) { |b| b.advanced_forum_saveandreturncourse_btn.click }
  element(:advanced_forum_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:advanced_forum_saveanddisplay_btn_clk) { |b| b.advanced_forum_saveanddisplay_btn.click }
  element(:advanced_forum_addanewdiscussion_btn) { |b| b.input(value:"Add a new discussion")}
  action(:advanced_forum_addanewdiscussion_btn_clk) { |b| b.advanced_forum_addanewdiscussion_btn.click }

  element(:advanced_forum_discussion_subject) { |b| b.input(name:"subject")}
  element(:advanced_forum_discussion_post) { |b| b.div(class:"hsuforum-textarea")}

  element(:post_discussion_submit_btn) { |b| b.button(text:"Submit")}
  action(:post_discussion_submit_btn_clk) { |b| b.post_discussion_submit_btn.click }

end
