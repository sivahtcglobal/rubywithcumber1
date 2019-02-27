class IntellistoreDataCollectionSettingsPage < BasePage

  #Moodle IntelliStore Data Collection Settings Page Elements
  element(:intellify_host_txt) { |b| b.text_field(id:"id_s_logstore_intellify_host")}
  element(:api_key_txt) { |b| b.text_field(id:"id_s_logstore_intellify_lib_api_key")}
  element(:sensor_id_txt) { |b| b.text_field(id:"id_s_logstore_intellify_sensor_id")}
  element(:debugging_chkbox) { |b| b.input(id:"id_s_logstore_intellify_debug_enabled")}
  element(:course_list_select) { |b| b.select_list(id:"id_s_logstore_intellify_course_list")}
  element(:category_list_select) { |b| b.select_list(id:"id_s_logstore_intellify_categories_list")}
  element(:tag_list_select) { |b| b.select_list(id:"id_s_logstore_intellify_tag_list")}

  element (:save_changes_btn) { |b| b.button(text:"Save changes")}
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

  element (:success_message) { |b| b.div(css:"div.alert-success")}

end
