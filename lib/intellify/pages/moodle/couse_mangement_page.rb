class CouseManagmentPage < BasePage

  @couseManagement = configatron.moodleURL+'/course/management.php'
  page_url @couseManagement

  #expected_element :create_course_link,30

  #Moodle Login Elements


  element(:intellify_catagory_link) { |b| b.a(text:"Intellify")}
  element(:select_category_link) { |categoryname,b| b.a(text:"#{categoryname}")}

  element(:create_course_link) { |b| b.a(text:"Create new course")}
  action(:create_course_link_clk){ |b| b.create_course_link.click }

  element(:course_name_link) { |coursename,b| b.a(text:"#{coursename}")}

end
