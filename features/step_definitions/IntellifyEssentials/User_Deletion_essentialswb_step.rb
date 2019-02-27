Given(/^login to with Valid credentials-User Deletion$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
When(/^Verify element Present in the home page -User Deletion$/) do
  on IntellifyEssentialUserDeletionPage do |page|
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

Then(/^click Account setting tab-user Deletion$/) do
  on IntellifyEssentialUserDeletionPage do |page|
    page.acc_setting.click
    page.acc_sett_element.exists?.should be_true
  end
end
Then(/^Delete the Created Non Admin User$/) do
  on IntellifyEssentialUserDeletionPage do |page|
    page.user_info.click
    sleep(5)
    row = 0
    until page.table_element(row) == 'Essentialuser'
      puts row
      row += 1
    end
    puts row
    page.table_element_delete(row).click
    sleep(3)
    page.delete_user.click
    sleep(10)
    page.logout.click
  end
end