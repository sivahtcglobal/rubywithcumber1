Given(/^login with Valid username and password for login page$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
Then(/^Verify the all element in homepage is displayed$/) do
  on IntellifyEssentialHomePage do |page|
    page.pagetitle.visible?.should be_true
    page.element(:xpath=>"//span/img").visible?.should be_true
    page.data_source.exists?.should be_true
    # page.data_store.exists?.should be_true
    page.acc_setting.exists?.should be_true
    page.help.exists?.should be_true
    page.data_tool.exists?.should be_true
    page.username.exists?.should be_true
    sleep(3)
    page.logout.click
  end
end
When(/^login with Invalid iusername and ipassword for login page$/) do
  @iusername= 'SuperAdmin'
  @ipassword= 'fooBar1@34'
  log_in_intellifyessential(@iusername,@ipassword)
  sleep(5)
end

Then(/^Verify the error message in login page$/) do
  on IntellifyEssentialHomePage do |page|
    page.error.visible?.should be_true
    page.element(:xpath=>"//*[text()[contains(.,'Looks like your either your user name or password was incorrect.  Please try again.')]]").visible?.should be_true
  end
end

