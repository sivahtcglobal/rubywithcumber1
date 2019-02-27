class CourseLessonPage < BasePage

  #expected_element :add_new_lesson_header,30

  #Moodle Create Course Page Elements
  element(:add_new_lesson_header) { |b| b.h2(text:"Adding a new Lesson")}
  element(:lesson_name_txt) { |b| b.text_field(id:"id_name")}
  element(:lesson_description_editor) { |b| b.div(id:"id_introeditoreditable")}
  element(:lesson_description_chkbox) { |b| b.input(id:"id_showdescription")}


  element(:appearance_link) { |b| b.a(text:"Appearance")}

  element(:availability_link) { |b| b.a(text:"Availability")}
  element(:available_enabled_chkbox) { |b| b.input(id:"id_available_enabled")}
  element(:available_deadline_chkbox) { |b| b.input(id:"id_deadline_enabled")}
    #Available Date Configuring
  element(:available_day_select) { |b| b.select_list(id:"id_available_day")}
  element(:available_month_select) { |b| b.select_list(id:"id_available_month")}
  element(:available_year_select) { |b| b.select_list(id:"id_available_year")}
  element(:available_hour_select) { |b| b.select_list(id:"id_available_hour")}
  element(:available_minute_select) { |b| b.select_list(id:"id_available_minute")}
   #Deadlin Date Configuring
  element(:deadline_day_select) { |b| b.select_list(id:"id_deadline_day")}
  element(:deadline_month_select) { |b| b.select_list(id:"id_deadline_month")}
  element(:deadline_year_select) { |b| b.select_list(id:"id_deadline_year")}
  element(:deadline_hour_select) { |b| b.select_list(id:"id_deadline_hour")}
  element(:deadline_minute_select) { |b| b.select_list(id:"id_deadline_minute")}

  element(:flow_control_link) { |b| b.a(text:"Flow control")}

  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:modgrade_type_select) { |b| b.select_list(id:"id_grade_modgrade_type")}
  #None  Scale  Point
  element(:modgrade_scale_select) { |b| b.select_list(id:"id_grade_modgrade_scale")}
  #Default competence scale
  #Separate and Connected ways of knowing

  element(:gradetopass_txt) { |b| b.text_field(id:"id_grade_modgrade_point")}
  element(:gradepass_txt) { |b| b.text_field(id:"id_gradepass")}
  element(:retakes_allowed_select) { |b| b.select_list(id:"id_retake")}

  element(:common_module_settings_link) { |b| b.a(text:"Common module settings")}
  element(:restrict_access_link) { |b| b.a(text:"Restrict access")}
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:lesson_tags_txt) { |b| b.text_field(placeholder:"Enter tags...")}

  element(:competencies_link) { |b| b.a(text:"Competencies")}


  #Submit Buttons

  element(:lesson_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:lesson_saveandreturn_btn_clk) { |b| b.lesson_saveandreturncourse_btn.click }
  element(:lesson_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:lesson_saveanddisplay_btn_clk) { |b| b.lesson_saveanddisplay_btn.click }


end
