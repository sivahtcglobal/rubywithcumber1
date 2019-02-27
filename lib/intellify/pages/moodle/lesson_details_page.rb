class LessonDetailsPage < BasePage


  #expected_element :create_question_page_link,30

  #Moodle Create User Elements
  element(:add_question_page_link) { |b| b.a(text:"Add a question page")}

end