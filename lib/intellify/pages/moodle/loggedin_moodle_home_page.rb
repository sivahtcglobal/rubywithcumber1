class MoodleHomePage < BasePage

  #expected_element :profile_dropdown,30

  element(:profile_dropdown) { |b| b.a(css: ".usermenu .moodle-actionmenu [id *= 'action-menu-toggle']") }
  element(:moodle_logout) { |b| b.span(id: "actionmenuaction-6") }
  action(:profile_dropdown_click) { |b| b.profile_dropdown.click  }
  action(:moodle_logout_click) { |b| b.moodle_logout.click  }

  #Site Admin Text
  element(:automation_site_admin) { |b| b.span(text: "Automation SiteAdmin") }
  element(:automation_site_Teacher) { |b| b.span(css: "span.usertext") }
  element(:automation_site_Student) { |b| b.span(css: "span.usertext") }

  #Policy Accept Button
  element(:policy_accept_btn) { |b| b.button(css:"div.singlebutton:nth-child(1) button")}

  #Moodle Old Messages Link
  element(:message_old_link) { |b| b.span(text:"Messages")}

  #Moodle Old Messages View Link
  element(:message_old_view_link) { |b| b.strong(text:/iname_/)}


  #Message Img at the top right
  element(:message_icon_img) { |b| b.img(title:/Toggle messages menu/)}

  #Message Link from the dropdown
  element(:message_link) { |b| b.h3(text:/iname_/)}

  #Email Error Continue Link
  element(:error_continue_link) { |b| b.a(text:"Continue")}




end
