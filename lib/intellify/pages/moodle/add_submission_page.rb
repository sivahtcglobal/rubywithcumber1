class AddSubmissionPage < BasePage

  #Add submission
  element(:add_submission) { |b| b.input(value:"Add submission")}
  element(:online_text_select){|b| b.div(id:"id_onlinetext_editoreditable")}
  element(:save_change_button) {|b| b.input(id:"id_submitbutton")}
  element(:cancel) {|b| b.input(id:"id_cancel")}
  element(:error_comments){|b| b.div(class:"notifytiny debuggingmessage")}
  element(:edit_submission) {|b| b.input(value:"Edit submission")}
  element(:continue_link) { |b| b.a(text:"Continue")}
end