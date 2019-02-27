class GradeJournalEntryPage < BasePage

  #Moodle Grade Journal Entry Page Elements
  element (:view_journal_entry_link) { |b| b.a(css:"section#region-main a")}
  element (:select_grade) { |b| b.select(css:"select.select")}
  element (:alert_success_message) { |b| b.div(css:"div.alert-success")}

  element (:save_my_feedback_btn) { |b| b.input(css:"input[value='Save all my feedback']")}
  action(:save_my_feedback_btn_clk) { |b| b.save_my_feedback_btn.click }

end
