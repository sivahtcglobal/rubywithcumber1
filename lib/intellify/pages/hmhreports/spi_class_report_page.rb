class SPIClassReport < BasePage

  expected_element :average,30
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
  element(:summary_dis) { |b| b.div.span(text:"This report shows changes in performance and progress on the Phonics Inventory over time.") }
  element(:summary_val1) { |b| b.div.span(text:"No Growth") }
  element(:summary_date_val1) { |b| b.div.span(text:"3") }
  element(:summary_dis1) { |b| b.div.span(text:"Average Fluency Score Growth") }
  element(:summary_val2) { |b| b.div.span(text:"1") }
  element(:summary_date_val2) { |b| b.div.span(text:"1") }
  element(:summary_dis2) { |b| b.div.span(text:"Students Improved Their Fluency Score") }
  element(:summary_val3) { |b| b.div.span(text:"2") }
  element(:summary_date_val3) { |b| b.div.span(text:"2") }
  element(:summary_dis3) { |b| b.div.span(text:"Students Showed No Growth") }
  element(:chart_header) { |b| b.div.span(class:"pull-left panel-text panel-title ng-binding") }
  #row chart header
  element(:firsttest_header){|b| b.h4(text:"First Test")}
  element(:lasttest_header){|b| b.h4(text:"Last Test")}
  #Chart
  element(:chart_first){|b|b.div(id:"first-card-0c6bb355-2cc3-4330-b716-c60f8e8875df")}
  element(:chart_last){|b|b.div(id:"first-card-44556277-0623-42b0-a627-49447974a473")}
  element(:tool_tip1){|b| b.div(text:"Advancing")}
  element(:tool_tip2){|b| b.div(text:"Developing")}
  element(:tool_tip3){|b| b.div(text:"Beginning")}
  element(:tool_tip4){|b| b.div(text:"Pre-Decoder")}
  element(:tool_tip5){|b| b.div(text:"No Test Data")}
  #page header
  element(:group_header_testfirst) { |b| b.th(text:"Test (First)") }
  element(:group_header_testlast) { |b| b.th(text:"Test (Last)") }
  element(:table_header1) { |row,column,b| b.th(class:"text-center column-header ng-scope sort-column up",index:row).span(class:"ng-binding",index:column).text }
  element(:table_header) { |row,column,b| b.th(class:"text-center column-header ng-scope",index:row).span(class:"ng-binding",index:column).text }
  #Table Elements
  element(:table_cell) { |row,column,b| b.tr(class:"ng-scope",index:row).td(class:"ng-scope ng-binding text-center",index:column).text }
  #Table average
  element(:average) { |b| b.td(text:"Average") }
  element(:val1) { |b| b.td(text:"22") }
  element(:val2) { |b| b.td(text:"24") }
  element(:val3) { |b| b.td(text:"18") }
  #decoding status table
  element(:fluencyscore_deco_header) { |b| b.th(text:"Fluency Score") }
  element(:decodingstatus_deco_header) { |b| b.th(text:"Decoding Status") }
  element(:recommended_deco_header) { |b| b.th(text:"Recommended Instruction") }
  element(:decoder_table) { |row,column,b| b.tr(class:"legend-row",index:row).td(index:column).text }
end
