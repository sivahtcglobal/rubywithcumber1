class CourseJournalEntryPage < BasePage

  #Moodle Create Journal Entry Page Elements
  element(:start_my_journal_entry_btn) { |b| b.button(css:"button[type='submit']")}
  element(:start_my_journal_entry_button) { |b| b.input(css:"input[value='Start or edit my journal entry']")}
  element(:journal_entry_txt) { |b| b.div(id:"id_text_editoreditable")}
  element (:journal_item_breadcrumb) { |b| b.a(css:"div.breadcrumb-nav li:nth-last-child(2) a")}

  #Submit Buttons
  element(:journal_entry_cancel_btn) { |b| b.input(id:"id_cancel")}
  action(:journal_entry_cancel_btn_clk) { |b| b.journal_entry_cancel_btn.click }
  element(:journal_entry_save_changes_btn) { |b| b.input(id:"id_submitbutton") }
  action(:journal_entry_save_changes_btn_clk) { |b| b.journal_entry_save_changes_btn.click }

end
