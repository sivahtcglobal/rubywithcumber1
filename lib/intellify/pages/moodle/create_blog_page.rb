class CourseBlogPage < BasePage

  #Moodle Blog Page Elements
  element(:add_new_blog_entry_link) { |b| b.a(text:"Add a new entry")}

  element(:entry_title_txt) { |b| b.text_field(id:"id_subject")}
  element(:blog_entry_body_txt) { |b| b.div(id:"id_summary_editoreditable")}

  #Select Files
  element(:select_files_link) { |b| b.a(title:"Add...")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:choose_files_link) { |b| b.input(name:"repo_upload_file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}

  element(:publish_to_select) { |b| b.select_list(id:"id_publishstate")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span[role='listitem']:nth-child(2) span")}

  #Submit Buttons
  element(:blog_save_changes_btn) { |b| b.input(id:"id_submitbutton") }
  action(:blog_save_changes_btn_clk) { |b| b.blog_save_changes_btn.click }
  element(:blog_cancel_btn) { |b| b.input(id:"id_cancel") }
  action(:blog_cancel_btn_clk) { |b| b.blog_cancel_btn.click }

  element(:edit_link) { |b| b.a(text:"Edit")}

end
