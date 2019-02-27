class ExternalToolConfigurationPage < BasePage

  #Moodle External Tool Configuration Page Elements
  element(:tool_name_txt) { |b| b.input(id:"id_lti_typename")}
  element(:tool_url_txt) { |b| b.input(id:"id_lti_toolurl")}
  element(:tool_description_txt) { |b| b.textarea(id:"id_lti_description")}
  element(:consumer_key_txt) { |b| b.input(id:"id_lti_resourcekey")}
  element(:shared_secret_link) { |b| b.link(text:"Click to enter text")}
  element(:shared_secret_txt) { |b| b.input(id:"id_lti_password")}

  element(:save_changes_btn) { |b| b.input(id:"id_submitbutton") }
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

end
