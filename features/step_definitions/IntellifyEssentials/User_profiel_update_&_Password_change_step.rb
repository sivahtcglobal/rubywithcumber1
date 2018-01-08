Given(/^login to Essential UI with Valid Essential Admin Credentials$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify all element in the home page as Essential Admin$/) do
  on UserprofileUpdate do |page|
    page.data_source.wait_until_present
    page.pagetitle.should == 'Intellify Essentials'
    page.element(:xpath=>"//span/img").visible?.should be true
    page.data_source.exists?.should be true
    page.acc_setting.exists?.should be true
    page.help.exists?.should be true
    page.data_tool.exists?.should be true
    page.username.should == 'Welcome EssentialsAdmin user'
  end
end


Then(/^Edit the User Profile for Essential Admin in home page$/) do
  on UserprofileUpdate do |page|
    page.username_clk.click
    page.user_profileedt.wait_until_present
    page.user_profileedt.click
    page.first_name.wait_until_present
    page.first_name.set 'EssentialsAdmin1'
    page.last_name.set 'user1'
    page.email_id.set 'email1@gmail.com'
    sleep(3)
    page.save_user.click
    sleep(3)
    if page.alert.exists?.should be true then
      puts page.alert_message1
      sleep(10)
    end

  end
end

And(/^Change Password for Essential Admin$/) do
  on UserprofileUpdate do |page|
  page.username_clk.click
  page.user_passchng.wait_until_present
  page.user_passchng.click
  page.newpassword.wait_until_present
  page.newpassword.set 'EssentialsAdmin@2'
  page.confirmpassword.set 'EssentialsAdmin@2'
  sleep(3)
  page.save_user.click
  sleep(3)
  if page.alert.exists?.should be true then
    puts page.alert_message1
    sleep(10)
  end
    page.logout.click
  end
end

When(/^Login with Changed password and verify the User name in Home page$/) do
  on UserprofileUpdate do |page|
    @username= configatron.essusername
    @password= 'EssentialsAdmin@2'
    log_in_intellifyessential(@username,@password)
    sleep(5)
    page.username.should == 'Welcome EssentialsAdmin1 user1'
  end
end

Then(/^Reset the Profile to original state for Essential Admin$/) do
  on UserprofileUpdate do |page|
    page.username_clk.click
    page.user_profileedt.wait_until_present
    page.user_profileedt.click
    page.first_name.wait_until_present
    page.first_name.set 'EssentialsAdmin'
    page.last_name.set 'user'
    page.email_id.set 'email@gmail.com'
    page.save_user.wait_until_present
    page.save_user.click
    sleep(3)
    if page.alert.exists?.should be true then
      puts page.alert_message1
      sleep(10)
    end
    page.username_clk.click
    page.user_passchng.wait_until_present
    page.user_passchng.click
    page.newpassword.wait_until_present
    page.newpassword.set 'EssentialsAdmin@1'
    page.confirmpassword.set 'EssentialsAdmin@1'
    page.save_user.wait_until_present
    page.save_user.click
    sleep(3)
    if page.alert.exists?.should be true then
      puts page.alert_message1
      sleep(10)
    end
    page.username.should == 'Welcome EssentialsAdmin user'
    page.logout.click
  end
end