class UserprofileUpdate < BasePage

page_url configatron.essentialhomepageURL
element(:pagetitle){|b|b.span(class:"_3ILNGsKIzj4SU7XiRS-pKx-header-module-navbar-header navbar-brand").span(class:"_1rpdSsVTmLmvpUI8wQE6Fu-header-module-title").text}
element(:error) {|b| b.div.h4(text:"There was a problem logging in")}
element(:data_source){|b| b.a(text:"Data Sources")}
element(:acc_setting){|b| b.a(text:"Account Settings")}
element(:help){|b| b.a(text:"Help?")}
element(:data_tool){|b| b.a(text:"Data Tools")}
element(:username){|b| b.ul(class:"_3WwviMrlQll24Rq75UxEZ2-header-module-user nav nav-stacked navbar-nav").li.a.text}
element (:logout){|b| b.span(class:"glyphicon glyphicon-log-out")}
element (:login_view){|b| b.div(class:"fw4BQEBU-6Kg9B1ZJkNoM-nonRequiredAuthView-module-logo")}
element(:forgot_link) { |b| b.button(text:"forgot password?") }
element(:reset_username) {|b| b.text_field(id:"usernameOrEmail")}
element(:send_link_btn){|b| b.div(class:"_2V349K2IL13-_9_kYF5hig-forgotPasswordForm-module-form-options").button(text:"Send Reset Link",index:0)}
element(:alert_message){|b| b.div(class:"ipKtDUSTtSL3iJzop-as5-forgotPasswordForm-module-form-alerts alert alert-success alert-dismissable").p.text}
element(:user_profileedt){|b| b.ul(class:"dropdown-menu").li(index:0).a}
element(:user_passchng){|b| b.ul(class:"dropdown-menu").li(index:1).a}
element(:first_name){|b| b.text_field(id:"firstName")}
element(:last_name){|b| b.text_field(id:"lastName")}
element(:email_id){|b| b.text_field(id:"email")}
element(:newpassword){|b| b.text_field(id:"newPassword")}
element(:confirmpassword){|b| b.text_field(id:"confirmPassword")}
element(:save_user){|b| b.div(class:"modal-footer").button(text:"Save")}
element(:username_clk){|b| b.ul(class:"_3WwviMrlQll24Rq75UxEZ2-header-module-user nav nav-stacked navbar-nav").li.a}
end