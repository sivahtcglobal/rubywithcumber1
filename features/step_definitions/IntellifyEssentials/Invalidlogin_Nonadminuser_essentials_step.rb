Given(/^login with Valid username and password for NonAdmin user$/) do
  @username= configatron.essNonAdminusername
  @password= configatron.essNonAdminchangepassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify the all element in homepage for NonAdmin user$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_tool_element.wait_until_present
    page.pagetitle.should == 'Intellify Essentials'
    page.element(:xpath=>"//span/img").visible?.should be true
    page.nonadmin_usernamechange.exists?.should be true
    page.data_tool_element.exists?.should be true
  end
end
When(/^login with Invalid iusername and ipassword for NonAdmin user$/) do
  @iusername= configatron.essNonAdminusername
  @ipassword= configatron.essNonAdminpassword
  log_in_intellifyessential(@iusername,@ipassword)
  sleep(5)
end

And(/^Verify the error message for NonAdmin user$/) do
  on IntellifyEssentialHomePage do |page|
    page.element(:xpath=>"//*[text()[contains(.,'Looks like your either your user name or password was incorrect.  Please try again.')]]").visible?.should be true
  end
end

