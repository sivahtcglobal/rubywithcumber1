Given(/^login to with Valid credentials as Essential Admin-Smarter Measure$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page-Smarter Measure$/) do
  on IntellifyEssentialDatasourcePage do |page|
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

Then(/^click data source tab-Smarter Measure$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source.click
  end
end

Then(/^Verify element in data source Page-Smarter Measure$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source_element.exists?.should be true
  end
end


Then(/^Add new DataSource for organization-Smarter Measure$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.datasource_btn.wait_until_present
    page.datasource_btn.click
    page.sm_datasource.wait_until_present
    page.sm_datasource.parent.button.click
    sleep(40)
    page.logout_btn.click
  end
  end