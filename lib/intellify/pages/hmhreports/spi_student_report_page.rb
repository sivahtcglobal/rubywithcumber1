class SPIStudentReport < BasePage
  @s1  =   174.chr("UTF-8")
  expected_element :fluencyscore_deco_header,45
  element(:header) { |b| b.div(class:"hmh-report-title").text }
  element(:classname) { |b| b.div.span(class:"hmh-report-sub-title").text }
  element(:printicon) { |b| b.div(class:"span-2 print-button ng-scope") }
  element(:phonicsinventoryimg) { |b| b.div.img(src:"https://hmh2.intellifylearning.com/img/hmh/logo-phonics.png")}
  element(:daterange) { |b| b.text_field(id:"date-range-field") }
  element(:startdate){|b| b.text_field(name:"daterangepicker_start")}
  element(:enddate){|b| b.text_field(name:"daterangepicker_end")}
  element(:apply){|b| b.button(class:"applyBtn btn btn-sm btn-success")}
  #summary row
  element(:summary_header) { |b| b.div.span(text:"Summary") }
  element(:summary_dis) { |b| b.div.span(text:"This report shows detailed performance data and progress over multiple Phonics Inventory assessment administrations.") }
  element(:summary_val1) { |b| b.div.span(text:"37") }
  element(:summary_date_val1) { |b| b.div.span(text:"34") }
  element(:summary_dis1) { |b| b.div.span(text:"Current Fluency Score") }
  element(:summary_val2) { |b| b.div.span(text:"Advancing") }
  element(:summary_date_val2) { |b| b.div.span(text:"Advancing") }
  element(:summary_dis2) { |b| b.div.span(text:"Current Decoding Status") }
  element(:summary_val3) { |b| b.div.span(text:"1326L") }
  element(:summary_date_val3) { |b| b.div.span(text:"1326L") }
  element(:summary_dis3) { |b| b.div.span(text:"Tested 1/5/16") }
  element(:chart_header) { |b| b.div.span(class:"pull-left panel-text panel-title ng-binding") }
  #Chart
  element(:line_chart){|b|b.div(id:"first-card-0496e18c-d666-46ca-9312-d23dfe9b8964")}
  element(:tool_tip1){|b| b.div(text:"Advancing")}
  element(:tool_tip2){|b| b.div(text:"Developing")}
  element(:tool_tip3){|b| b.div(text:"Beginning")}
  element(:tool_tip4){|b| b.div(text:"Pre-Decoder")}
  #page header
  element(:group_header) { |b| b.th(text:"Percent Accurate and Fluent on PI Subtests") }
  element(:table_header1) { |row,column,b| b.th(class:"text-center column-header ng-scope sort-column down",index:row).span(class:"ng-binding",index:column).text }
  element(:table_header) { |row,column,b| b.th(class:"text-center column-header ng-scope",index:row).span(class:"ng-binding",index:column).text }
  #Table Elements
  element(:table_cell) { |row,column,b| b.tr(class:"ng-scope",index:row).td(class:"ng-scope ng-binding text-center",index:column).text }

  #decoding status table
  element(:fluencyscore_deco_header) { |b| b.th(text:"Fluency Score") }
  element(:decodingstatus_deco_header) { |b| b.th(text:"Decoding Status") }
  element(:recommended_deco_header) { |b| b.th(text:"Recommended Instruction") }
  element(:decoder_table) { |row,column,b| b.tr(class:"legend-row",index:row).td(index:column).text }
end
