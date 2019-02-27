class IntellifyEssentialDatasourcePage < BasePage

page_url configatron.essentialhomepageURL
element(:pagetitle){|b|b.span(text:"Intellify Essentials")}
element(:error) {|b| b.div.h4(text:"There was a problem logging in")}
  element(:data_source){|b| b.a(text:"Data Sources")}
element(:data_store){|b| b.a(text:"Data Store")}
element(:acc_setting){|b| b.a(text:"Account Settings")}
element(:help){|b| b.a(text:"Help?")}
element(:data_tool){|b| b.a(text:"Data Tools")}
  element(:username){|b| b.p(text:"EssentialsAdmin user")}
  element(:data_source_element){|b| b.h1(text:"Data Sources")}
element(:data_store_element){|b| b.h1(text:"Data Store")}
element(:data_tool_element){|b| b.h1(text:"Data Tools")}
element(:acc_sett_element){|b| b.h1(text:"Account Settings")}
element(:help_element){|b| b.div(text:"Help")}
element (:logout_btn){|b| b.a.span(class:"glyphicon glyphicon-log-out")}
  element (:login_view){|b| b.div(class:"_13r9WFEpleSMyEIUN1ikAa-loginView-module-login-view")}
  element(:datasource_btn){|b| b.button(text:"+ Data Source")}
  element(:add_datasource_btn){|b| b.button(text:"Add")}
element(:close_datasource_btn){|b| b.div(class:"modal-content").div(class:"modal-footer")}
element(:pause_btn){|b| b.div(class:"_2hg4byZPIxUF3AhNkIpTzS-dataSourcesView-module-actions col-sm-3").button(index:1)}
element(:canvas_image){|b| b.img(:src,"https://canvas.instructure.com/favicon")}
element(:canvas_name){|b| b.div(class:"pATdUa7isSiyPKWCwxEZj-dataSourcesView-module-data-source-name col-sm-3").strong.text}
element(:canvas_version){|b| b.div(class:"_3Rhv3oJUPBCQeacHd4o9RV-dataSourcesView-module-source-version").text}
element(:canvas_status){|b| b.div(class:"_3xDTwoZescDeITiYdWMd33-itemStatus-module-item-status").div(class:"O0a0iYSpN72sB9jy4Pl5z-itemStatus-module-label").text}

end