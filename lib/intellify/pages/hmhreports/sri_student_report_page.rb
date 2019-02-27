class SRIStudentReport < BasePage

  expected_element :date_header,45

  # element(:header) { |b| b.div(class:"hmh-report-title") }
  # element(:classname) { |b| b.div.span(class:"hmh-report-sub-title") }
  # element(:printicon) { |b| b.div.span(class:"icon") }
  # element(:printlable) { |b| b.div(text:"    Print") }
  # element(:reset) { |b| b.a.i(class:"icon-remove") }
  # element(:read180img) { |b| b.div.img(src:"https://hmh2.intellifylearning.com/img/hmh/logo-read180.png")}
  # element(:daterange) { |b| b.span.input(id:"date-range-field") }
  #
   # element(:date_header) { |b| b.div.table.thead.tr.th.span.i(text:"Date") }
  element(:date_header) { |b| b.p(text:"Test duration under 15 minutes") }
  element(:clockicon){|b| b.img(:src,"/img/hmh/clock.png")}
  @s1  =   174.chr("UTF-8")
  element(:header) { |b| b.div(class:"hmh-report-title").text }
  element(:classname) { |b| b.div.span(class:"hmh-student-title").text }
  element(:printicon) { |b| b.div(class:"span-2 print-button ng-scope") }
  element(:readinginventoryimg) { |b| b.div.img(src:"https://hmh2.intellifylearning.com/img/hmh/reading-inventory.svg")}
  element(:daterange) { |b| b.text_field(id:"date-range-field") }
  element(:startdate){|b| b.text_field(name:"daterangepicker_start")}
  element(:enddate){|b| b.text_field(name:"daterangepicker_end")}
  element(:apply){|b| b.button(class:"applyBtn btn btn-sm btn-success")}
  #summary row
  element(:summary_header) { |b| b.div.span(text:"Summary") }
  element(:summary_dis) { |b| b.div.span(text:"This report measures student progress toward proficiency over multiple Reading Inventory assessment administrations.") }
  element(:summary_val1) { |b| b.div.span(text:"1326L") }
  element(:summary_date_val1) { |b| b.div.span(text:"1206L") }
  element(:summary_dis1) { |b| b.div.span(text:"Current Lexile#{@s1}") }
  element(:summary_val2) { |b| b.div.span(text:"183L") }
  element(:summary_date_val2) { |b| b.div.span(text:"63L") }
  element(:summary_dis2) { |b| b.div.span(text:"Total Lexile#{@s1} Growth") }
  element(:summary_val3) { |b| b.div.span(text:"Advanced") }
  element(:summary_date_val3) { |b| b.div.span(text:"Advanced") }
  element(:summary_dis3) { |b| b.div.span(text:"Performance Level") }
  element(:chart_header) { |b| b.div.span(class:"pull-left panel-text panel-title ng-binding") }
  #Chart
  element(:line_chart){|b|b.div(id:"first-card-0a7eb446-c1f3-41f7-937b-27734668bcb6")}
  element(:tool_tip1){|b| b.div(text:"Advanced")}
  element(:tool_tip2){|b| b.div(text:"Proficient")}
  element(:tool_tip3){|b| b.div(text:"Basic")}
  element(:tool_tip4){|b| b.div(text:"Below Basic")}
  #page header
  element(:group_header) { |b| b.th(text:"Test Data") }
  element(:group_header2) { |b| b.th(text:"Normative Data") }
  element(:table_header1) { |row,column,b| b.th(class:"text-center column-header ng-scope sort-column down",index:row).span(class:"ng-binding",index:column).text }
  element(:table_header) { |row,column,b| b.th(class:"text-center column-header ng-scope",index:row).span(class:"ng-binding",index:column).text }
  #Table Elements
  element(:table_cell) { |row,column,b| b.tr(class:"ng-scope",index:row).td(class:"ng-scope ng-binding text-center",index:column).text }


end
