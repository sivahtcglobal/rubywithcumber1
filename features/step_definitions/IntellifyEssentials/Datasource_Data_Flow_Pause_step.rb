Given(/^login to with Valid credentials-Data Flow Pause$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page-Data Flow Pause$/) do
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

Then(/^click data source tab-Data Flow Pause$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source.click
  end
end

And(/^Verify element in data source Page-Data Flow Pause$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source_element.exists?.should be true
  end
end


And(/^Pause the Data flow into the stream$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.canvas_image.exists?.should be true
    page.canvas_name.should == 'Canvas'
    page.canvas_version.should == 'Connector Version 1.0.9'
    page.canvas_status.should == 'Status: Running'
    page.pause_btn.click
    sleep(5)
    page.pause_SMbtn.click
    sleep(15)
    page.logout_btn.click
  end
  end