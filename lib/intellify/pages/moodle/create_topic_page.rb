class CourseTopicPage < BasePage

  #Moodle Topic Page Elements
  element(:topic_addanewdiscussion_btn) { |b| b.input(value:"Add a new discussion")}
  action(:topic_addanewdiscussion_btn_clk) { |b| b.topic_addanewdiscussion_btn.click }

  element(:topic_subject) { |b| b.input(name:"subject")}
  element(:topic_post) { |b| b.div(class:"hsuforum-textarea")}
  element(:ratings_select) { |b| b.select_list(name:"rating")}

  element(:topic_new_link) { |b| b.a(css:"header.hsuforum-post-unread a.hsuforum-unreadcount")}
  action(:topic_new_link_clk) { |b| b.topic_new_link.click }

  element (:reply_link) { |b| b.a(css:"tr:nth-child(1) td.replies a")}
  action(:reply_link_clk) { |b| b.reply_link.click }

  element (:reply_btn) { |b| b.a(css:"a.hsuforum-reply-link:first-child")}

  element(:post_topic_submit_btn) { |b| b.button(text:"Submit")}
  action(:post_topic_submit_btn_clk) { |b| b.post_topic_submit_btn.click }

  element(:edit_link) { |b| b.a(text:"Edit")}

  element(:teacher_discussion_link) { |teacherdiscussion,b| b.a(text:"#{teacherdiscussion}")}

  element(:submit_btn) { |b| b.button(css:"form.hsuforum-discussion button[type='submit']")}
  action(:submit_btn_clk) { |b| b.submit_btn.click }

end
