class SiteHomePage < BasePage

  @siteHomeURL = configatron.moodleURL+'?redirect=0'
  page_url @siteHomeURL

  expected_element :available_course_heading,30
  #Moodle Create User Elements
  element(:available_course_heading) { |b| b.h2(text:"Available courses")}
  #Course Name Link
  element(:course_name_link) { |coursename,b| b.a(text:"#{coursename}")}
end