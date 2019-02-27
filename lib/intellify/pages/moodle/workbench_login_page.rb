class WorkbenchLoginPage < BasePage

  @workbenchURL = configatron.workbenchURL
  page_url @workbenchURL

  expected_element :workbench_login_btn,30

  #Workbench Login Page Elements
  element(:workbench_username) { |b| b.input(name: "username") }
  element(:workbench_password){ |b|b.input(name:"user.password")}
  element(:workbench_login_btn){ |b|b.input(value:"Login")}

end
