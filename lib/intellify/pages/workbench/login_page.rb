class IntellifyLoginPage < BasePage

  @loginPage = configatron.workbenchURL+'/wb/index.html#/login'
  page_url @loginPage

  expected_element :login_button,30

  #Login page Elements
  element(:login_button) { |b| b.button(value: "Login") }
  element(:intellify_login){ |b|b.text_field(name:"username")}
  element(:intellify_password){ |b|b.text_field(name:"user.password")}

  #Login Alert
  element(:login_alert_errorMsg) { |b| b.div(:id, "alerts") }

end
