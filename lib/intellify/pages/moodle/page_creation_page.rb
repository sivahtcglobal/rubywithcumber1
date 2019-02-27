class CoursePagePage < BasePage

  #Moodle Create Course Page Elements
  element(:page_name_txt) { |b| b.text_field(id:"id_name")}
  element(:page_description_txt) { |b| b.div(css:"#id_introeditoreditable")}
  element(:page_description_chkbox) { |b| b.input(id:"id_showdescription")}
  element(:page_content_txt) { |b| b.div(id:"id_pageeditable")}

  #Tags
  element(:tags_link) { |b| b.a(text:"Tags")}
  element(:tags_label) { |b| b.label(text:"Tags")}
  element(:enter_tags) { |b| b.input(placeholder:"Enter tags...")}
  element(:delete_tag) { |b| b.span(css:"span[role='listitem']:nth-child(2) span")}

  #Submit Buttons
  element(:page_saveandreturncourse_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:page_saveandreturncourse_btn_clk) { |b| b.page_saveandreturncourse_btn.click }
  element(:page_saveanddisplay_btn) { |b| b.input(id:"id_submitbutton") }
  action(:page_saveanddisplay_btn_clk) { |b| b.page_saveanddisplay_btn.click }

end
