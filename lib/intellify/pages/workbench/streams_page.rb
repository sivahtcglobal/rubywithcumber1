class WorkbenchStreams < BasePage

  @streamsPage = configatron.workbenchURL+'/wb/#/admin/explore'
  page_url @streamsPage

  element(:stream_manager_txt) {|b| b.div(class:"lead span3").span.h1.small}
  element(:filter_btn1) {|b| b.div(class:"lead span3").a(title:"Filter").i}
  element(:refresh_btn1) {|b| b.div(class:"lead span3").a(title:"Refresh").small.i}
  element(:filter_btn2) {|b| b.div(class:"span2 pull-right").a.i(class:"icon icon-filter")}
  element(:refresh_btn2) {|b| b.div(class:"span2 pull-right").a(class:"btn-success").small.i(class:"icon-refresh")}
  element(:create_2_computed_stream_btn) {|b| b.div(class:"span9 button-row").button(text:"Create 2.0 Computed Stream")}
  element(:create_dynamic_stream_btn) {|b| b.div(class:"span9 button-row").button(text:"Create Dynamic Stream")}

  element(:provider_lbl) {|b| b.div(class:"ng-table-responsive").table.thead.tr.th.div(text:"Provider")}
  element(:stream_lbl) {|b| b.div(css:"div.ng-table-responsive > table > thead > tr > th:nth-child(2) > div")}
  element(:records_lbl) {|b| b.div(css:"div.ng-table-responsive > table > thead > tr > th:nth-child(3) > div")}
  element(:size_lbl) {|b| b.div(css:"div.ng-table-responsive > table > thead > tr > th:nth-child(4) > div")}
  element(:version_lbl) {|b| b.div(css:"div.ng-table-responsive > table > thead > tr > th:nth-child(5) > div")}
  element(:active_lbl) {|b| b.div(css:"div.ng-table-responsive > table > thead > tr > th:nth-child(6) > div")}
  element(:processing_lbl) {|b| b.div(css:"div.ng-table-responsive > table > thead > tr > th:nth-child(7) > div")}
  element(:type_lbl) {|b| b.div(css:"div.ng-table-responsive > table > thead > tr > th:nth-child(8) > div")}
  element(:actions_lbl) {|b| b.div(class:"ng-table-responsive").table.thead.tr.th(text:"Actions")}

  element(:type_filter_lbl) {|b| b.small(css:"div:nth-child(1) > div > div > label > span > small")}
  element(:raw_filter_lbl) {|b| b.small(css:"div:nth-child(1) > div:nth-child(1) > div > div:nth-child(2) > label > small")}
  element(:raw_filter_chkbx) {|b| b.input(css:"div:nth-child(1) > div:nth-child(1) > div > div:nth-child(2) > label > small > input")}
  element(:computed_filter_lbl) {|b| b.small(css:"div:nth-child(1) > div:nth-child(1) > div > div:nth-child(3) > label > small")}
  element(:computed_filter_chkbx) {|b| b.input(css:"div:nth-child(1) > div:nth-child(1) > div > div:nth-child(3) > label > small > input")}
  element(:dynamic_filter_lbl) {|b| b.small(css:"div:nth-child(1) > div:nth-child(1) > div > div:nth-child(4) > label > small")}
  element(:dynamic_filter_chkbx) {|b| b.input(css:"div:nth-child(1) > div:nth-child(1) > div > div:nth-child(4) > label > small > input")}

  element(:status_filter_lbl) {|b| b.small(css:"div:nth-child(2) > div > div > label > span > small")}
  element(:active_filter_lbl) {|b| b.small(css:"div:nth-child(1) > div:nth-child(2) > div > div:nth-child(2) > label > small")}
  element(:active_filter_chkbx) {|b| b.input(css:"div:nth-child(1) > div:nth-child(2) > div > div:nth-child(2) > label > small > input")}
  element(:processing_filter_lbl) {|b| b.small(css:"div:nth-child(1) > div:nth-child(2) > div > div:nth-child(3) > label > small")}
  element(:processing_filter_chkbx) {|b| b.input(css:"div:nth-child(1) > div:nth-child(2) > div > div:nth-child(3) > label > small > input")}

  element(:name_filter_lbl) {|b| b.small(css:"div:nth-child(3)> div > div > label > span > small")}
  element(:search_stream_txt) {|b| b.input(css:"div.row-fluid > div:nth-child(3) > div > div:last-child > input")}

  element(:search_stream_txt2) {|b| b.input(css:"span:nth-child(1) > input")}
  element(:type_filter_lbl2) {|b| b.small(css:"span:nth-child(2) > label > span > small")}
  element(:raw_filter_lbl2) {|b| b.small(css:"span:nth-child(2) > label:nth-child(2) > small")}
  element(:raw_filter_chkbx2) {|b| b.input(css:"span:nth-child(2) > label:nth-child(2) > small > input")}
  element(:computed_filter_lbl2) {|b| b.small(css:"span:nth-child(2) > label:nth-child(3) > small")}
  element(:computed_filter_chkbx2) {|b| b.input(css:"span:nth-child(2) > label:nth-child(3) > small > input")}
  element(:dynamic_filter_lbl2) {|b| b.small(css:"span:nth-child(2) > label:nth-child(4) > small")}
  element(:dynamic_filter_chkbx2) {|b| b.input(css:"span:nth-child(2) > label:nth-child(4) > small > input")}

end
