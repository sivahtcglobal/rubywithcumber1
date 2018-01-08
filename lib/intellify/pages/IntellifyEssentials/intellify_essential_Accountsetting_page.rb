class IntellifyEssentialAccSettingPage < BasePage
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
element (:logout){|b| b.span(class:"glyphicon glyphicon-log-out")}
  element (:login_view){|b| b.div(class:"_13r9WFEpleSMyEIUN1ikAa-loginView-module-login-view")}
  element(:datasource_btn){|b| b.button(text:"+ Data Source")}
  element(:add_datasource_btn){|b| b.button(text:"Add")}
element(:close_datasource_btn){|b| b.button(text:"Close")}
  element(:acc_owner){|b| b.div(class:"isvry7fZOg_HeyhKL5rAE-accountSettings-module-account-container").div(class:"row",index:0).div(class:"_3TV0_50bMcanjjaCxSnoj4-accountSettings-module-contact-info vertical-label-info col-md-12").div(class:"row").div(class:"col-md-10").h3}
  element(:acc_view){|b| b.div(id:"account-view-tabs")}
  element(:user_table){|row,column,b| b.table(class:"table custom-table").tbody.tr(index:row).td(index:column).text}
   element(:org_edit){|b| b.div(class:"_1pyB5dXx1Bd06i5dk7NvGf-contactinfo-module-control text-right col-md-2").button.span(class:"glyphicon glyphicon-pencil")}
  element(:org_name_ip){|b| b.text_field(id:"accountOwner.companyName")}
element(:org_street_ip){|b| b.text_field(id:"accountOwner.companyAddressStreet")}
element(:org_city_ip){|b| b.text_field(id:"accountOwner.companyAddressCity")}
element(:org_state_ip){|b| b.div(class:"Select-menu-outer").div(id:"react-select-2--list").div(text:"MA")}
element(:org_zip_ip){|b| b.text_field(id:"accountOwner.companyAddressZip")}
  element(:org_save){|b| b.div(class:"text-right col-sm-12").button(text:"Save")}
  element(:acc_con_edit){|b| b.div(class:"_1pyB5dXx1Bd06i5dk7NvGf-contactinfo-module-control text-right col-md-2",index:1).button.span(class:"glyphicon glyphicon-pencil")}
element(:acc_fname_ip){|b| b.text_field(id:"accountContact.firstName")}
element(:acc_lname_ip){|b| b.text_field(id:"accountContact.lastName")}
element(:acc_title_ip){|b| b.text_field(id:"accountContact.title")}
    element(:acc_email_ip){|b| b.text_field(id:"accountContact.email")}
        element(:acc_contact_ip){|b| b.text_field(id:"accountContact.phone")}
        element(:acc_save){|b| b.div(class:"text-right col-sm-12",index:1).button(text:"Save")}
element(:tech_con_edit){|b| b.div(class:"_1pyB5dXx1Bd06i5dk7NvGf-contactinfo-module-control text-right col-md-2",index:2).button.span(class:"glyphicon glyphicon-pencil")}
element(:tech_fname_ip){|b| b.text_field(id:"technicalContact.firstName")}
element(:tech_lname_ip){|b| b.text_field(id:"technicalContact.lastName")}
element(:tech_title_ip){|b| b.text_field(id:"technicalContact.title")}
element(:tech_email_ip){|b| b.text_field(id:"technicalContact.email")}
element(:tech_contact_ip){|b| b.text_field(id:"technicalContact.phone")}
element(:tech_save){|b| b.div(class:"text-right col-sm-12",index:2).button(text:"Save")}
element(:org_state_clk){|b| b.div(class:"Select Select--single is-clearable is-searchable has-value").div(class:"Select-control")}
element(:acc_timezone_edit){|b| b.div(class:"_1pyB5dXx1Bd06i5dk7NvGf-contactinfo-module-control text-right col-md-2",index:3).button.span(class:"glyphicon glyphicon-pencil")}
element(:acc_time_est){|b| b.div(class:"Select-menu-outer").div(id:"react-select-3--list").div(text:"Eastern Time Zone (US - New York)")}
element(:acc_time_clk){|b| b.div(class:"Select Select--single is-clearable is-searchable").div(class:"Select-control")}
element(:acc_timesave){|b| b.div(class:"text-right col-sm-12",index:3).button(text:"Save")}
  element(:timezone_datatoolpage){|b| b.div(class:"_2e1y71LniLtHcs0VXPkB59-downloadCSVPanel-module-timezone-msg").strong.text}
element(:export_btn){|b| b.ul(class:"eFmADOgQMfqcJrEIjuKm_-itemList-module-list").li(index:0).div(class:"LrVdZVdNzsIzZTpa04DWA-itemPanel-module-item-panel").div(class:"_2metuZ7-3dsLOkTe8DiQ2o-itemPanel-module-section").div(class:"_1EziSUWUj0iwneEcM9alWI-itemPanel-module-section-body row").div(class:"col-sm-3").button(class:"btn btn-info")}
element(:time_zone){|timezone,b| b.div(class:"Select-menu-outer").div(id:"react-select-3--list").div(text:timezone)}
end