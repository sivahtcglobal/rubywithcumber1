class EnrollUserPage < BasePage

  expected_element :enrol_users_button,30

  #Enroll User Elements

  element(:enrol_users_button) { |b| b.form(id:"enrolusersbutton-1")}
  action(:enrol_users_button_clk) { |b| b.enrol_users_button.click }

  element(:role_select) { |b| b.select_list(id:"id_enrol_manual_assignable_roles")}

  element(:enrol_user_search) { |b| b.text_field(id:"enrolusersearch")}

  element(:search_button) { |b| b.input(id:"searchbtn")}
  action(:search_button_clk) { |b| b.search_button.click }

  element(:enrol_button) { |b| b.input(css:"div.user input[type=button]")}
  action(:enrol_button_clk) { |b| b.enrol_button.click }

  element(:finish_enrolling_users_button) { |b| b.input(css:"div.close-button input")}
  action(:finish_enrolling_users_button_clk) { |b| b.finish_enrolling_users_button.click }

  element(:unassigned_role_link) { |b| b.link(css:"table.userenrolment tr:nth-child(2) td:nth-child(3) a.unassignrolelink")}
  action(:unassigned_role_link_clk) { |b| b.unassigned_role_link.click }

  element(:assign_role_link) { |b| b.link(css:"table.userenrolment tr:nth-child(2) td:nth-child(3) a.assignrolelink")}
  action(:assign_role_link_clk) { |b| b.assign_role_link.click }

  element(:select_teacher_role_button) { |b| b.input(css:"input[value='Teacher'], input[value='Instructor']")}
  action(:select_teacher_role_button_clk) { |b| b.select_teacher_role_button.click }

  element(:select_student_role_button) { |b| b.input(css:"input[value='Student']")}
  action(:select_student_role_button_clk) { |b| b.select_student_role_button.click }

  element(:confirm_role_change_button) { |b| b.input(css:"div.confirmation-buttons input[value='Remove']")}
  action(:confirm_role_change_button_clk) { |b| b.confirm_role_change_button.click }

end
