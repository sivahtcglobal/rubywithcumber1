Given(/^login to with Valid credentials-User Creation$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page -User Creation$/) do
  on IntellifyEssentialUserCreationPage do |page|
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

Then(/^click Account setting tab-user creation$/) do
  on IntellifyEssentialUserCreationPage do |page|
    page.acc_setting.click
    page.acc_sett_element.exists?.should be true
  end
end


Then(/^Create new User role as Non Admin User$/) do
  on IntellifyEssentialUserCreationPage do |page|
    page.user_info.click
    sleep(10)
    page.new_user.wait_until_present
    page.new_user.click
    page.first_name.wait_until_present
    page.first_name.set 'Essentialuser'
    page.last_name.set 'Last'
    page.email_id.set 'Essentials@gmail.com'
    page.user_name.set 'Essentialuser'
    page.password.set 'Essentialuser@123'
    page.role.select 'Standard User'
    page.add_user.click
    page.alert.wait_until_present
    if page.alert.exists?.should be true then
      page.alert_message1.should == "The user #{configatron.essNonAdminusername} Last (#{configatron.essNonAdminusername}) was added."
    elsif page.alert.exists?.should be false
      puts 'No Popup ALert'
    end
    sleep(10)
    page.data_source.click
    page.logout.click
  end
  end