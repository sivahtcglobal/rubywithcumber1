class CourseItemPage < BasePage

  #Moodle Course Item Elements
  element (:course_item_breadcrumb) { |b| b.a(css:"div.breadcrumb-nav li:last-child a")}
  element (:glossary_entry_concept_lbl) { |b| b.h4(css:"div.glossarydisplay table h4")}
  element (:topic_subject_link) { |b| b.a(css:"article.hsuforum-thread:nth-child(2) div.hsuforum-thread-title a")}
  element (:student_post_txt) { |b| b.div(css:"div.hsuforum-post-content .posting")}
  element (:student_updated_post_txt) { |b| b.div(css:"li:last-child div.hsuforum-post-content .posting")}
  element (:student_message_txt) { |b| b.p(css:"div.forumpost:last-child p")}
  element (:teacher_message_txt) { |b| b.p(css:"div.fullpost:last-child p")}
  element (:teacher_subject_txt) { |b| b.h4(css:"article.hsuforum-post-target h4")}
  element (:lesson_content_page_txt) { |b| b.h3(css:"div#page-content section#region-main h3")}
  element (:wiki_page_txt) { |b| b.h2(css:"section#region-main h2")}
  element (:wiki_name_link) { |b| b.a(css:"div.breadcrumb-nav li:nth-last-child(3) a")}
  element (:journal_name_link) { |b| b.a(css:"div.breadcrumb-nav li:nth-last-child(2) a")}
  element (:questionnaire_txt) { |b| b.h3(css:"section#region-main h3")}
  element (:lti_external_tool_txt) { |b| b.h2(css:"section#region-main h2")}
  element (:nln_learning_object_name_txt) { |b| b.h2(css:"section#region-main h2")}
  element (:view_past_chat_sessions_link) { |b| b.a(css:"div.breadcrumb-nav li:nth-last-child(2) a")}
  element (:survey_report_txt) { |b| b.li(css:"div.breadcrumb-nav li:nth-last-child(2)")}
  element (:choice_responses_txt) { |b| b.li(css:"div.breadcrumb-nav li:last-child")}

  element (:add_a_new_glossary_entry_btn) { |b| b.input(value:"Add a new entry")}
  action(:add_a_new_glossary_entry_btn_clk) { |b| b.add_a_new_glossary_entry_btn.click }

  #Email Error Continue Link
  element(:error_continue_link) { |b| b.a(text:"Continue")}

end
