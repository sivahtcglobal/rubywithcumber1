Given(/^login to with Valid credentials-Data Flow Pause$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
When(/^Verify element Present in the home page-Data Flow Pause$/) do
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

Then(/^click data source tab-Data Flow Pause$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source.click
  end
end

And(/^Verify element in data source Page-Data Flow Pause$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source_element.exists?.should be_true
  end
end


And(/^Pause the Data flow into the stream$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.canvas_image.exists?.should be_true
    page.canvas_name.should == 'Canvas'
    page.canvas_version.should == 'Connector Version 0.1'
    page.canvas_status.should == 'Status: Running'
    page.pause_btn.click
    sleep(15)
    page.logout_btn.click
  end
  end