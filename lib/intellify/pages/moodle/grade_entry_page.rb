class CourseDatabasGradeEntryePage < BasePage

  #View single
  element(:view_single_link) { |b| b.a(text:"View single")}
  element(:next_link) { |b| b.a(css:"a[href*='single&page']")}
  element(:fullname) { |b| b.td(css:"tr:nth-child(1) td.lastcol")}
  element(:avg_rating_select) { |b| b.select_list(name:"rating")}
  #View list
  element(:view_list_link) { |b| b.a(text:"View list")}
  element(:rating_verify) { |b| b.span(class:"ratingaggregate")}
end
