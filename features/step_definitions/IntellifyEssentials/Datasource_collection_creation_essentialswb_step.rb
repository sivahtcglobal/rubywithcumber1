Given(/^login to with Valid credentials-datasource creation$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page$/) do
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

Then(/^click data source tab$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source.click
  end
end

And(/^Verify element in data source Page$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source_element.exists?.should be true
  end
end


Then(/^Add new DataSource for organization$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.datasource_btn.wait_until_present
    page.datasource_btn.click
    page.canvas_datasource.wait_until_present
    page.canvas_datasource.parent.button.click
    sleep(20)
    page.logout_btn.click
  end
  end