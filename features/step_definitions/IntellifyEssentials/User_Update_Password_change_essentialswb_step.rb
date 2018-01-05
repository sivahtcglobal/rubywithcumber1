Given(/^login to with Valid credentials-User Update$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page -User Update$/) do
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

Then(/^click Account setting tab-User Update$/) do
  on IntellifyEssentialUserCreationPage do |page|
    page.acc_setting.click
    page.acc_sett_element.exists?.should be true
  end
end


Then(/^Update Create Non Admin User as Admin user$/) do
  on IntellifyEssentialUserCreationPage do |page|
    page.user_info.click
    sleep(5)
    row = 0
    until page.table_element(row) == 'Essentialuser'
      puts row
      row += 1
    end
    puts row
    page.table_element_edit(row).click
    page.first_name.wait_until_present
    page.first_name.set 'Essentialuser1'
    page.last_name.set 'Last1'
    page.email_id.set 'Essentials1@gmail.com'
    page.role.select 'Administrator'
    page.user_save.click
    sleep(10)
    page.table_element_changepassword(row).click
    page.new_password.wait_until_present
    page.new_password.set 'Essentialuser@1'
    page.confirm_password.set 'Essentialuser@1'
    page.user_save.click
  end
  end

Then(/^Change User Role as Non Admin user$/) do
  on IntellifyEssentialUserCreationPage do |page|
    sleep(10)
    row = 0
    until page.table_element(row) == 'Essentialuser1'
      puts row
      row += 1
    end
    puts row
    page.table_element_edit(row).click
    sleep(10)
    page.role.select 'Standard User'
    page.user_save.click
    sleep(15)
    page.logout.click
    end
end

