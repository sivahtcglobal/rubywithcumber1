class CreateAndUpdateUserPage < BasePage

  @addUserURL = configatron.moodleURL+'/user/editadvanced.php?id=-1'
  page_url @addUserURL

  expected_element :user_name,30

  #Moodle Create User Elements
  element(:user_name) { |b| b.text_field(name:"username")}
  element(:password_link) { |b| b.link(text:"Click to enter text")}
  element(:password) { |b| b.text_field(name:"newpassword")}
  element(:first_name) { |b| b.text_field(name:"firstname")}
  element(:last_name) { |b| b.text_field(name:"lastname")}
  element(:email) { |b| b.text_field(name:"email")}
  element(:city) { |b| b.text_field(name:"city")}
  element(:country) { |b| b.select_list(id:"id_country")}
  element(:timezone) { |b| b.select_list(id:"id_timezone")}
  element(:description) { |b| b.div(id:"id_description_editoreditable")}
  element(:optional) { |b| b.link(text:"Optional")}
  element(:institution) { |b| b.text_field(name:"institution")}
  element(:department) { |b| b.text_field(name:"department")}
  element(:phone) { |b| b.text_field(name:"phone1")}
  element(:mobile_phone) { |b| b.text_field(name:"phone2")}
  element(:address) { |b| b.text_field(name:"address")}

  element(:submit_profile_button) { |b| b.button(id: "id_submitbutton") }
  action(:submit_profile_button_click) { |b| b.submit_profile_button.click }

end
