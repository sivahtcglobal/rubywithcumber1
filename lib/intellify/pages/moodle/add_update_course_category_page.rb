class AddAndUpdateCourseCategoryPage < BasePage

  @addCourseCategoryURL = configatron.moodleURL+'/course/editcategory.php?parent=0'
  page_url @addCourseCategoryURL

  expected_element :category_name,30

  #Moodle Create Course Category Elements
  element(:category_name) { |b| b.text_field(id:"id_name")}
  element(:category_num) { |b| b.text_field(id:"id_idnumber")}

  element(:submit_category_button) { |b| b.button(id: "id_submitbutton") }
  action(:submit_category_button_click) { |b| b.submit_category_button.click }

end