class IntellifyEssentialUserDeletionPage < BasePage
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
element(:acc_sett_element){|b| b.a(id:"account-view-tabs-tab-contactSettings")}
element(:user_info){|b| b.a(id:"account-view-tabs-tab-users")}
element(:help_element){|b| b.div(text:"Help")}
element (:logout){|b| b.li(index:1).a.span(class:"glyphicon glyphicon-log-out")}
  element (:login_view){|b| b.div(class:"_13r9WFEpleSMyEIUN1ikAa-loginView-module-login-view")}
  element(:datasource_btn){|b| b.button(text:"+ Data Source")}
  element(:add_datasource_btn){|b| b.button(text:"Add")}
element(:close_datasource_btn){|b| b.button(text:"Close")}

element(:table_element){|row,b| b.table(class:"table custom-table").tbody.tr(index:row).td(index:0).text}
element(:table_element_delete){|row,b| b.table(class:"table custom-table").tbody.tr(index:row).td(index:5).button(class:"_1176MmK48gFGGejMmzKLFr-usersListTab-module-action-btn btn btn-danger")}
  element(:delete_user){|b| b.div(class:"modal-footer").button(text:"Delete")}
end