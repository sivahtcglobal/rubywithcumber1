class SurveyResponsePage < BasePage

  #Moodle Survey Response Page Elements
  element(:survey_question_1) { |b| b.textarea(id:"q69")}
  element(:survey_question_2) { |b| b.textarea(id:"q70")}
  element(:survey_question_3) { |b| b.textarea(id:"q71")}
  element(:survey_question_4) { |b| b.textarea(id:"q72")}
  element(:survey_question_5) { |b| b.textarea(id:"q73")}

  element(:continue_btn) { |b| b.input(value:"Click here to continue") }
  action(:continue_btn_clk) { |b| b.continue_btn.click }

  element(:survey_confirmation_msg) { |b| b.div(id:"notice")}
  element(:view_survey_responses_link) { |b| b.a(css:".reportlink a")}

end
