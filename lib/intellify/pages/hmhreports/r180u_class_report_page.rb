class R180UClassReport < BasePage

  expected_element :average,45

  element(:header) { |b| b.div(class:"hmh-report-title") }
  element(:classname) { |b| b.div.span(class:"hmh-report-sub-title") }
  element(:printicon) { |b| b.div(class:"span-2 print-button ng-scope") }
  element(:read180img) { |b| b.div.img(src:"https://hmh2.intellifylearning.com/img/hmh/logo-read180.png")}
  element(:daterange) { |b| b.text_field(id:"date-range-field") }
  element(:startdate){|b| b.text_field(name:"daterangepicker_start")}
  element(:enddate){|b| b.text_field(name:"daterangepicker_end")}
  element(:apply){|b| b.button(class:"applyBtn btn btn-sm btn-success")}

  element(:summary_header) { |b| b.div.span(text:"Summary") }
  element(:summary_dis) { |b| b.div.span(text:"This report measures class usage and performance in the Student Application.") }
  element(:summary_val1) { |b| b.div.span(text:"1") }
  element(:summary_dis1) { |b| b.div.span(text:"Average Segments Completed") }
  element(:summary_val2) { |b| b.div.span(text:"33") }
  element(:summary_dis2) { |b| b.div.span(text:"Average Session Length (Minutes)") }
  element(:summary_val3) { |b| b.div.span(text:"1") }
  element(:summary_dis3) { |b| b.div.span(text:"Average Sessions Per Week") }
  element(:chart_header) { |b| b.div.span(class:"pull-left panel-text panel-title ng-binding") }

  element(:group_header_imp) { |b| b.th(text:"Implementation") }

  element(:table_header_stu) { |b| b.span(text:"Student") }

  element(:average) { |b| b.td(text:"Averages") }
  element(:val1) { |b| b.td(text:"2") }
  element(:val2) { |b| b.td(text:"1") }
  element(:val3) { |b| b.td(text:"77") }
  element(:val4) { |b| b.td(text:"33") }
  element(:val5) { |b| b.td(text:"1") }
  element(:val6) { |b| b.td(text:"65%") }
  element(:val7) { |b| b.td(text:"81%") }
  element(:val8) { |b| b.td(text:"95%") }
  element(:val9) { |b| b.td(text:"91%") }
  element(:val10) { |b| b.td(text:"79%") }
  element(:val11) { |b| b.td(text:"88%") }
  element(:date_val1) { |b| b.td(text:"3") }
  element(:date_val2) { |b| b.td(text:"1") }
  element(:date_val3) { |b| b.td(text:"79") }
  element(:date_val4) { |b| b.td(text:"23") }
  element(:date_val5) { |b| b.td(text:"1") }
  element(:date_val6) { |b| b.td(text:"62%") }
  element(:date_val7) { |b| b.td(text:"66%") }
  element(:date_val8) { |b| b.td(text:"90%") }
  element(:date_val9) { |b| b.td(text:"89%") }
  element(:date_val10) { |b| b.td(text:"72%") }
  element(:date_val11) { |b| b.td(text:"75%") }

  element(:level) { |b| b.span(text:"Level") }

  element(:session) { |b| b.span(text:"Sessions") }
  element(:segments) { |b| b.span(text:"Segments") }
  element(:time) { |b| b.span(text:"Time (Min.)") }
  element(:averagessm) { |b| b.span(text:"Average Session (min.)") }
  element(:averagessw) { |b| b.span(text:"Average Sessions / Week") }
  element(:explore) { |b| b.span(text:"Explore Zone") }
  element(:reading) { |b| b.span(text:"Reading Zone") }
  element(:language) { |b| b.span(text:"Language Zone") }
  element(:word) { |b| b.span(text:"Word Assessment") }
  element(:spelling) { |b| b.span(text:"Spelling Assessment") }
  element(:success) { |b| b.span(text:"Success Zone") }
  element(:minuteheader) {|b| b.h4(text:"Minutes")}


  #Table Elements
  #Table Elements
  element(:table_cell) { |row,column,b| b.tr(class:"ng-scope",index:row).td(class:"ng-scope ng-binding text-center",index:column).text }
  # element(:table_cell){|b| b.tbody(tr{1}.td{2}.(class:"ng-scope ng-binding text-center"))}
  #
  # # element(:student_name1){|b| b.table(ng-table:"simpleTable").tr{0}.cell{1}}
  #
  # #element(:stud1_level){|b| b.table(:id => "table").tr{0}.cell{2}.text}
end
