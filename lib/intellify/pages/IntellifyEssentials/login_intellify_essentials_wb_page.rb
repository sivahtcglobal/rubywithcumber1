class IntellifyEssentialWBLoginPage < BasePage

  page_url configatron.essentialWBloginURL
  expected_element :login_button,30
  element(:login_button) { |b| b.button(value: "Login") }
  element(:intellify_login){ |b|b.text_field(name:"username")}
  element(:intellify_password){ |b|b.text_field(name:"user.password")}
  element(:sign_out) { |b| b.i(class: "icon icon-signout") }
  element(:image_intellify) { |b| b.image(:src, "img/logo.png")}
end