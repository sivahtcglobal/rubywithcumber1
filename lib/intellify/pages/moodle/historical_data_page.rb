class HistoricalDataPage < BasePage

  #Moodle Uninstall Plugin Elements
  element (:uninstall_plugin_link) { |b| b.a(css:"tr.name-logstore_intellify td.uninstall a")}
  element (:confirm_uninstall_continue_btn) { |b| b.button(css:"div.buttons button.btn-primary, input[value='Continue']")}
  element (:confirm_remove_plugin_folder_btn) { |b| b.button(css:"div.buttons button.btn-primary, input[value='Continue']")}
  element (:upgrade_moodle_database_btn) { |b| b.button(css:"div.continuebutton button, input[value='Upgrade Moodle database now']")}

  #Moodle Re-install Plugin Elements
  element(:select_files_link) { |b| b.input(value:"Choose a file...")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:choose_files_link) { |b| b.input(name:"repo_upload_file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}
  element(:install_plugin_btn) { |b| b.input(value:"Install plugin from the ZIP file")}
  element(:continue_btn) { |b| b.button(css:"div.continue button, input[value='Continue']")}
  element(:success_msg) { |b| b.div(css:"div.alert-success")}
  element(:upgrade_to_new_version_continue_btn) { |b| b.button(css:"div.continuebutton button, input[value='Continue']")}

  #Moodle Configure Plugin Elements
  element(:host_name_txt) { |b| b.input(id:"id_s_logstore_intellify_host")}
  element(:api_key_txt) { |b| b.input(id:"id_s_logstore_intellify_lib_api_key")}
  element(:sensor_id_txt) { |b| b.input(id:"id_s_logstore_intellify_sensor_id")}
  element(:debugging_chkbox) { |b| b.input(id:"id_s_logstore_intellify_debug_enabled")}
  element(:batch_size_txt) { |b| b.input(id:"id_s_logstore_intellify_batch_size")}

  #Save Changes Button
  element(:save_changes_btn) { |b| b.input(value:"Save changes")}
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

  #Moodle Enable Plugin Elements
  element(:settings_gear_link) { |b| b.a(css:"span#plugin_type_cell_logstore a")}
  action(:settings_gear_link_clk) { |b| b.settings_gear_link.click }
  element(:eye_symbol_disable) { |b| b.a(css:"#logstoreplugins tr:nth-child(3) td.c3 a")}
  element(:eye_symbol_enable) { |b| b.img(css:"#logstoreplugins tr:nth-child(2) td.c3 a img")}

end
