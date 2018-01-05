Given(/^login with Valid username and password for login page$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)

end
And(/^Verify the all element in homepage is displayed$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_source.wait_until_present
    page.pagetitle.should == 'Intellify Essentials'
    page.element(:xpath=>"//span/img").wait_until_present
    page.element(:xpath=>"//span/img").visible?.should be true
    page.data_source.exists?.should be true
    page.acc_setting.exists?.should be true
    page.help.exists?.should be true
    page.data_tool.exists?.should be true
    page.username.should == 'Welcome EssentialsAdmin user'
    sleep(3)
    page.logout.click
  end
end
When(/^login with Invalid iusername and ipassword for login page$/) do
  @iusername= 'SuperAdmin'
  @ipassword= 'fooBar1@34'
  log_in_intellifyessential(@iusername,@ipassword)
end

And(/^Verify the error message in login page$/) do
  on IntellifyEssentialHomePage do |page|
    sleep(5)
    page.element(:xpath=>"//*[text()[contains(.,'Looks like your either your user name or password was incorrect.  Please try again.')]]").visible?.should be true
  end
end


Then(/^Verify the forgot password link$/) do
  on IntellifyEssentialHomePage do |page|
    page.forgot_link.click
    page.username_frg.wait_until_present
   page.username_frg.set 'EssentialsAdmin'
    page.reset_link.click
    sleep(5)
    page.success_alert.should == 'Success! A reset link was sent to your email'
    page.username_frg.set 'EssentialsAdminunknown'
    page.reset_link.click
    sleep(4)
    page.failure_alert.exists?.should be true
    page.failure_alert1.exists?.should be true

  end
end