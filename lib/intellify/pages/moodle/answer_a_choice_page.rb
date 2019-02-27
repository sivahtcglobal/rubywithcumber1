class AnswerAChoicePage < BasePage

  #Moodle Answer A Choice Page Elements
  element(:select_choice_chkbx) { |b| b.input(name:"answer[]")}

  element(:save_my_choice_btn) { |b| b.input(value:"Save my choice") }
  action(:save_my_choice_btn_clk) { |b| b.save_my_choice_btn.click }

  element(:success_msg_txt) { |b| b.div(css:"div.alert-success")}
  element(:view_choice_responses_link) { |b| b.a(css:".reportlink a")}

end
