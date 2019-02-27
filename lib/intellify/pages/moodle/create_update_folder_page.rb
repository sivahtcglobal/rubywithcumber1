class CourseFolderPage < BasePage

  #Moodle Create Folder Page Elements
  element(:folder_name_txt) { |b| b.text_field(id:"id_name")}
  element(:folder_description_txt) { |b| b.div(id:"id_introeditoreditable")}
  element(:display_description_chkbox) { |b| b.input(id:"id_showdescription")}

  #Select Files
  element(:select_files_link) { |b| b.a(title:"Add...")}
  element(:server_files_link) { |b| b.span(text:"Server files")}
  element(:select_course_link) { |b| b.a(css:"a.fp-file:nth-child(1)")}
  element(:select_a_file) { |b| b.div(css:"a.fp-file:nth-child(1)  div.fp-reficons2")}
  element(:select_this_file_btn) { |b| b.button(text:"Select this file")}

  #Display Folder Contents
  element(:display_folder_content_select) { |b| b.select_list(id:"id_display")}
  element(:show_subfolders_expanded_chkbox) { |b| b.input(id:"id_showexpanded")}
  element(:show_download_folder_chkbox) { |b| b.input(id:"id_showdownloadfolder")}

  #Common Module Settings
  element(:common_module_settings_link) { |b| b.a(text:"Common module settings")}
  element(:common_module_visible_select) { |b| b.select_list(id:"id_visible")}
  element(:common_module_id_number_txt) { |b| b.text_field(id:"id_cmidnumber")}

  #Restrict Access
  element(:restrict_access_link) { |b| b.a(text:"Restrict access")}
  element(:restrict_access_add_restriction_btn) { |b| b.button(text:"Add restriction...")}
  action(:restrict_access_add_restriction_btn_clk) { |b| b.restrict_access_add_restriction_btn.click }
  element(:restrict_access_activity_completion_btn) { |b| b.button(text:"Activity completion")}
  action(:restrict_access_activity_completion_btn_clk) { |b| b.restrict_access_activity_completion_btn.click }
  element(:restrict_access_date_btn) { |b| b.button(text:"Date")}
  action(:restrict_access_date_btn_clk) { |b| b.restrict_access_date_btn.click }
  element(:restrict_access_grade_btn) { |b| b.button(text:"Grade")}
  action(:restrict_access_grade_btn_clk) { |b| b.restrict_access_grade_btn.click }
  element(:restrict_access_user_profile_btn) { |b| b.button(text:"User profile")}
  action(:restrict_access_user_profile_btn_clk) { |b| b.restrict_access_user_profile_btn.click }
  element(:restrict_access_restriction_set_btn) { |b| b.button(text:"Restriction set")}
  action(:restrict_access_restriction_set_btn_clk) { |b| b.restrict_access_restriction_set_btn.click }
  element(:restrict_access_cancel_btn) { |b| b.button(text:"Cancel")}
  action(:rrestrict_access_cancel_btn_clk) { |b| b.restrict_access_cancel_btn.click }

  #Activity Completion
  element(:activity_completion_link) { |b| b.a(text:"Activity completion")}
  element(:activity_completion_tracking_select) { |b| b.select_list(id:"id_completion")}
  element(:activity_completion_view_chkbox) { |b| b.input(id:"id_completionview")}
  element(:activity_completion_expected_chkbox) { |b| b.input(id:"id_completionexpected_enabled")}
  element(:activity_completion_day_select) { |b| b.select_list(id:"id_completionexpected_day")}
  element(:activity_completion_month_select) { |b| b.select_list(id:"id_completionexpected_month")}
  element(:activity_completion_year_select) { |b| b.select_list(id:"id_completionexpected_year")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span[role='listitem']:nth-child(2) span")}

  #Competencies
  element(:competencies_link) { |b| b.a(text:"Competencies")}
  element(:search_competencies) { |b| b.span(css:"fieldset#id_competenciessection div.fitem span.form-autocomplete-downarrow")}
  element(:select_first_competency) { |b| b.li(css:"ul.form-autocomplete-suggestions li:nth-child(1)")}
  element(:select_second_competency) { |b| b.li(css:"fieldset#id_competenciessection ul.form-autocomplete-suggestions li:nth-child(2)")}
  element(:delete_competency) { |b| b.span(css:"fieldset#id_competenciessection span.tag:nth-child(2) span")}

  #Submit Buttons
  element(:folder_cancel_btn) { |b| b.input(id:"id_cancel")}
  action(:folder_cancel_btn_clk) { |b| b.folder_cancel_btn.click }
  element(:folder_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:folder_saveandreturncourse_btn_clk) { |b| b.folder_saveandreturncourse_btn.click }
  element(:folder_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:folder_saveanddisplay_btn_clk) { |b| b.folder_saveanddisplay_btn.click }

end
