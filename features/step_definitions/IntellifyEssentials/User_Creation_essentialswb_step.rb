Given(/^login to with Valid credentials-User Creation$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
When(/^Verify element Present in the home page -User Creation$/) do
  on IntellifyEssentialUserCreationPage do |page|
    page.pagetitle.visible?.should be_true
    page.element(:xpath=>"//span/img").visible?.should be_true
    page.data_source.exists?.should be_true
    # page.data_store.exists?.should be_true
    page.acc_setting.exists?.should be_true
    page.help.exists?.should be_true
    page.data_tool.exists?.should be_true
    page.username.exists?.should be_true
  end
end

Then(/^click Account setting tab-user creation$/) do
  on IntellifyEssentialUserCreationPage do |page|
    page.acc_setting.click
    page.acc_sett_element.exists?.should be_true
  end
end


Then(/^Create new User role as Admin and User$/) do
  on IntellifyEssentialUserCreationPage do |page|
    page.user_info.click
    sleep(5)
    page.new_user.click
    sleep(2)
    page.first_name.set 'Essentialuser'
    page.last_name.set 'Last'
    page.email_id.set 'Essentials@gmail.com'
    page.user_name.set 'Essentialuser'
    page.password.set 'Essentialuser@123'
    page.role.select 'EssentialsUser'
    page.add_user.click
    sleep(10)
    page.logout.click
  end
  end