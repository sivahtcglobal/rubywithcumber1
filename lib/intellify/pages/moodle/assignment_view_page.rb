class AssignmentViewPage < BasePage

  element(:assignment_edit_dropdown) { |b| b.a(css:"#page-content .dropdown-toggle")}
  element(:assignment_edit_link) { |b| b.a(text:"Edit settings")}
  element(:assignment_all_sub_link) { |b| b.div(class:"submissionlinks").a(text:"View all submissions")}
  element(:assignment_grade_btn) { |b| b.a(text:"Grade")}

  element(:assignment_comment_link) { |b| b.a(class:"comment-link").span(id:/.*comment-link-text-.*/)}
  element(:assignment_content_txt) { |b| b.textarea(name:"content")}
  element(:assignment_save_comment_link) { |b| b.div(class:"fd").a(text:"Save comment")}
  element(:expand_comment_link) { |b| b.img(css:"a.comment-link img[src *='collapsed']")}
  element(:delete_comment_link) { |b| b.a(css:"div.comment-delete a")}


  #Grade Feedback Page
  element(:change_user_txt) { |b| b.input(css:"input[id*='form_autocomplete_input']")}
  element(:next_user_link) { |b| b.a(css:"a[data-action='next-user']")}
  element(:assignment_grade_txt) { |b| b.text_field(id:"id_grade")}
  element(:assignment_comment_editor) { |b| b.div(id:"id_assignfeedbackcomments_editoreditable")}
  element(:allow_another_attempt_select) { |b| b.select_list(id:"id_addattempt")}
  element(:assignment_graded_btn) { |b| b.button(text:"Save changes")}

  element(:saved_successful_msg) { |b| b.div(text:"Changes saved")}
  element(:confirm_ok_btn) { |b| b.input(value:"Ok")}

  element(:assignment_name_heading) { |name,b| b.h2(text:"#{name}")}
  element(:assignment_add_submission_btn) { |b| b.button(type:"submit")}
  element(:overwrite_btn) { |b| b.button(text:"Overwrite")}
  element(:assignment_onlinetext_editor) { |b| b.div(id:"id_onlinetext_editoreditable")}
  element(:assignment_submission_submit_btn) { |b| b.input(id:"id_submitbutton")}
  element(:submit_assignment_btn) { |b| b.button(text:"Submit assignment")}
  element(:submission_statement_chkbx) { |b| b.input(id:"id_submissionstatement")}

  element(:assignment_submission_status_msg) { |b| b.td(text:"Submitted for grading")}

  # element(:duplicate_submission_btn) { |b| b.button(text:"Add a new attempt based on previous submission")}
  element(:duplicate_submission_btn) { |b| b.button(text://)}
  element (:breadcrumb_edit_submission) { |b| b.li(css:"div.breadcrumb-nav li:last-child")}

  element(:select_files_link) { |b| b.a(title:"Add...")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:choose_files_link) { |b| b.input(name:"repo_upload_file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}
  element(:tag_clk){|b| b.fieldset(id:"id_tagshdr").a(text:"Tags")}
  element(:tag_value){|b| b.fieldset(id:"id_tagshdr").text_field(type:"text")}
  element(:save_display){|b|b.div(class:"felement fgroup").input(id:"id_saveanddisplay")}
  element(:tag_remove){|tag,b| b.fieldset(id:"id_tagshdr").span(text:tag)}

  #Email Error Continue Link
  element(:error_continue_link) { |b| b.a(text:"Continue")}
end
