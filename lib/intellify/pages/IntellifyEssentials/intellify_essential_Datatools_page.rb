class IntellifyEssentialDatatoolsPage < BasePage
#Canvas Data Source Element#
page_url configatron.essentialhomepageURL
element(:pagetitle){|b|b.span(class:"_3ILNGsKIzj4SU7XiRS-pKx-header-module-navbar-header navbar-brand").span(class:"_1rpdSsVTmLmvpUI8wQE6Fu-header-module-title").text}
element(:error) {|b| b.div.h4(text:"There was a problem logging in")}
element(:data_source){|b| b.a(text:"Data Sources")}
element(:data_store){|b| b.a(text:"Data Store")}
element(:acc_setting){|b| b.a(text:"Account Settings")}
element(:help){|b| b.a(text:"Help?")}
element(:data_tool){|b| b.a(text:"Data Tools")}
element(:username){|b| b.ul(class:"_3WwviMrlQll24Rq75UxEZ2-header-module-user nav nav-stacked navbar-nav").li.a.text}
element(:nonadmin_username){|b| b.p(text:"Essentialuser Last")}
element(:nonadmin_usernamechange){|b| b.p(text:"Essentialuser1 Last1")}
element(:data_source_element){|b| b.h1(text:"Data Sources")}
element(:data_store_element){|b| b.h1(text:"Data Store")}
element(:data_tool_element){|b| b.a(id:"data-tools-view-tabs-tab-dataTools")}
element(:acc_sett_element){|b| b.a(id:"account-view-tabs-tab-contactSettings")}
element(:help_element){|b| b.div(text:"Help")}
element (:logout){|b| b.span(class:"glyphicon glyphicon-log-out")}
element (:login_view){|b| b.div(class:"_13r9WFEpleSMyEIUN1ikAa-loginView-module-login-view")}
element(:datasource_btn){|b| b.button(text:"+ Data Source")}
element(:add_datasource_btn){|b| b.button(text:"Add")}
element(:close_datasource_btn){|b| b.button(text:"Close")}
element(:data_source_added){|b| b.h2(text:"Data Sources Added (2)")}
element(:tools_header1){|b| b.div(class:"_3G0bLI8JKx9mamrg-hcfCy-itemPanel-module-section-header row").div(class:"col-sm-9").text}
element(:tools_header2){|b| b.div(class:"_3G0bLI8JKx9mamrg-hcfCy-itemPanel-module-section-header row").div(class:"col-sm-3",index:0).text}
element(:tools_header3){|b| b.div(class:"_3G0bLI8JKx9mamrg-hcfCy-itemPanel-module-section-header row").div(class:"col-sm-3",index:1).text}
element(:tableau_image){|b| b.img(:src,"img/icons/data-tools/tableau.svg")}
element(:csv_name){|b| b.div(class:"_3nD5aEFu_7C2NATtk0op5B-dataToolsView-module-data-tools-name col-sm-9").strong.text}
element(:action_info){|b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:1).div(class:"LrVdZVdNzsIzZTpa04DWA-itemPanel-module-item-panel").div(class:"_2metuZ7-3dsLOkTe8DiQ2o-itemPanel-module-section").div(class:"_1EziSUWUj0iwneEcM9alWI-itemPanel-module-section-body row").div(class:"col-sm-3").button}
element(:export_btn){|b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:0).div(class:"LrVdZVdNzsIzZTpa04DWA-itemPanel-module-item-panel").div(class:"_2metuZ7-3dsLOkTe8DiQ2o-itemPanel-module-section").div(class:"_1EziSUWUj0iwneEcM9alWI-itemPanel-module-section-body row").div(class:"col-sm-3").button(class:"btn btn-info")}
element(:info_header){|b| b.div(class:"_1b3aG6hAtnczhiocqm1Zz1-itemPanel-module-sub-panel").div.h5(class:"_3iIqulRB-qEInMHxaom6B-itemPanel-module-sub-panel-header").text}
element(:setup_info_header){|b| b.div(class:"_1SUduT_E_7LYrD61ZDmgl4-itemPanel-module-sub-panel-container").section(class:"_1ecUzI0G3RYXfLhIB4Qmg4-instructionsSection-module-instructions").div.h4.text}
element(:setup_1){|b| b.ol.li(index:0).text}
element(:setup_2){|b| b.ol.li(index:1).text}
element(:setup_3){|b| b.ol.li(index:2).text}
element(:setup_4){|b| b.ol.li(index:3).text}
element(:setup_5){|b| b.ol.li(index:4).text}
element(:setup_6){|b| b.ol.li(index:5).text}
element(:help_info){|b| b.div(class:"_35aCsbE8ZwiA6ceckA6zUp-support-module-content").a.text}
element (:close_btn){|b| b.div(class:"_11A_80T2eExgVJGgLHf0ai-itemPanel-module-subpanel-toolbar btn-toolbar").button(class:"btn btn-primary")}
element(:csv_image){|b| b.img(:src,"img/icons/data-tools/csv.svg")}
element(:tableau_name){|b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:1).div(class:"LrVdZVdNzsIzZTpa04DWA-itemPanel-module-item-panel").div(class:"_2metuZ7-3dsLOkTe8DiQ2o-itemPanel-module-section").div(class:"_1EziSUWUj0iwneEcM9alWI-itemPanel-module-section-body row").div(class:"_3nD5aEFu_7C2NATtk0op5B-dataToolsView-module-data-tools-name col-sm-9").strong.text}
element(:info_icon){|b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:1).div(class:"LrVdZVdNzsIzZTpa04DWA-itemPanel-module-item-panel").div(class:"_2metuZ7-3dsLOkTe8DiQ2o-itemPanel-module-section").div(class:"_1EziSUWUj0iwneEcM9alWI-itemPanel-module-section-body row").div(class:"col-sm-3").button(class:"btn btn-info")}
element(:csv_control){|b| b.div(class:"XV7yqoQ1qAP6niOtD8ZNm-downloadCSVPanel-module-header").h4.text}
element(:csv_control1){|b| b.div(class:"XV7yqoQ1qAP6niOtD8ZNm-downloadCSVPanel-module-header").p.text}
element(:report_export){|b| b.div(class:"_11A_80T2eExgVJGgLHf0ai-itemPanel-module-subpanel-toolbar btn-toolbar").button(text:"Download")}
element(:report_close){|b| b.div(class:"_11A_80T2eExgVJGgLHf0ai-itemPanel-module-subpanel-toolbar btn-toolbar").button(text:"Close")}
element(:canvas_image){|b| b.img(:src,"https://canvas.instructure.com/favicon")}
element(:canvas_name){|b| b.div(class:"pATdUa7isSiyPKWCwxEZj-dataSourcesView-module-data-source-name col-sm-3").strong.text}
element(:canvas_version){|b| b.div(class:"_3Rhv3oJUPBCQeacHd4o9RV-dataSourcesView-module-source-version").text}
element(:canvas_status){|b| b.div(class:"_3xDTwoZescDeITiYdWMd33-itemStatus-module-item-status").div(class:"O0a0iYSpN72sB9jy4Pl5z-itemStatus-module-label").text}
element(:config_canvas){|b| b.div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(text:"Configure")}
element(:config_header){|b| b.h5(class:"_3iIqulRB-qEInMHxaom6B-itemPanel-module-sub-panel-header").span.text}
element(:inst_header){|b| b.section(class:"_1ecUzI0G3RYXfLhIB4Qmg4-instructionsSection-module-instructions").div.p.text}
element(:step1_inst){|b| b.ol.li(index:0).text}
element(:step2_inst){|b| b.ol.li(index:1).text}
element(:step3_inst){|b| b.ol.li(index:2).text}
element(:step4_inst){|b| b.ol.li(index:3).text}
element(:canvas_synurl){|b| b.label(for:"canvas_file_sync_url",class:"control-label").text}
element(:canvas_synurl_input){|b| b.text_field(id:"canvas_file_sync_url")}
element(:canvas_url){|b| b.label(for:"canvas_portal_url",class:"control-label").text}
element(:canvas_url_input){|b| b.text_field(id:"canvas_portal_url")}
element(:canvas_key){|b| b.label(for:"canvas_key",class:"control-label").text}
element(:canvas_key_input){|b| b.text_field(id:"canvas_key")}
element(:canvas_secret){|b| b.label(for:"canvas_secret",class:"control-label").text}
element(:canvas_secret_input){|b| b.text_field(id:"canvas_secret")}
element(:canvas_courseid){|b| b.label(for:"course_ids",class:"control-label").text}
element(:canvas_courseid_input){|b| b.text_field(id:"course_ids")}
element(:canvas_save){|b| b.button(text:"Save")}
element(:canvas_close){|b| b.button(text:"Close")}
element(:canvas_reports){|b| b.select_list(id:"reportName")}
element(:start_btn){|b| b.div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(index:1)}
element(:permission_tab){|b| b.a(id:"data-tools-view-tabs-tab-permissions")}
element(:tableaulic_header) {|b| b.div(class:"_1SUduT_E_7LYrD61ZDmgl4-itemPanel-module-sub-panel-container").div(index:0).h4.text}
element(:license_header1) {|b| b.div(class:"_3682ikWVKdsl0RB6R-z1EB-licenseKeys-module-license-wrapper").div(class:"_21Sn69r62ySqIJkE1ilwAW-licenseKeys-module-license-key",index:0).div.label(for:"license-1",class:"control-label").text}
element(:license_key1) {|b| b.div(class:"_21Sn69r62ySqIJkE1ilwAW-licenseKeys-module-license-key",index:0).div.input(label:"License Key #1").value}
element(:license_header2) {|b| b.div(class:"_21Sn69r62ySqIJkE1ilwAW-licenseKeys-module-license-key",index:1).div.label(for:"license-2",class:"control-label").text}
element(:license_key2) {|b| b.div(class:"_21Sn69r62ySqIJkE1ilwAW-licenseKeys-module-license-key",index:1).div.input(label:"License Key #2").value}
element(:permission_header){|b| b.div(class:"PSSSXGPC8mEJpEnfy-YAu-reportsList-module-container").h2.text}
element(:permission_header1){|b| b.div(class:"PSSSXGPC8mEJpEnfy-YAu-reportsList-module-container").p.text}
element(:report_groupheader){|b| b.div(class:"panel-group").h4.a(text:"Reports")}
element(:report_groupheader1){|b| b.div(class:"_2J4E8g58tlcFUBMMItehuf-reportsList-module-stream-list panel panel-default",index:1).div.h4.a}
element(:report_name){|row,b| b.div(class:"_2J4E8g58tlcFUBMMItehuf-reportsList-module-stream-list panel panel-default",index:0).div(class:"_3WUyC3J_ylli6WA0Yuo4gh-reportsList-module-stream-item row",index:row).div(class:"col-xs-6").div(class:"T6RKjYgj9ihps6gI2GdC--reportsList-module-stream-name").text}
element(:report_users){|row,b| b.div(class:"_2J4E8g58tlcFUBMMItehuf-reportsList-module-stream-list panel panel-default",index:0).div(class:"_3WUyC3J_ylli6WA0Yuo4gh-reportsList-module-stream-item row",index:row).div(class:"_1qnXvGDpOO9cqvfPjK0s28-reportsList-module-stream-indicator col-xs-3").span.text}
element(:report_editbtn){|row,b| b.div(class:"_2J4E8g58tlcFUBMMItehuf-reportsList-module-stream-list panel panel-default",index:0).div(class:"_3WUyC3J_ylli6WA0Yuo4gh-reportsList-module-stream-item row",index:row).div(class:"_2V5xoCIhIyvooEsiIZ_14--reportsList-module-stream-tools col-xs-3").button(text:"View/Edit Permissions")}
element(:report_header){|b| b.div(class:"_3NuH6xzdq-8L22bvjek713-dialog-module-body modal-body").div(class:"PSSSXGPC8mEJpEnfy-YAu-reportsList-module-container").p(index:0).text}
element(:report_title){|b| b.div(class:"_3NuH6xzdq-8L22bvjek713-dialog-module-body modal-body").div(class:"PSSSXGPC8mEJpEnfy-YAu-reportsList-module-container").p(index:0).span.text}
element(:report_useraccess){|b| b.div(class:"_3NuH6xzdq-8L22bvjek713-dialog-module-body modal-body").div(class:"PSSSXGPC8mEJpEnfy-YAu-reportsList-module-container").h2.text}
element(:report_disc){|b| b.div(class:"_3NuH6xzdq-8L22bvjek713-dialog-module-body modal-body").div(class:"PSSSXGPC8mEJpEnfy-YAu-reportsList-module-container").p(index:1).text}
element(:permission_switch){|b| b.div(class:"_3NuH6xzdq-8L22bvjek713-dialog-module-body modal-body").div(class:"PSSSXGPC8mEJpEnfy-YAu-reportsList-module-container").div.div(class:"SH2KeDbTJZTyQxbJZ9rZi-toggleSwitch-module-toggle-switch-container").button}
element(:save_permission){|b| b.div(class:"modal-footer").button(text:"Save")}
element(:user_name){|row,b| b.table(class:"table custom-table").tbody.tr(index:row).td(index:0).div.div(class:"checkbox").label.text}
element(:user_permission){|row,b| b.table(class:"table custom-table").tbody.tr(index:row).td(index:0).div.div(class:"checkbox").label.input(type:"checkbox")}
element(:report_groupheader_value){|b| b.div(class:"panel-group").h4.a(text:"Reports").attribute_value("aria-expanded")}

#Smarter Measure Data Source Element#
element(:smarter_img){|b| b.img(:src,"img/icons/data-sources/smarter-measure.jpg")}
  element(:smarter_name){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).strong.text}
  element(:smarterconfig_btn){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(text:"Configure")}
 element(:sm_username){|b| b.text_field(id:"smartermeasure_user") }
element(:sm_password){|b| b.text_field(id:"smartermeasure_password") }
  element(:sm_save){|b| b.button(text:"Save")}
element(:sm_close){|b| b.button(text:"Close")}
element(:smarter_status){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).div(class:"O0a0iYSpN72sB9jy4Pl5z-itemStatus-module-label").text}
element(:smarterstart_btn){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(index:1)}
  #Report name and download link
  element(:report_name1){|row,b| b.div(class:"sc-bxivhb cZObmX container-fluid",index:row).p(class:"sc-ifAKCX hvZMRx").text}
  element(:report_column){|row,b| b.div(class:"sc-bxivhb cZObmX container-fluid",index:row).p(class:"sc-gzVnrw kuXmTB").text}
  element(:report_datatablelink){|row,b| b.div(class:"sc-bxivhb cZObmX container-fluid",index:row).button(class:"sc-dnqmqq CaytI btn btn-link")}
  element(:report_downloadicon){|row,b| b.div(class:"sc-bxivhb cZObmX container-fluid",index:row).button(class:"btn btn-info")}
#Moodle Data Tools Page Element#
  element(:moodle_reports_name){|b| b.div(css:"div#csv-download-datachooser")}
  element(:moodle_report) { |item,b| b.p(text:"#{item}")}
  element(:download_report_message) { |item, b| b.span(text:"Your download of #{item} is ready. Your browser should begin downloading the file shortly.")}

end