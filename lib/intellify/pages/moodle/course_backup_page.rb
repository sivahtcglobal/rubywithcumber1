class CourseBackupPage < BasePage

  #Moodle Course Backup Page Elements
  element(:backup_link) { |b| b.a(text:"Backup")}
  element(:course_logs_chkbx) { |b| b.input(id:"id_setting_root_logs")}
  element(:grade_history_chkbx) { |b| b.input(id:"id_setting_root_grade_histories")}

  element(:next_btn) { |b| b.input(id:"id_submitbutton") }
  action(:next_btn_clk) { |b| b.next_btn.click }

  element(:perform_backup_btn) { |b| b.input(id:"id_submitbutton") }
  action(:perform_backup_btn_clk) { |b| b.perform_backup_btn.click }

  element(:backup_success_msg) { |b| b.div(css:"div.alert-success")}

  element(:continue_btn) { |b| b.button(text:"Continue")}
  action(:continue_btn_clk) { |b| b.continue_btn.click }

  element(:schema_settings) { |b| b.input(css:"div.section_level:last-child div.include_setting input:last-child")}
  element(:confirmation_review) { |b| b.div(css:"div.section_level:last-child div.include_setting")}

end
