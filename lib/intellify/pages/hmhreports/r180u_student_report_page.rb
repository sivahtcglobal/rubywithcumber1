class R180UStudentReport < BasePage

   expected_element :segmentaverage,45

   element(:reset) { |b| b.a.i(class:"icon-remove") }

   element(:segmentaverage) { |b| b.td(text:"Segment Averages") }
   element(:header) { |b| b.div(class:"hmh-report-title") }
   element(:classname) { |b| b.div.span(class:"hmh-report-sub-title") }
   element(:printicon) { |b| b.div(class:"span-2 print-button ng-scope") }
   element(:read180img) { |b| b.div.img(src:"https://hmh2.intellifylearning.com/img/hmh/logo-read180.png")}
   element(:daterange) { |b| b.text_field(id:"date-range-field") }
   element(:startdate){|b| b.text_field(name:"daterangepicker_start")}
   element(:enddate){|b| b.text_field(name:"daterangepicker_end")}
   element(:apply){|b| b.button(class:"applyBtn btn btn-sm btn-success")}

   element(:summary_header) { |b| b.div.span(text:"Summary") }
   element(:summary_dis) { |b| b.div.span(text:"This report measures individual student progress and performance in the Student Application.") }
   element(:summary_val1) { |b| b.div.span(text:"6") }
   element(:summary_dis1) { |b| b.div.span(text:"Current Level") }
   element(:summary_val2) { |b| b.div.span(text:"31") }
   element(:summary_dis2) { |b| b.div.span(text:"Average Session Length (Minutes)") }
   element(:summary_val3) { |b| b.div.span(text:"1") }
   element(:summary_dis3) { |b| b.div.span(text:"Segments Completed") }
   element(:chart_header) { |b| b.div.span(class:"pull-left panel-text panel-title ng-binding") }

   element(:group_header_imp) { |b| b.th(text:"Implementation") }

   element(:table_header_stu) { |b| b.th(text:"Performance") }


   element(:bar_chart){|b| b.div(class:"dc-chart")}
   element(:bar_chart_tooltip){|b| b.div(text:"Average (all segments)")}
   element(:bar_chart_tooltip2){|b| b.div(text:"Current segment")}

   element(:segment) { |b| b.span(text:"Segment") }
   element(:level) { |b| b.span(text:"Level") }
   element(:date_start) { |b| b.span(text:"Date Started") }
   element(:date_completed) { |b| b.span(text:"Date Completed") }
   element(:averagessw) { |b| b.span(text:"Sessions") }
   element(:explore) { |b| b.span(text:"Explore Zone") }
   element(:reading) { |b| b.span(text:"Reading Zone") }
   element(:language) { |b| b.span(text:"Language Zone") }
   element(:word) { |b| b.span(text:"Word Assessment") }
   element(:spelling) { |b| b.span(text:"Spelling Assessment") }
   element(:success) { |b| b.span(text:"Success Zone") }
   #avergae row
   element(:val1) { |b| b.td(text:"Segment Averages") }
   element(:val2) { |b| b.td(text:"4") }
   element(:val3) { |b| b.td(text:"63%") }
   element(:val4) { |b| b.td(text:"30%") }
   element(:val5) { |b| b.td(text:"75%") }
   element(:val6) { |b| b.td(text:"80%") }
   element(:val7) { |b| b.td(text:"81%") }
   element(:val8) { |b| b.td(text:"100%") }
   element(:date_val1) { |b| b.td(text:"Segment Averages") }
   element(:date_val2) { |b| b.td(text:"1") }
   element(:date_val3) { |b| b.td(text:"50%") }
   element(:date_val4) { |b| b.td(text:"30%") }
   element(:date_val5) { |b| b.td(text:"100%") }
   element(:date_val6) { |b| b.td(text:"80%") }
   element(:date_val7) { |b| b.td(text:"75%") }


   #table element
   element(:table_cell) { |row,column,b| b.tr(class:"ng-scope",index:row).td(class:"ng-scope ng-binding text-center",index:column).text }
end
