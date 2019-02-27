class CourseGlossaryEntryPage < BasePage

  #Moodle Add Glossary Entry Page Elements
  element(:glossary_entry_concept_txt) { |b| b.text_field(id:"id_concept")}
  element(:glossary_entry_definition_txt) { |b| b.div(id:"id_definition_editoreditable")}

  #Keywords
  element(:keywords_txt_area) { |b| b.text_field(id:"id_aliases")}

  #Auto-linking
  element(:auto_linking_link) { |b| b.a(text:"Auto-linking")}
  element(:auto_linking_dynamic_link_chkbox) { |b| b.input(id:"id_usedynalink")}
  element(:auto_linking_case_sensitive_chkbox) { |b| b.input(id:"id_casesensitive")}
  element(:auto_linking_full_match_chkbox) { |b| b.input(id:"id_fullmatch")}

  #Submit Buttons
  element(:glossary_entry_cancel_btn) { |b| b.input(id:"id_cancel")}
  action(:glossary_entry_cancel_btn_clk) { |b| b.glossary_entry_cancel_btn.click }
  element(:glossary_entry_save_changes_btn) { |b| b.input(id:"id_submitbutton") }
  action(:glossary_entry_save_changes_btn_clk) { |b| b.glossary_entry_save_changes_btn.click }

end
