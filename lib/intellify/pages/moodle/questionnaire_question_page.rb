class AddQuestionsPage < BasePage

  #Moodle Add Question Elements
  element(:add_questions_link) { |b| b.strong(text:"Add questions")}
  element(:question_type_select) { |b| b.select(id:"id_type_id")}
  #Check Boxes
  #Date
  #Dropdown Box
  #Essay Box
  #Label
  #Numeric
  #Radio Buttons
  #Rate (scale 1..5)
  #Text Box
  #Yes/No
  element(:add_selected_question_type_btn) { |b| b.input(id:"id_addqbutton")}

  element(:question_name_txt) { |b| b.input(id:"id_name")}
  element(:response_required_radio) { |b| b.input(id:"id_required_n")}
  element(:question_txt) { |b| b.div(id:"id_contenteditable")}
  element(:manage_question_name) { |b| b.p(css:"div.qn-question p")}

  #Submit Buttons
  element(:save_changes_btn) { |b| b.input(id:"id_submitbutton") }
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

end
