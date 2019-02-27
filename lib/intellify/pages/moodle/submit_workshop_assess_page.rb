class CourseWorkshopAssessPage < BasePage

  #Grading phase
  element(:allocate_submissions_link) { |b| b.a(css:"ul.tasks a[href*='workshop/allocation']")}
  element(:add_reviewer_select) { |b| b.select_list(css:"tr.lastrow td.lastcol select.singleselect")}
  element(:switch_to_the_next_phase_link) { |b| b.a(text:"Switch to the next phase")}
  element(:assessment_switch_to_the_next_phase_image) { |b| b.img(css:"th:nth-child(3) a img[title='Switch phase']")}
  element(:grading_switch_to_the_next_phase_image) { |b| b.img(css:"th:nth-child(4) a img[title='Switch phase']")}
  element(:closed_switch_to_the_next_phase_image) { |b| b.img(css:"th:nth-child(5) a img[title='Switch phase']")}
  element(:continue_assessment_phase_btn) { |b| b.button(type:"submit") }
  action(:continue_assessment_phase_btn_clk) { |b| b.continue_assessment_phase_btn.click }

  element(:continue_assessment_phase_button) { |b| b.input(value:"Continue") }
  action(:continue_assessment_phase_button_clk) { |b| b.continue_assessment_phase_button.click }

  element(:assess_btn) { |b| b.button(text:"Assess")}
  element(:re_assess_btn) { |b| b.button(text:"Re-assess")}
  element(:aspect1_select) { |b| b.select_list(id:"id_grade__idx_0")}
  element(:comment_aspect1_txt) { |b| b.text_field(id:"id_peercomment__idx_0")}
  element(:overall_feedback_txt) { |b| b.div(id:"id_feedbackauthor_editoreditable")}
  element(:saveandclose_btn) { |b| b.input(id:"id_saveandclose") }
  #Switch to the next phase and Continue
  element(:grading_evaluation_method_select) { |b| b.select_list(css:"select[name='eval']")}
  element(:comparison_of_assessments_select) { |b| b.select_list(id:"id_comparison")}
  element(:recalculate_grades_btn) { |b| b.input(id:"id_submit") }
  #Switch to the next phase and Continue
  element(:closed_txt) { |b| b.h3(css:"section#region-main h3")}
  element(:add_attachment_btn) { |b| b.a(title:"Add...")}
  element(:assess_yourself_txt) { |b| b.div(css:".active .title")}
end
