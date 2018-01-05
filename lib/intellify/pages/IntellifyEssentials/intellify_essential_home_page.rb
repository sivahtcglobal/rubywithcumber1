class IntellifyEssentialHomePage < BasePage

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
element (:logout){|b| b.span(class:"glyphicon glyphicon-log-out")}
element (:login_view){|b| b.div(class:"fw4BQEBU-6Kg9B1ZJkNoM-nonRequiredAuthView-module-logo")}
element(:forgot_link) { |b| b.button(text:"forgot password?") }
element(:reset_username) {|b| b.text_field(id:"usernameOrEmail")}
  element(:send_link_btn){|b| b.div(class:"_2V349K2IL13-_9_kYF5hig-forgotPasswordForm-module-form-options").button(text:"Send Reset Link",index:0)}
  element(:alert_message){|b| b.div(class:"ipKtDUSTtSL3iJzop-as5-forgotPasswordForm-module-form-alerts alert alert-success alert-dismissable").p.text}
  element(:username_frg){|b|b.text_field(id:"usernameOrEmail")}
  element(:reset_link){|b| b.button(text:"Send Reset Link")}
  element(:failure_alert){|b| b.div(class:"alert sc-hMqMXs gOTLLH alert alert-danger alert-dismissable").h4}
element(:failure_alert1){|b| b.div(class:"alert sc-hMqMXs gOTLLH alert alert-danger alert-dismissable").p}
element(:success_alert){|b| b.div(class:"alert sc-hMqMXs gOTLLH alert alert-success alert-dismissable").p.text}
element(:login_button) { |b| b.button(text: "Login") }
end