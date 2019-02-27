class BrowserListOfUsersPage < BasePage
  expected_element :add_new_user,30

  element(:add_new_user) { |b| b.button(text:"Add a new user") }
  element(:user_full_name) { |b| b.text_field(name:"realname")}
  element(:first_name_link) { |b| b.link(css:"tr.lastrow td:first-child a")}

  element(:add_filter_button) { |b| b.button(id: "id_addfilter") }
  action(:add_filter_button_click) { |b| b.add_filter_button.click }

  element(:remove_all_button) { |b| b.button(id: "id_removeall") }
  action(:remove_all_button_click) { |b| b.remove_all_button.click }

end
