class SubmitFeedbackPage < BasePage

  #Moodle Submit Feedback Page Elements
  element(:answer_the_questions_link) { |b| b.a(text:"Answer the questions...") }
  element(:select_choice_radio) { |b| b.input(css:"div.feedback_itemlist input[value='2']")}

  element(:submit_answers_btn) { |b| b.input(id:"id_savevalues") }
  action(:submit_answers_btn_clk) { |b| b.submit_answers_btn.click }

  element(:submitted_answers_link) { |b| b.a(text:"Submitted answers") }

  element(:cancel_btn) { |b| b.input(id:"id_cancel") }
  action(:cancel_btn_clk) { |b| b.cancel_btn.click }

end
