class CourseWorkshopSubmissionPage < BasePage

  #Submission phase
  element(:submit_your_work_link) { |b| b.a(text:"Submit your work")}
  element(:start_preparing_your_submission_btn) { |b| b.button(text:"Start preparing your submission")}
  element(:title_name_txt) { |b| b.text_field(id:"id_title")}
  element(:submission_content_txt) { |b| b.div(id:"id_content_editoreditable")}
  element(:add_attachment_btn) { |b| b.a(title:"Add...")}
  element(:download_all_btn) { |b| b.a(title:"Download all")}
  element(:submission_save_btn) { |b| b.input(id:"id_submitbutton") }
  action(:submission_save_btn_clk) { |b| b.submission_save_btn.click }

  element(:submission_title) { |b| b.h3(css:"h3.title")}

  element(:edit_submission_btn) { |b| b.button(text:"Edit submission")}

  #Upload File Elements
  element(:select_files_link) { |b| b.a(title:"Add...")}
  element(:upload_files_link) { |b| b.span(text:"Upload a file")}
  element(:upload_files_btn) { |b| b.button(text:"Upload this file")}

  element(:workshop_submission_link) { |workshopSubmissionName,b| b.a(text:"#{workshopSubmissionName}")}
end
