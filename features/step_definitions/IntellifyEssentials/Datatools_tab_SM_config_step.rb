Given(/^login to with Valid credentials as Essential Admin-Smarter Measure config$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page-data tools-Smarter Measure config$/) do
  on IntellifyEssentialDatatoolsPage do |page|
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
Then(/^Click on Data Source tab Verify the created SM Data Source-Smarter Measure config$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_source.click
    page.smarter_img.wait_until_present
    page.smarter_img.exists?.should be true
  end
end
Then(/^Config the Smarter Measure Data Source$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    row = 0
    until page.smarter_name(row) == 'Smarter Measure'
      puts row
      row += 1
    end
    page.send_keys [:control, :end]
    page.smarterconfig_btn(row).click
    sleep(5)
    page.sm_username.set 'TpDmwswn2HtQLqg'
    page.sm_password.set '2Q9YE6C7BLCfHNHx3EMWT8cjX'
    sleep(5)
    page.sm_save.click
    page.sm_close.click
    sleep(10)
    page.data_tool.click
    page.data_source.click
    page.smarterstart_btn(row).wait_until_present
    page.send_keys [:control, :end]
    page.smarter_status(row).should == 'Status: Paused'
    page.smarterstart_btn(row).click
    sleep(10)
    page.smarter_status(row).should == 'Status: Running'
    sleep(5)
    page.logout.click
  end
end


