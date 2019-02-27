class EssentialsLoginPage < BasePage

  @essentialsURL = configatron.essentialsURL
  page_url @essentialsURL

  expected_element :login_button,30

  #Essentials Login Page Elements
  element(:login_button) { |b| b.button(text: "Login") }
  element(:intellify_login){ |b|b.text_field(id:"username")}
  element(:intellify_password){ |b|b.text_field(id:"password")}

end
