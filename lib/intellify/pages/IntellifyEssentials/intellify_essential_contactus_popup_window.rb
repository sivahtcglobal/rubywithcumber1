class IntellifyEssentialcontactus < BasePage

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
element(:help_element){|b| b.h1(text:"Help Central")}
element(:logout){|b| b.span(class:"glyphicon glyphicon-log-out")}
element(:login_view){|b| b.div(class:"fw4BQEBU-6Kg9B1ZJkNoM-nonRequiredAuthView-module-logo")}
element(:contactus_icon){|b| b.a.span(class:"glyphicon glyphicon-comment")}
element(:contactus_username){|b| b.iframe(id:"webWidget").div(class:"src-component-field-Field-container src-styles-components-Form-Form-fieldContainer ").input(name:"name").value}
element(:contactus_email){|b| b.iframe(id:"webWidget").div(class:"src-component-field-Field-container src-styles-components-Form-Form-fieldContainer ",index:1).input(name:"email").value}
element(:contactus_textarea){|b| b.iframe(id:"webWidget").div(class:"src-component-field-Field-container src-styles-components-Form-Form-fieldContainer ",index:2).textarea(name:"description")}
element(:send_btn){|b| b.iframe(id:"webWidget").div(class:"ButtonGroup u-textRight").input(type:"submit")}
element(:response_image){|b| b.iframe(id:"webWidget").span(class:"Icon Icon--tick src-component-submitTicket-SubmitTicket-notifyIcon u-inlineBlock u-posRelative u-marginTL u-userFillColor u-userTextColor")}
element(:response_close){|b| b.iframe(id:"webWidget").span(class:"Icon Icon--close u-textInheritColor")}
element(:cancel_btn){|b| b.iframe(id:"webWidget").div(class:"src-component-button-ButtonGroup-container src-styles-components-Button-ButtonGroup src-component-button-ButtonGroup-buttonRight u-textRight").div(class:"src-component-button-ButtonSecondary-button src-styles-components-Button-c-btn src-styles-components-Button-c-btn--medium src-styles-components-Button-c-btn--secondary ")}

end