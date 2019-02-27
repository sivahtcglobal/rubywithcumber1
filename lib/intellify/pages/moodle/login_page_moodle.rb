class MoodleLoginPage < BasePage

  @moodleURL = configatron.moodleURL
  page_url @moodleURL

  #expected_element :login_link,30

  #Moodle Login Elements
  element(:login_link) { |b| b.link(text:"Log in")}
  element(:login_button) { |b| b.button(id: "loginbtn") }
  element(:moodle_login){ |b|b.text_field(name:"username")}
  element(:moodle_password){ |b|b.text_field(name:"password")}

end
