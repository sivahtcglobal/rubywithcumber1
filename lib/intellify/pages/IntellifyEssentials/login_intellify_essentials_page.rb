class IntellifyEssentialLoginPage < BasePage

  page_url configatron.essentialloginURL
  expected_element :login_button,30

  element(:login_button) { |b| b.button(text: "Login") }
  element(:intellify_login){ |b|b.text_field(id:"username")}
  element(:intellify_password){ |b|b.text_field(id:"password")}

end