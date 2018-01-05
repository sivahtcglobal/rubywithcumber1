class IntellifyEssentialDatasourcePage < BasePage
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
  element(:data_source_element){|b| b.h1(text:"Data Sources")}
element(:data_store_element){|b| b.h1(text:"Data Store")}
element(:data_tool_element){|b| b.a(id:"data-tools-view-tabs-tab-dataTools")}
element(:acc_sett_element){|b| b.h1(text:"Account Settings")}
element(:help_element){|b| b.div(text:"Help")}
element (:logout_btn){|b| b.li(index:1).a.span(class:"glyphicon glyphicon-log-out")}
  element (:login_view){|b| b.div(class:"_13r9WFEpleSMyEIUN1ikAa-loginView-module-login-view")}
  element(:datasource_btn){|b| b.button(text:"+ Data Source")}
element(:canvas_datasource){|b| b.div(text:'Canvas')}
  element(:add_datasource_btn){|row,b| b.span(class:"list-group-item",index:row).button(text:"Add")}
element(:close_datasource_btn){|b| b.div(class:"modal-content").div(class:"modal-footer")}
element(:pause_btn){|b| b.div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(index:1)}
element(:canvas_image){|b| b.img(:src,"https://canvas.instructure.com/favicon")}
element(:canvas_name){|b| b.div(class:"pATdUa7isSiyPKWCwxEZj-dataSourcesView-module-data-source-name col-sm-3").strong.text}
element(:canvas_version){|b| b.div(class:"_3Rhv3oJUPBCQeacHd4o9RV-dataSourcesView-module-source-version").text}
element(:canvas_status){|b| b.div(class:"_3xDTwoZescDeITiYdWMd33-itemStatus-module-item-status").div(class:"O0a0iYSpN72sB9jy4Pl5z-itemStatus-module-label").text}
element(:config_canvas){|b| b.div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(text:"Configure")}
element(:delete_datasource){|b| b.div(class:"_27Xzdxf-PQGGdokTJjD_m1-itemPanel-module-top-buttons",index:0).button.span(class:"glyphicon glyphicon-trash")}
element(:delete_mutidatasource){|b| b.div(class:"_27Xzdxf-PQGGdokTJjD_m1-itemPanel-module-top-buttons",index:1).button.span(class:"glyphicon glyphicon-trash")}
element(:delete_popup){|b| b.button(class:"_2h5EnOQlru2Z8UpkdOUwQE-confirmationDialog-module-modal-button btn btn-danger")}

#Smarter Measure Data Source Element#
 element(:sm_datasource){|b| b.div(text:'Smarter Measure')}
element(:add_sm_datasource){|row,b| b.span(class:"list-group-item",index:row).button(text:"Add")}
element(:smarter_img){|b| b.img(:src,"img/icons/data-sources/smarter-measure.jpg")}
element(:smarter_name){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).strong.text}
element(:smarterconfig_btn){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(text:"Configure")}
element(:sm_username){|b| b.text_field(id:"smartermeasure_user") }
element(:sm_password){|b| b.text_field(id:"smartermeasure_password") }
element(:sm_save){|b| b.button(text:"Save")}
element(:sm_close){|b| b.button(text:"Close")}
element(:sm_delete){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).div(class:"_27Xzdxf-PQGGdokTJjD_m1-itemPanel-module-top-buttons",index:0).button.span(class:"glyphicon glyphicon-trash")}
element(:smarter_status){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).div(class:"O0a0iYSpN72sB9jy4Pl5z-itemStatus-module-label").text}
element(:smarterstart_btn){|row,b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:row).div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(index:1)}
  element(:pause_SMbtn){|b| b.div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3",index:1).button(index:1)}
end