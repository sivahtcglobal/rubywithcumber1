class IntellifyEssentialUserDeletionPage < BasePage
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
element(:acc_sett_element){|b| b.a(id:"account-view-tabs-tab-contactSettings")}
element(:user_info){|b| b.a(id:"account-view-tabs-tab-users")}
element(:help_element){|b| b.div(text:"Help")}
element (:logout){|b| b.span(class:"glyphicon glyphicon-log-out")}
  element (:login_view){|b| b.div(class:"_13r9WFEpleSMyEIUN1ikAa-loginView-module-login-view")}
  element(:datasource_btn){|b| b.button(text:"+ Data Source")}
  element(:add_datasource_btn){|b| b.button(text:"Add")}
element(:close_datasource_btn){|b| b.button(text:"Close")}

element(:table_element){|row,b| b.table(class:"table custom-table").tbody.tr(index:row).td(index:0).text}
element(:table_element_delete){|row,b| b.table(class:"table custom-table").tbody.tr(index:row).td(index:5).button(class:"_1176MmK48gFGGejMmzKLFr-usersListTab-module-action-btn btn btn-danger")}
  element(:delete_user){|b| b.div(class:"modal-footer").button(text:"Delete")}
end