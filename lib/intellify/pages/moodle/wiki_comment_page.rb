class WikiCommentPage < BasePage

  #Moodle Wiki Comment Page Elements
  element(:comments_tab) { |b| b.a(text:"Comments")}
  element(:add_comment_link) { |b| b.a(text:"Add comment")}
  element(:wiki_page_comment_txt) { |b| b.div(id:"id_entrycomment_editoreditable")}
  element(:added_comment_txt) { |b| b.p(css:"td.lastcol p")}
  element(:delete_comment_link) { |b| b.a(css:"tr.lastrow td.lastcol a:last-child")}
  element(:delete_confirm_btn) { |b| b.input(css:"form.wiki_deletecomment_yes input")}
  element(:alert_message) { |b| b.div(css:"div.alert-info")}

  #Submit Buttons
  element(:save_changes_btn) { |b| b.input(id:"id_submitbutton") }
  action(:save_changes_btn_clk) { |b| b.save_changes_btn.click }

end
