class QuizAttemptPage < BasePage

  #Moodle Quiz Attempt Page Elements
  element(:select_answer_radio) { |b| b.input(css:"div.answer div.r0 input")}

  element(:attempt_quiz_btn) { |b| b.button(css:"div.quizstartbuttondiv button")}
  action(:attempt_quiz_btn_clk) { |b| b.attempt_quiz_btn.click }

  element(:attempt_quiz_button) { |b| b.button(css:"div.quizstartbuttondiv input[value='Attempt quiz now']")}
  action(:attempt_quiz_button_clk) { |b| b.attempt_quiz_button.click }

  element(:start_attempt_btn) { |b| b.input(id:"id_submitbutton") }
  action(:start_attempt_btn_clk) { |b| b.start_attempt_btn.click }

  element(:finish_attempt_btn) { |b| b.input(css:"div.submitbtns input") }
  action(:finish_attempt_btn_clk) { |b| b.finish_attempt_btn.click }

  element(:submit_all_and_finish_btn) { |b| b.button(css:"div.submitbtns:nth-child(7) button") }
  action(:submit_all_and_finish_btn_clk) { |b| b.submit_all_and_finish_btn.click }

  element(:submit_all_and_finish_button) { |b| b.button(css:"div.submitbtns:nth-child(7) input[value='Submit all and finish']") }
  action(:submit_all_and_finish_button_clk) { |b| b.submit_all_and_finish_button.click }

  element(:confirm_submit_all_and_finish_btn) { |b| b.input(css:"div.confirmation-buttons input[value='Submit all and finish']") }
  action(:confirm_submit_all_and_finish_btn_clk) { |b| b.confirm_submit_all_and_finish_btn.click }

  element(:preview_quiz) {|b| b.input(value:"Preview quiz now")}
end
