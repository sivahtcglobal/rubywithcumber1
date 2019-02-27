class CourseGroupPage < BasePage

  #Moodle Create Group Page Elements
  element(:group_name_txt) { |b| b.text_field(id:"id_name")}
  element(:group_id_number_txt) { |b| b.text_field(id:"id_idnumber")}
  element(:group_description_txt) { |b| b.div(id:"id_description_editoreditable")}
  element(:enrolment_key_link) { |b| b.em(text:"Click to enter text")}
  element(:edit_password_link) { |b| b.img(title:" Edit password")}
  element(:enrolment_key_txt) { |b| b.text_field(id:"id_enrolmentkey")}

  element(:hide_picture_select) { |b| b.select_list(id:"id_hidepicture")}
  element(:choose_file_btn) { |b| b.input(value:"Choose a file...")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:choose_files_link) { |b| b.input(name:"repo_upload_file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}
  element(:added_group) { |b| b.select(id:"groups")}
  element(:add_remove_user_btn) { |b| b.input(value:"Add/remove users")}
  element(:potential_members_select) { |b| b.option(css:"select[id='addselect'] optgroup:nth-child(1) option:nth-child(1)")}
  element(:add_user_btn) { |b| b.input(css:"input[id='add']")}
  element(:group_members_select) { |b| b.option(css:"select[id='removeselect'] optgroup:nth-child(1) option:nth-child(1)")}
  element(:remove_btn) { |b| b.input(css:"input[id='remove']")}

  #Buttons
  element(:save_changes_btn) { |b| b.input(id:"id_submitbutton")}
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

end
