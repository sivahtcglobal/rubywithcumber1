Given(/^login to with Valid credentials-User Deletion$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page -User Deletion$/) do
  on IntellifyEssentialUserDeletionPage do |page|
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

Then(/^click Account setting tab-user Deletion$/) do
  on IntellifyEssentialUserDeletionPage do |page|
    page.acc_setting.click
    page.acc_sett_element.exists?.should be true
  end
end
Then(/^Delete the Created Non Admin User$/) do
  on IntellifyEssentialUserDeletionPage do |page|
    page.user_info.click
    sleep(5)
    row = 0
    until page.table_element(row) == 'Essentialuser1'
      puts row
      row += 1
    end
    puts row
    page.table_element_delete(row).click
    sleep(3)
    page.delete_user.click
    sleep(5)
    page.data_source.click
    page.logout.click
  end
end