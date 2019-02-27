class CourseQuizDetailPage < BasePage


  element(:quiz_name_link) { |quizname,b| b.span(text:"#{quizname}")}

  #dropdown-2 Master Edit Dropdown
  element(:quiz_edit_btn) { |b| b.button(text:"Edit quiz")}
  action(:quiz_edit_btn_click) { |b| b.quiz_edit_btn.click}
  element(:quiz_add_dropdown) { |b| b.a(text:"Add")}
  #a new question
  element(:quiz_add_newquestion_link) { |b| b.span(text:"a new question")}

  #Question Type Radio Buttons
  element(:quiz_type_multichoice_link) { |b| b.input(id:"item_qtype_multichoice")}
  element(:quiz_type_truefalse_rbtn) { |b| b.input(css:"input[value='truefalse']")}
  element(:quiz_type_match_rbtn) { |b| b.input(id:"item_qtype_match")}
  element(:quiz_type_shortanswer_rbtn) { |b| b.input(id:"item_qtype_shortanswer")}
  element(:quiz_type_numerical_rbtn) { |b| b.input(id:"item_qtype_numerical")}
  element(:quiz_type_essay_rbtn) { |b| b.input(id:"item_qtype_essay")}
  element(:quiz_type_calculated_rbtn) { |b| b.input(id:"item_qtype_calculated")}
  element(:quiz_type_calculatedmulti_rbtn) { |b| b.input(id:"item_qtype_calculatedmulti")}
  element(:quiz_type_calculatedsimple_rbtn) { |b| b.input(id:"item_qtype_calculatedsimple")}
  element(:quiz_type_ddwtos_rbtn) { |b| b.input(id:"item_qtype_ddwtos")}
  element(:quiz_type_ddmarker_rbtn) { |b| b.input(id:"item_qtype_ddmarker")}
  element(:quiz_type_ddimageortext_rbtn) { |b| b.input(id:"item_qtype_ddimageortext")}
  element(:quiz_type_multianswer_rbtn) { |b| b.input(id:"item_qtype_multianswer")}
  element(:quiz_type_randomsamatch_rbtn) { |b| b.input(id:"item_qtype_randomsamatch")}
  element(:quiz_type_gapselect_rbtn) { |b| b.input(id:"item_qtype_gapselect")}
  element(:quiz_type_description_rbtn) { |b| b.input(id:"item_qtype_description")}

  #Add button to Navigate to Quiz Details Page
  element(:course_add_quiz_button) { |b| b.input(value:"Add")}

  #Add a True/False question
  element(:quiz_question_name_txt) { |b| b.text_field(id:"id_name")}
  element(:quiz_question_editor) { |b| b.div(id:"id_questiontexteditable")}
  element(:quiz_question_mark_txt) { |b| b.text_field(id:"id_defaultmark")}
  element(:quiz_feedback_editor) { |b| b.div(id:"id_generalfeedbackeditable")}
  element(:quiz_correct_answ_select) { |b| b.select_list(id:"id_correctanswer")}
  #False
  #True
  element(:quiz_feedback_true_editor) { |b| b.div(id:"id_feedbacktrueeditable")}
  element(:quiz_feedback_false_editor) { |b| b.div(id:"id_feedbackfalseeditable")}
  element(:quiz_multi_tries_lnk) { |b| b.a(text:"Multiple tries")}
  element(:quiz_tags_lnk) { |b| b.a(text:"Tags")}
  element(:quiz_tags_sendkeys_ent_txt) { |b| b.text_field(placeholder:"Enter tags...")}

  #Save Button
  element(:quiz_question_save_btn) { |b| b.input(id:"id_submitbutton")}
  action(:quiz_question_save_btn_click) { |b| b.quiz_question_save_btn.click }

end
