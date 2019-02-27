class SubmitAnswersPage < BasePage

  #Moodle Submit Answers Page Elements
  element(:short_answer_txt) { |b| b.text_field(id:"id_answer")}

  element(:essay_answer_txt) { |b| b.div(id:"id_answereditable")}

  element(:congratulations_txt) { |b| b.h3(css:"section#region-main h3")}

  element(:submit_btn) { |b| b.input(id:"id_submitbutton") }
  action(:submit_btn_clk) { |b| b.submit_btn.click }

  element(:continue_btn) { |b| b.input(text:"Continue") }
  action(:continue_btn_clk) { |b| b.continue_btn.click }

  element(:restart_lesson_btn) { |b| b.button(text:"Continue") }
  action(:restart_lesson_btn_clk) { |b| b.restart_lesson_btn.click }

  element(:answer_the_questions_link) { |b| b.a(css:"section#region-main a[href*='questionnaire/complete']") }
  element(:selected_answer_radio) { |b| b.input(css:"div.qn-answer input[value='y']") }

  element(:next_page_btn) { |b| b.input(css:"input[value*='Next Page']")}
  action(:next_page_btn_clk) { |b| b.next_page_btn.click }

  element(:resume_questionnaire_link) { |b| b.a(css:"section#region-main a[href*='questionnaire/complete']")}
  element(:resume_lesson_link) { |b| b.a(css:"span.lessonbutton:nth-child(1) a")}

  element(:submit_questionnaire_btn) { |b| b.input(value:"Submit questionnaire")}
  action(:submit_questionnaire_btn_clk) { |b| b.submit_questionnaire_btn.click }

  element(:questionnaire_continue_btn) { |b| b.a(css:"section#region-main a") }
  action(:questionnaire_continue_btn_clk) { |b| b.questionnaire_continue_btn.click }

  element(:your_response_link) { |b| b.a(css:"div.yourresponse a") }
  element(:view_all_responses_link) { |b| b.a(css:"div.allresponses a") }
  element (:all_responses_breadcrumb) { |b| b.a(css:"div.breadcrumb-nav li:nth-last-child(3) a")}

end
