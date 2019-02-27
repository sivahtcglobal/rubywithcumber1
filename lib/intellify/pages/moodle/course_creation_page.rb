class CourseCreationPage < BasePage

  expected_element :course_fullname_txt,30

  #Moodle Create Course Page Elements
  element(:course_fullname_txt) { |b| b.text_field(id:"id_fullname")}
  element(:course_shortname_txt) { |b| b.text_field(id:"id_shortname")}


  element(:course_visibity_select) { |b| b.select_list(id:"id_visible")}
  #Hide
  #Show
  element(:course_catagory_select) { |b| b.select_list(id:"id_category")}
  element(:course_startdate_day_select) { |b| b.select_list(id:"id_startdate_day")}
  element(:course_startdate_month_select) { |b| b.select_list(id:"id_startdate_month")}
  element(:course_startdate_year_select) { |b| b.select_list(id:"id_startdate_year")}


  element(:course_enddate_chkbox) { |b| b.input(id:"id_enddate_enabled")}
  element(:course_enddate_day_select) { |b| b.select_list(id:"id_enddate_day")}
  element(:course_enddate_month_select) { |b| b.select_list(id:"id_enddate_month")}
  element(:course_enddate_year_select) { |b| b.select_list(id:"id_enddate_year")}

  element(:course_id_txt) { |b| b.text_field(id:"id_idnumber")}
  element(:course_description_editor) { |b| b.div(id:"id_summary_editoreditable")}

  element(:course_format_link) { |b| b.a(text:"Course format")}
  action(:course_format_link_clk) { |b| b.course_format_link.click }
  element(:course_layout_select) { |b| b.select_list(id:"id_coursedisplay")}

  element(:appearance_link) { |b| b.a(text:"Appearance")}
  element(:force_language_select) { |b| b.select_list(id:"id_lang")}
  element(:number_of_announcements_select) { |b| b.select_list(id:"id_newsitems")}
  element(:show_gradebook_select) { |b| b.select_list(id:"id_showgrades")}
  element(:show_activity_report_select) { |b| b.select_list(id:"id_showreports")}

  element(:course_completion_link) { |b| b.a(text:"Completion tracking")}
  element(:course_completion_select) { |b| b.select_list(id:"id_enablecompletion")}

  element(:groups_link) { |b| b.a(text:"Groups")}
  element(:group_mode_select) { |b| b.select_list(id:"id_groupmode")}
  element(:force_group_mode_select) { |b| b.select_list(id:"id_groupmodeforce")}
  element(:default_grouping_select) { |b| b.select_list(id:"id_defaultgroupingid")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span[role='listitem']:nth-child(2) span")}

  element(:course_format_select) { |b| b.select_list(id:"id_format")}
  # Single activity format
  # Social format
  # Topics format
  # Weekly format

  #Submit Buttons

  element(:course_saveandreturn_btn) { |b| b.input(id:"id_saveandreturn")}
  action(:course_saveandreturn_btn_clk) { |b| b.course_saveandreturn_btn.click }
  element(:course_saveanddisplay_btn) { |b| b.input(id:"id_saveanddisplay") }
  action(:course_saveanddisplay_btn_clk) { |b| b.course_saveanddisplay_btn.click }

  #Upload File Elements
  element(:select_files_link) { |b| b.a(title:"Add...")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}

end
