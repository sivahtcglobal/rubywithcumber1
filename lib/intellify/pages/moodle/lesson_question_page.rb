class CreateAndUpdateQuestionPage < BasePage


  #expected_element :create_question_page_link,30

  #Moodle Create User Elements
  element(:create_question_page_link) { |b| b.a(text:"Create a question page")}
  element(:question_type_select) { |b| b.select(id:"id_qtype")}
  #Essay
  #Matching
  #Multichoice
  #Numerical
  #Short answer
  #True/false
  element(:page_title_txt) { |b| b.text_field(id:"id_title")}
  element(:page_content_editor) { |b| b.div(id:"id_contents_editoreditable")}

  ##Essay Page Elements
  element(:essay_page_jump_select) { |b| b.select(id:"id_jumpto_0")}
  #This page
  #Next page
  #Previous page
  #End of lesson
  element(:essay_page_score_txt) { |b| b.text_field(id:"id_score_0")}

  element(:add_question_page_btn) { |b| b.input(id:"id_submitbutton")}
  action(:add_question_page_btn_clk) { |b| b.add_question_page_btn.click }

  element(:action_select) { |b| b.select(name:"qtype")}

  #Sucessful Creation Message
  element(:question_page_success_msg) { |title,b| b.div(text:"Inserted page: #{title}")}
  element(:question_page_success_msgclass) { |b| b.button(class:"close")}
  element(:get_pageid_element) { |title,b| b.th.a(title:"Move page: #{title}")}

  ##Matching Page Elements

  element(:correct_response_link) { |b| b.a(text:"Correct response")}
  element(:correct_response_content_editor) { |b| b.div(id:"id_answer_editor_0editable")}


  element(:wrong_response_link) { |b| b.a(text:"Wrong response")}
  element(:wrong_response_content_editor) { |b| b.div(id:"id_answer_editor_1editable")}
  element(:wrong_page_jump_select) { |b| b.select(id:"id_jumpto_1")}
  #This page
  #Next page
  #Previous page
  #End of lesson
  element(:wrong_page_score_txt) { |b| b.text_field(id:"id_score_1")}

  element(:matching_pair_1_link) { |b| b.a(text:"Matching pair 1")}
  element(:matching_pair_1_content_editor) { |b| b.div(id:"id_answer_editor_2editable")}
  element(:matching_pair_1_answer_txt) { |b| b.text_field(id:"id_response_editor_2")}

  element(:matching_pair_2_link) { |b| b.a(text:"Matching pair 2")}
  element(:matching_pair_2_content_editor) { |b| b.div(id:"id_answer_editor_3editable")}
  element(:matching_pair_2_answer_txt) { |b| b.text_field(id:"id_response_editor_3")}

  element(:matching_pair_3_link) { |b| b.a(text:"Matching pair 3")}
  element(:matching_pair_3_content_editor) { |b| b.div(id:"id_answer_editor_4editable")}
  element(:matching_pair_3_answer_txt) { |b| b.text_field(id:"id_response_editor_4")}

  element(:matching_pair_4_link) { |b| b.a(text:"Matching pair 4")}
  element(:matching_pair_4_content_editor) { |b| b.div(id:"id_answer_editor_5editable")}
  element(:matching_pair_4_answer_txt) { |b| b.text_field(id:"id_response_editor_5")}

  element(:matching_pair_5_link) { |b| b.a(text:"Matching pair 5")}
  element(:matching_pair_5_content_editor) { |b| b.div(id:"id_answer_editor_6editable")}
  element(:matching_pair_5_answer_txt) { |b| b.text_field(id:"id_response_editor_6")}

  ##Multichoice Page Elements
  element(:multiple_answer_option_chk) { |b| b.input(id:"id_qoption")}
  element(:answer1_link) { |b| b.a(text:"Answer 1")}
  element(:answer1_content_editor) { |b| b.div(id:"id_answer_editor_0editable")}
  element(:answer1_response_editor) { |b| b.div(id:"id_response_editor_0editable")}
  element(:answer1_page_jump_select) { |b| b.select(id:"id_jumpto_0")}
  element(:answer1_page_score_txt) { |b| b.text_field(id:"id_score_0")}


  element(:answer2_link) { |b| b.a(text:"Answer 2")}
  element(:answer2_content_editor) { |b| b.div(id:"id_answer_editor_1editable")}
  element(:answer2_response_editor) { |b| b.div(id:"id_response_editor_1editable")}
  element(:answer2_page_jump_select) { |b| b.select(id:"id_jumpto_1")}
  element(:answer2_page_score_txt) { |b| b.text_field(id:"id_score_1")}

  element(:answer3_link) { |b| b.a(text:"Answer 3")}
  element(:answer3_content_editor) { |b| b.div(id:"id_answer_editor_2editable")}
  element(:answer3_response_editor) { |b| b.div(id:"id_response_editor_2editable")}
  element(:answer3_page_jump_select) { |b| b.select(id:"id_jumpto_2")}
  element(:answer3_page_score_txt) { |b| b.text_field(id:"id_score_2")}

  element(:answer4_link) { |b| b.a(text:"Answer 4")}
  element(:answer4_content_editor) { |b| b.div(id:"id_answer_editor_3editable")}
  element(:answer4_response_editor) { |b| b.div(id:"id_response_editor_3editable")}
  element(:answer4_page_jump_select) { |b| b.select(id:"id_jumpto_3")}
  element(:answer4_page_score_txt) { |b| b.text_field(id:"id_score_3")}

  element(:answer5_link) { |b| b.a(text:"Answer 5")}
  element(:answer5_content_editor) { |b| b.div(id:"id_answer_editor_4editable")}
  element(:answer5_response_editor) { |b| b.div(id:"id_response_editor_4editable")}
  element(:answer5_page_jump_select) { |b| b.select(id:"id_jumpto_4")}
  element(:answer5_page_score_txt) { |b| b.text_field(id:"id_score_4")}

  #Numerical Question Page
  element(:answer1_content_txt) { |b| b.text_field(id:"id_answer_editor_0")}
  element(:answer2_content_txt) { |b| b.text_field(id:"id_answer_editor_1")}
  element(:answer3_content_txt) { |b| b.text_field(id:"id_answer_editor_2")}
  element(:answer4_content_txt) { |b| b.text_field(id:"id_answer_editor_3")}
  element(:answer5_content_txt) { |b| b.text_field(id:"id_answer_editor_4")}

  #Sort Answer
  element(:use_regular_expression_chk) { |b| b.input(id:"id_qoption")}


end