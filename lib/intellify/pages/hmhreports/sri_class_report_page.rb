class SRIClassReport < BasePage
  expected_element :average,30
  @s1  =   174.chr("UTF-8")
  @s3 = 47.chr("UTF-8")
  element(:header) { |b| b.div(class:"hmh-report-title").text }
  element(:classname) { |b| b.div.span(class:"hmh-report-sub-title").text }
  element(:printicon) { |b| b.div(class:"span-2 print-button ng-scope") }
  element(:readinginventoryimg) { |b| b.div.img(src:"https://hmhprod2.intellifylearning.com/img/hmh/reading-inventory.svg")}
  element(:daterange) { |b| b.text_field(id:"date-range-field") }
  element(:startdate){|b| b.text_field(name:"daterangepicker_start")}
  element(:enddate){|b| b.text_field(name:"daterangepicker_end")}
  element(:apply){|b| b.button(class:"applyBtn btn btn-sm btn-success")}
  #summary row
  element(:summary_header) { |b| b.div.span(text:"Summary") }
  element(:summary_dis) { |b| b.div.span(text:"This report measures student proficiency and growth on the Reading Inventory assessment.") }
  element(:summary_val1) { |b| b.div.span(text:"No Growth") }
  element(:summary_dis1) { |b| b.div.span(text:"Average Lexile#{@s1} Growth") }
  element(:summary_val2) { |b| b.div.span(text:"N#{@s3}A") }
  element(:summary_dis2) { |b| b.div.span(text:"Students Improved Their Lexile#{@s1}") }
  element(:summary_val3) { |b| b.div.span(text:"3") }
  element(:summary_date_val3) { |b| b.div.span(text:"1") }
  element(:summary_dis3) { |b| b.div.span(text:"Students Showed No Growth") }
  element(:chart_header) { |b| b.div.span(class:"pull-left panel-text panel-title ng-binding") }
  #row chart header
  element(:firsttest_header){|b| b.h4(text:"First Test")}
  element(:lasttest_header){|b| b.h4(text:"Last Test")}
  #Chart
  element(:chart_first){|b|b.div(id:"first-card-276afc8f-3b73-46c5-ab49-758c91b356f2")}
  element(:chart_last){|b|b.div(id:"first-card-f585e0af-e8ea-4180-a4c1-2e15c69b0978")}
  element(:tool_tip1){|b| b.div(text:"Advanced")}
  element(:tool_tip2){|b| b.div(text:"Proficient")}
  element(:tool_tip3){|b| b.div(text:"Basic")}
  element(:tool_tip4){|b| b.div(text:"Below Basic")}
  element(:tool_tip5){|b| b.div(text:"No Test Data")}
  #page header
  element(:group_header_attemptfirst) { |b| b.th(text:"Attempt (First)") }
  element(:group_header_attemptlast) { |b| b.th(text:"Attempt (Last)") }
  element(:growth_header){|b| b.th(text:"Growth")}
  element(:table_header1) { |row,column,b| b.th(class:"text-center column-header ng-scope sort-column up",index:row).span(class:"ng-binding",index:column).text }
  element(:table_header) { |row,column,b| b.th(class:"text-center column-header ng-scope",index:row).span(class:"ng-binding",index:column).text }
  #Table Elements
  element(:table_cell) { |row,column,b| b.tr(class:"ng-scope",index:row).td(class:"ng-scope ng-binding text-center",index:column).text }
  #Table average
  element(:average) { |b| b.td(text:"Average") }
  element(:val1) { |b| b.td(text:"478") }
  element(:val2) { |b| b.td(text:"465") }
  element(:val3) { |b| b.td(text:"No Growth") }
  element(:date_val1) { |b| b.td(text:"654") }
  element(:date_val2) { |b| b.td(text:"526") }
end
