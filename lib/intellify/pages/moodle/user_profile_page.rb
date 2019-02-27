class UserProfilePage < BasePage

  expected_element :edit_profile_link,30

  element(:edit_profile_link) { |b| b.link(text:"Edit profile") }
  action(:edit_profile_link_click) { |b| b.edit_profile_link.click  }

end
