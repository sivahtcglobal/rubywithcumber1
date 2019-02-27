class CourseForumDiscussionPage < BasePage

  #Moodle Forum Discussion Page Elements
  element(:topic_addanewdiscussion_btn) { |b| b.button(text:"Add a new discussion topic")}
  action(:topic_addanewdiscussion_btn_clk) { |b| b.topic_addanewdiscussion_btn.click }

  element(:topic_subject) { |b| b.input(name:"subject")}
  element(:topic_message) { |b| b.div(id:"id_messageeditable")}
  element(:discussion_subscription_chkbx) { |b| b.input(id:"id_discussionsubscribe")}

  #Attachment
  element(:select_files_link) { |b| b.a(title:"Add...")}
  element(:server_files_link) { |b| b.span(text:"Server files")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}
  element(:pinned_chkbx) { |b| b.input(id:"id_pinned")}
  element(:send_forum_post_notification_chkbx) { |b| b.input(id:"id_mailnow")}

  #Display period
  element(:display_period_link) { |b| b.a(text:"Display period")}
  element(:time_start_chkbx) { |b| b.input(id:"id_timestart_enabled")}
  element(:time_end_chkbx) { |b| b.input(id:"id_timeend_enabled")}
  element(:from_day_select) { |b| b.select_list(id:"id_timestart_day")}
  element(:from_month_select) { |b| b.select_list(id:"id_timestart_month")}
  element(:from_year_select) { |b| b.select_list(id:"id_timestart_year")}
  element(:from_hour_select) { |b| b.select_list(id:"id_timestart_hour")}
  element(:from_minute_select) { |b| b.select_list(id:"id_timestart_minute")}
  element(:to_day_select) { |b| b.select_list(id:"id_timeend_day")}
  element(:to_month_select) { |b| b.select_list(id:"id_timeend_month")}
  element(:to_year_select) { |b| b.select_list(id:"id_timeend_year")}
  element(:to_hour_select) { |b| b.select_list(id:"id_timeend_hour")}
  element(:to_minute_select) { |b| b.select_list(id:"id_timeend_minute")}

  element(:teacher_discussion_link) { |teacherdiscussion,b| b.a(text:"#{teacherdiscussion}")}
  element(:edit_link) { |b| b.a(text:"Edit")}
  element(:display_replies_form) { |b| b.select(css:"select[name='mode']")}
  element(:student_reply_link) { |b| b.a(text:"Reply")}
  element(:pin_unpin_btn) { |b| b.button(css:"button[id*='single_button']")}

  element(:post_to_forum_btn) { |b| b.input(value:"Post to forum")}
  action(:post_to_forum_btn_clk) { |b| b.post_to_forum_btn.click }

  element(:save_changes_btn) { |b| b.input(id:"id_submitbutton")}
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

end
