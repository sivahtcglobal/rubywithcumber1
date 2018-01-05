class Workbenchstreamsmanager < PageFactory #< BasePage

  page_url configatron.essentialWBstreampageURL
  expected_element :sign_out,30

  element(:sign_out) { |b| b.i(class: "icon icon-signout") }
  element(:data_store_tab) {|b| b.h2.small.span(class:"icon icon-archive")}
  element(:streams_tab) {|b| b.a(href:"#tab2")}
  element(:dynamicstream_btn){|b| b.button(text:"Create Dynamic Stream")}
  element(:streammanager_header){|b| b.h1.small(text:"Stream Manager")}
  element(:dynamicstream_header){|b|b.h3(text:"Dynamic Stream Builder")}
  element(:streamname_select_opt){|b| b.select.option(text:"#{@streamname}")}
  element(:streamname_select_opt_1) { |b| b.form(class:"form-horizontal ng-pristine ng-valid").div(class:"control-group",index:1).div(class:"controls").select_list(class:"input ng-pristine ng-valid")}
  element(:add_stream){|b| b.button(text:"Add")}
  #page.streamname_select_1.select "event-sfasdf"
  element(:add_btn){|b| b.form(class:"form-horizontal ng-valid ng-dirty").div(class:"control-group",index:2).div(class:"controls").div(class:"btn-group",index:0).a(class:"btn dropdown-toggle")}
  element(:limit_select) {|b| b.form(class:"form-horizontal ng-valid ng-dirty").div(class:"control-group",index:2).div(class:"controls").div(class:"btn-group",index:0).ul(class:"dropdown-menu").li(index:2).a(text:"Limit and Offset")}
  #element(:limit_define_list){|b| b.li(index:2).a(text:"Limit and Offset")}
  element(:limit_number){|b| b.text_field(class:"ng-pristine ng-valid ng-valid-number")}
  element(:update_limit_btn){|b| b.div(class:"modal modal-wide hide fade ng-scope in").div(class:"modal modal-wide modal-form").div(class:"modal-body").div(class:"row-fluid",index:1).div(class:"controls control-row span12").a(class:"btn btn-primary",index:0)}
  element(:save_dynamic_stream){|b| b.button(text:"Save")}
  element(:dynamicstream_name){|b| b.form(class:"form-horizontal ng-pristine ng-invalid ng-invalid-required").div(class:"control-group",index:0).div(class:"controls").text_field(class:"ng-pristine ng-invalid ng-invalid-required")}
  element(:parentdatacollection_list) { |b| b.form(class:"form-horizontal ng-invalid ng-invalid-required ng-dirty").div(class:"control-group",index:1).div(class:"controls").select_list(name:"parentDataCollectionId")}
  element(:savedynamicstream_clk){|b| b.form(class:"form-horizontal ng-dirty ng-valid ng-valid-required").div(class:"control-group",index:2).div(class:"controls").button(class:"btn btn-sm btn-warning")}
  element(:filter_icon) {|b| b.a(class:"btn btn-mini btn-info pull-right icon red")}
  element(:raw_chk){|b| b.div(class:"span12 pull-left",index:0).div(class:"row-fluid").div(class:"span3",index:1).label.small.input(type:"checkbox")}
  element(:computed_chk){|b| b.div(class:"span12 pull-left",index:0).div(class:"row-fluid").div(class:"span3",index:2).label.small.input(type:"checkbox")}
  element(:dynamic_chk){|b| b.div(class:"span12 pull-left",index:0).div(class:"row-fluid").div(class:"span3",index:3).label.small.input(type:"checkbox")}
  element(:process_chk){|b| b.div(class:"span12 pull-left",index:1).div(class:"row-fluid").div(class:"span3",index:2).label.small.input(type:"checkbox")}
  element(:streamname_filter){|b| b.div(class:"span12 pull-left",index:2).div(class:"row-fluid").div(class:"span9").text_field(class:"input-large ng-pristine ng-valid")}
  element(:edit_icon){|b| b.table(class:"table table-hover ng-scope ng-table").tbody.tr.td(class:"admin-table-row table-icons").span(class:"ng-scope",index:0).a.i(class:"icon icon-edit")}
  element(:delete_dynamicstream){|b| b.div(class:"control-group button-bar").form(class:"form-search ng-pristine ng-valid").button(class:"btn btn-default",index:1)}
  element(:record_count){|b| b.table(class:"table table-hover ng-scope ng-table").tbody.tr.td(class:"admin-table-row ng-scope ng-binding",index:2).text}
  element(:entitystream_name){|b| b.div(class:"row-fluid animated tablebar form-inline").span.text_field(class:"input-large ng-pristine ng-valid")}
end