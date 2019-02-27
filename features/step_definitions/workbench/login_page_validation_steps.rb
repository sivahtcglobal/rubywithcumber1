#Empty Login Validation
Given (/^Attempt to Login with empty Login credentials$/) do
  @InvalidUserName = ''
  #Login into Workbench without Credentials
  log_in('','')

end

#Invalid Login Validation
Given (/^Attempt to Login with Invalid Login credentials$/) do

  #Login into Workbench with a valid Credentials
  log_in(@InvalidUserName,'InvalidPassword@1')

end

Then(/^Verify Failed Login Alert Message gets displayed$/) do
  on IntellifyLoginPage do |page|

    page.login_alert_errorMsg.wait_until_present
    page.login_alert_errorMsg.text.should include '×',"Login failed for #{@InvalidUserName}. Please check your username and password and try again.",'1 alert(s)'

  end
end

When (/^Should not get logged in to the Home Page$/) do
  on WorkbenchHomepage do |page|

    page.sign_out.visible?.should be_false
    page.image_intellify.visible?.should be_false

  end
end

#Valid Login Validation
Given(/^Attempt to Login as Valid Org Admin Credentials$/) do
  @username= configatron.workbenchAdminUsername
  @password= configatron.workbenchAdminPassword

  #Login into Workbench with a valid Credentials
  log_in(@username,@password)
end

When(/^It should Successfully login to the Workbench$/) do

  on WorkbenchHomepage do |page|
    page.sign_out.wait_until_present
    page.sign_out.visible?.should be_true
    page.image_intellify.visible?.should be_true

  end
end

