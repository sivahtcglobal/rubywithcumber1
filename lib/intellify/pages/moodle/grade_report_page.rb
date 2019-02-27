class GradeReportPage < BasePage

  #Moodle Grade Report Page Elements
  element (:single_view_link) { |b| b.img(css:"table#user-grades tr.heading th:nth-last-child(2) a img.smallicon")}
  element (:grades_menu_link) { |b| b.a(css:"div[id*='nav'] a[href*='grade/report']")}
  element(:override_chkbox) { |b| b.input(css:"tr:last-child td.c5 input[type = 'checkbox']")}
  element(:grade_txt) { |b| b.input(css:"tr:last-child td.c3 input[type = 'text']")}
  element(:grade_alert_msg) { |b| b.div(css:"div#page div.alert")}

  element(:essay_question_link) { |b| b.a(css:"a.essayungraded")}
  element(:student_response_txt) { |b| b.p(css:"div.fitem:nth-child(2) div.felement:nth-child(2) p")}

  element(:grade_save_btn) { |b| b.input(css:"div.reporttable div.submit:nth-child(4) input")}
  action(:grade_save_btn_clk) { |b| b.grade_save_btn.click }

  element(:grade_alert_continue_btn) { |b| b.button(css:"div#page div.continuebutton button")}
  action(:grade_alert_continue_btn_clk) { |b| b.grade_alert_continue_btn.click }

  element(:grade_continue_btn) { |b| b.button(css:"div#page div.continuebutton input[value='Continue']")}
  action(:grade_continue_btn_clk) { |b| b.grade_continue_btn.click }

end
