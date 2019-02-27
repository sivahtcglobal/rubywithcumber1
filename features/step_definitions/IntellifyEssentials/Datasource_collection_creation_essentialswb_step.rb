Given(/^login to with Valid credentials-datasource creation$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
When(/^Verify element Present in the home page$/) do
  on IntellifyEssentialDatasourcePage do |page|
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

Then(/^click data source tab$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source.click
  end
end

And(/^Verify element in data source Page$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source_element.exists?.should be_true
  end
end


And(/^Add new DataSource for organization$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.datasource_btn.click
    sleep(5)
    page.add_datasource_btn.click
    sleep(45)
    page.logout_btn.click
  end
  end