class CourseDatabasePage < BasePage

  #Adding a new Database General
  element(:database_name_txt) { |b| b.text_field(id:"id_name")}
  element(:database_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:show_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Entries
  element(:entries_link) { |b| b.a(text:"Entries")}
  element(:approval_select) { |b| b.select_list(id:"id_approval")}
  element(:manageapproved_select) { |b| b.select_list(id:"id_manageapproved")}
  element(:comments_select) { |b| b.select_list(id:"id_comments")}
  element(:requiredentries_select) { |b| b.select_list(id:"id_requiredentries")}
  element(:requiredentriestoview_select) { |b| b.select_list(id:"id_requiredentriestoview")}
  element(:maxentries_select) { |b| b.select_list(id:"id_maxentries")}

  #Availability
  element(:availability_link) { |b| b.a(text:"Availability")}

  #Grade
  element(:grade_link) { |b| b.a(text:"Grade")}
  element(:gradecat_select) { |b| b.select_list(id:"id_gradecat")}

  #Ratings
  element(:ratings_link) { |b| b.a(text:"Ratings")}
  element(:assessed_select) { |b| b.select_list(id:"id_assessed")}
  element(:scale_modgrade_type_select) { |b| b.select_list(id:"id_scale_modgrade_type")}
  element(:scale_modgrade_point_txt) { |b| b.text_field(id:"id_scale_modgrade_point")}
  element(:ratingtime_chkbox) { |b| b.input(id:"id_ratingtime")}

  #Common module settings
  element(:common_module_settings_link) { |b| b.a(text:"Common module settings")}
  element(:visible_select) { |b| b.select_list(id:"id_visible")}
  element(:cmidnumber_txt) { |b| b.text_field(id:"id_cmidnumber")}
  element(:id_groupmode_select) { |b| b.select_list(id:"id_groupmode")}
  element(:id_groupingid_select) { |b| b.select_list(id:"id_groupingid")}

  #Restrict access
  element(:restrict_access_link) { |b| b.a(text:"Restrict access")}

  #Activity completion
  element(:activity_completion_link) { |b| b.a(text:"Activity completion")}
  element(:completion_select) { |b| b.select_list(id:"id_completion")}
  element(:completion_view_chkbox) { |b| b.input(id:"id_completionview")}
  element(:completion_use_grade_chkbox) { |b| b.input(id:"id_completionusegrade")}
  element(:completion_expected_enabled_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  element(:activity_completion_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:activity_completion_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:activity_completion_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span.tag:nth-child(2) span")}

  #Competencies
  element(:competencies_link) { |b| b.a(text:"Competencies")}
  element(:competency_rule_select) { |b| b.select_list(id:"id_competency_rule")}

  #Submit Buttons
  element(:database_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:database_saveandreturncourse_btn_clk) { |b| b.database_saveandreturncourse_btn.click }
  element(:database_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:database_saveanddisplay_btn_clk) { |b| b.database_saveanddisplay_btn.click }

  #Fields
  element(:fields_link) { |b| b.a(css:"a[title='Fields']")}
  element(:predefine_fields_link) { |b| b.a(text:"choose a predefined set")}
  element(:create_new_field_select) { |b| b.select_list(name:"newtype")} #Text input
  element(:text_field_name_txt) { |b| b.text_field(id:"name")} #Name
  element(:text_field_description_txt) { |b| b.text_field(id:"description")} #Description
  element(:required_chkbox) { |b| b.input(id:"required")}
  element(:add_btn) { |b| b.input(css:"input[type='submit']:first-child") }
  element(:options_list) { |b| b.textarea(id:"param1") }
  element(:save_btn) { |b| b.input(value:"Save") }
  element(:edit_btn) { |b| b.img(css:"tr:last-child img[title='Edit']") }

  #Templates
  element(:templates_link) { |b| b.a(text:"Templates")}
  element(:template_header_txt) { |b| b.div(id:"listtemplateheadereditable")}
  element(:template_repeated_entry_txt) { |b| b.div(id:"templateeditable")}
  element(:template_footer_txt) { |b| b.div(id:"listtemplatefootereditable")}
  element(:templates_add_btn) { |b| b.input(value:"Save template") }
  element(:success_msg_txt) { |b| b.div(css:"div.alert-success")}

  #Add entry
  element(:add_entry_link) { |b| b.a(text:"Add entry")}
  element(:new_entry_name_txt) { |b| b.text_field(type:"text")} #Entry1
  element(:color_chkbox) { |b| b.input(type:"checkbox")}
  element(:entry_saveandview_btn) { |b| b.input(type:"submit") }

  #View list
  element(:view_list_link) { |b| b.a(text:"View list")}

  #View single
  element(:view_single_link) { |b| b.a(text:"View single")}

  #Search
  element(:search_link) { |b| b.a(text:"Search")}

  #Export
  element(:export_link) { |b| b.a(text:"Export")}

  #Presets
  element(:presets_link) { |b| b.a(text:"Presets")}

  element (:course_item_breadcrumb_databasename) { |b| b.a(css:"div.breadcrumb-nav li:nth-last-child(2) a")}

  #Edit
  element(:database_edit_dropdown) { |b| b.a(css:"#page-content .dropdown-toggle")}
  element(:database_edit_link) { |b| b.a(text:"Edit settings")}
end
