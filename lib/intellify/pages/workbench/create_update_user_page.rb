class WorkbenchUser< BasePage

  element(:manage_user_title){|b| b.legend(text:"Manage User")}

  #User page
  element(:user_firstname_txt){|b| b.text_field(name:"firstName")}
  element(:user_lastname_txt){|b| b.text_field(name:"lastName")}
  element(:user_username_txt){|b| b.text_field(name:"username")}
  element(:user_password_txt){|b| b.text_field(name:"password")}
  element(:user_city_txt){|b| b.text_field(name:"city")}
  element(:user_country_txt){|b| b.text_field(name:"country")}
  element(:user_email_txt){|b| b.text_field(name:"eMail")}
  element(:runtimeWBUser_uuid){|b| b.form(name:"userForm").text_field(name:"uuid").value}

  element(:user_role_select){|role,b| b.option(text:"#{role}")}
  # Organization Analyst/Designer
  # Edu Department Admin
  # Edu Institution Admin
  # Essentials Owner
  # Essentials Admin
  # Essentials User
  # Institution EDU Instructor
  # Institution Learner
  # EDU Instructor
  # Edu Learner
  # Product Admin
  # LIaaS Analyst/Designer
  # Institution Student
  # Student
  # LIaaS Admin
  # LIaaS Technical Admin
  # EDU Teaching Assistant
  # Anonymous User

  element(:user_update_btn){|b| b.form(name:"userForm").button(text:"Update")}

  element(:select_role){|b| b.select(name:"roles")}

  #Edit
  element(:edit_btn){|b| b.div(css:"div:nth-child(9) > div > div.span4 > div.btn.btn-default.ng-pristine.ng-valid")}

  #Delete
  element(:delete_usr_btn){|b| b.div(css:"div:nth-child(9) > div > div.span4 > div:nth-child(2)")}

  #Cancel
  element(:cancel_usr_btn){|b| b.div(css:"div:nth-child(9) > div > div.span4 > div:nth-child(3)")}

  #User Creation Alert Message
  element(:userCreation_alert_errorMsg) { |b| b.div(:id, "alerts") }
end
