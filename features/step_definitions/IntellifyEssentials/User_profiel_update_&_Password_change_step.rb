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
    page.first_name.set configatron.essadminnameupdate
    page.last_name.set 'user1'
    page.email_id.set 'email1@gmail.com'
    sleep(3)
    page.save_user.click
    page.alert.wait_until_present
    if page.alert.exists?.should be true then
      page.alert_message1.should == "The user #{configatron.essadminnameupdate} user1 (#{configatron.essusername}) was updated."
    elsif page.alert.exists?.should be false
      puts 'No Popup ALert'
    end
    sleep(10)
  end
end

And(/^Change Password for Essential Admin$/) do
  on UserprofileUpdate do |page|
  page.username_clk.click
  page.user_passchng.wait_until_present
  page.user_passchng.click
  page.newpassword.wait_until_present
  page.newpassword.set configatron.essadminpassupdate
  page.confirmpassword.set configatron.essadminpassupdate
  sleep(3)
  page.save_user.click
  page.alert.wait_until_present
  if page.alert.exists?.should be true then
    page.alert_message1.should == "The user's password for #{configatron.essusername} user (#{configatron.essusername}) was updated."
  elsif page.alert.exists?.should be false
    puts 'No Popup ALert'
  end
    sleep(10)
    page.logout.click
  end
end

When(/^Login with Changed password and verify the User name in Home page$/) do
  on UserprofileUpdate do |page|
    @username= configatron.essusername
    @password= configatron.essadminpassupdate
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
    page.first_name.set configatron.essusername
    page.last_name.set 'user'
    page.email_id.set 'email@gmail.com'
    page.save_user.wait_until_present
    page.save_user.click
    page.alert.wait_until_present
    if page.alert.exists?.should be true then
      page.alert_message1.should == "The user #{configatron.essusername} user (#{configatron.essusername}) was updated."
    elsif page.alert.exists?.should be false
      puts 'No Popup ALert'
    end
    sleep(10)
    page.username_clk.click
    page.user_passchng.wait_until_present
    page.user_passchng.click
    page.newpassword.wait_until_present
    page.newpassword.set configatron.esspassword
    page.confirmpassword.set configatron.esspassword
    page.save_user.wait_until_present
    page.save_user.click
    page.alert.wait_until_present
    if page.alert.exists?.should be true then
      page.alert_message1.should == "The user's password for #{configatron.essadminnameupdate} user1 (#{configatron.essusername}) was updated."
    elsif page.alert.exists?.should be false
      puts 'No Popup ALert'
    end
    sleep(10)
    page.username.should == 'Welcome EssentialsAdmin user'
    page.logout.click
  end
end