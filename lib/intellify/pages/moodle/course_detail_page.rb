class CourseDetailPage < BasePage

  #end tour pop-up
  element(:end_tour_button) { |b| b.button(css:"div.modal-footer button[data-role='end']")}

  #dropdown-2 Master Edit Dropdown
  element(:course_master_edit_dropdown) { |b| b.a(id:"dropdown-2")}

  #Dropdown to turn on edit

  element(:master_edit_dropdown) { |b| b.a(id:"action-menu-toggle-2")}

  #Turn editing on
  element(:course_turn_editing_link) { |b| b.a(text:"Turn editing on")}
  #Add an activity or resource
  element(:course_add_activity_link) { |b| b.a(text:"Add an activity or resource")}

  #Add Quiz Radio Button
  element(:course_add_quiz_rbtn) { |b| b.input(id:"item_quiz")}
  element(:course_add_assignment_rbtn) { |b| b.input(id:"item_assign")}
  element(:course_add_lesson_rbtn) { |b| b.input(id:"item_lesson")}

  element(:course_add_activity_button) { |b| b.input(value:"Add")}


  #Moodle Create Course Page Elements
  element(:course_heading_txt) { |coursename,b| b.h1(text:"#{coursename}")}
  element(:lesson_name_link) { |lessonname,b| b.span(text:"#{lessonname}")}
  element(:lesson_name_parent_link) { |lessonname,b| b.a(text:"#{lessonname}")}
  element(:quiz_name_parent_link) { |quizname,b| b.a(text:"#{quizname}")}

  #Lesson Link to get Lesson Id
  element(:lesson_Id_link) { |b| b.lesson_name_link.parent until parent.onclick == "" }

  #Assignment Link to get Lesson Id
  element(:assignment_link) { |assignName,b| b.span(text:"#{assignName}")}

  #Add Block comment
  element(:add_block_old_link) { |b| b.div(text:"Add a block")}

  element(:add_block_comment_old_link) { |b| b.a(text:"Comments" )}
  element(:add_block_comment_old_text) { |b| b.textarea(name:"content")}

  # Save comment
  element(:add_block_savecomment_old_link) { |b| b.a(text:"Save comment" )}

  #Course Participant Link
  element(:participants_link) { |b| b.div(text:"Participants")}

  #Course Participant Link for Old Moodle Build
  element(:participants_old_link) { |b| b.a(text:"Participants")}

  #Course Participant Student Name Link
  element(:participants_stud_link) { |studentname,b| b.a(text:/#{studentname}/)}

  #Course Participant Message Link
  element(:participants_msg_link) { |b| b.span(text:"Message")}

  #Message Textbox
  element(:msg_text) { |b| b.textarea(text:"")}

  #Send Message button
  element(:msg_send_btn) { |b| b.button(text:"Send")}

  #Send Message button for Old moodle build
  element(:msg_send_old_btn) { |b| b.input(type:"submit")}

  #Participant Notes Link
  element(:participants_notes_link) { |b| b.a(text:"Notes")}

  #Participant Add a Notes Link
  element(:participants_add_notes_link) { |b| b.a(text:"Add a new note")}

  #Participant Notes Text Area
  element(:participants_notes_txt) { |b| b.textarea(id:"id_content")}

  #Participant Notes Text Area
  element(:participants_notes_context_select) { |b| b.select(id:"id_publishstate")}
  #personal
  #course
  #site

  #Participant Notes Text Save Button
  element(:participants_notes_save_btn) { |b| b.input(type:"submit")}

  #Participant Notes Text Edit Link
  element(:participants_notes_edit_link) { |index,b| b.div(class:"notesgroup",index:index).div(class:"notelist").a(text:"Edit")}

end
