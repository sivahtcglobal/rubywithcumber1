class CourseRestorePage < BasePage

  #Moodle Course Restore Page Elements
  element(:restore_link) { |b| b.a(css:"tr.lastrow td:last-child a")}

  element(:continue_btn) { |b| b.button(text:"Continue")}
  action(:continue_btn_clk) { |b| b.continue_btn.click }

  element(:restore_as_new_course_btn) { |b| b.input(value:"Continue")}
  action(:restore_as_new_course_btn_clk) { |b| b.restore_as_new_course_btn.click }

  element(:category_search_txt) { |b| b.input(css:"input[name='catsearch']")}

  element(:search_btn) { |b| b.input(css:"input[value='Search']")}
  action(:search_btn_clk) { |b| b.search_btn.click }

  element(:select_category_radio) { |b| b.input(css:"div.detail-pair:nth-child(1) tr.lastrow td input")}

  element(:select_category_continue_btn) { |b| b.input(value:"Continue")}
  action(:select_category_continue_btn_clk) { |b| b.select_category_continue_btn.click }

  element(:next_btn) { |b| b.input(id:"id_submitbutton") }
  action(:next_btn_clk) { |b| b.next_btn.click }

  element(:restore_btn) { |b| b.input(id:"id_submitbutton") }
  element(:include_competencies_chkbx) { |b| b.input(id:"id_setting_root_competencies")}
  element(:confirm_backup_details) { |b| b.div(css:"div.backup-sub-section:last-child div.detail-pair:last-child")}
  element(:schema) { |b| b.input(css:"div.section_level:last-child div.include_setting input:last-child")}
  element(:review) { |b| b.div(css:"div.section_level:last-child div.include_setting")}

  element(:new_course_fullname_txt) { |b| b.input(css:"input#id_setting_course_course_fullname")}
  element(:new_course_shortname_txt) { |b| b.input(css:"input#id_setting_course_course_shortname")}

  element(:perform_restore_btn) { |b| b.input(id:"id_submitbutton") }
  action(:perform_restore_btn_clk) { |b| b.perform_restore_btn.click }

  element(:restore_success_msg) { |b| b.div(css:"div.alert-success")}

end
