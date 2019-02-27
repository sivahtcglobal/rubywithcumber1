class MediaEventsloginPage < BasePage

  page_url "https://intellify.instructure.com"
  element(:login_button) { |b| b.button(class:"Button Button--login") }
  element(:username){|b| b.text_field(id:"pseudonym_session_unique_id")}
  element(:password){|b| b.text_field(id:"pseudonym_session_password")}
end
