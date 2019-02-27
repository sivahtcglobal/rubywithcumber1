class CourseDeletePage < BasePage

  # @couseManagement = configatron.moodleURL+'course/delete.php?id=33'
  #expected_element :confirmation_message,30


  #Moodle Create Course Page Elements
  element(:confirmation_message) { |b| b.p(text:"Are you absolutely sure you want to completely delete this course and all the data it contains?")}
  element(:delete_button) { |b| b.button(text:"Delete")}
  element(:delete_button_clk) { |b| b.delete_button.click }

  element(:continue_button) { |b| b.button(text:"Continue")}
  element(:continue_button_clk) { |b| b.continue_button.click }


end
