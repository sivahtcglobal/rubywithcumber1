Given(/^login to with Valid credentials-Account setting tab$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page -Account setting tab$/) do
  on IntellifyEssentialAccSettingPage do |page|
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

Then(/^click Account setting tab$/) do
  on IntellifyEssentialAccSettingPage do |page|
    page.acc_setting.click
  end
end

And(/^Verify element in Account setting Page$/) do
  on IntellifyEssentialAccSettingPage do |page|
    page.acc_sett_element.exists?.should be true
    page.acc_view.exists?.should be true
    page.org_edit.wait_until_present
    page.org_edit.click
    page.org_name_ip.set 'EssentialsQAorg'
    page.org_street_ip.set '51 Melcher St'
    page.org_city_ip.set 'Boston'
    page.org_state_clk.click
    sleep(10)
    page.org_state_ip.click
    page.org_zip_ip.set '02210'
    page.org_save.click
    sleep(10)
    page.send_keys :page_down
    page.acc_con_edit.click
    page.acc_fname_ip.set 'Essentials'
    page.acc_lname_ip.set 'AccUser'
    page.acc_title_ip.set 'EssentialAcc'
    page.acc_email_ip.set 'EssentialsAcc@gmail.com'
    page.acc_contact_ip.set '324525461'
    page.acc_save.click
    sleep(10)
    page.tech_con_edit.click
    page.tech_fname_ip.set 'Essentials'
    page.tech_lname_ip.set 'Techuser'
    page.tech_title_ip.set 'EssentialTech'
    page.tech_email_ip.set 'EssentialsTech@gmail.com'
    page.tech_contact_ip.set '323656465'
    page.tech_save.click
    sleep(10)
    page.acc_timezone_edit.click
    page.acc_time_clk.click
    sleep(5)
    page.acc_time_est.click
    sleep(4)
    page.acc_timesave.click
    sleep(10)
    page.logout.click
  end
  end

When(/^Config the Avaliable Time zone list (.*)$/) do |timezone|
  on IntellifyEssentialAccSettingPage do |page|
  page.send_keys :page_down
  page.time_zone_edit.click
  sleep(10)
  page.time_zone_clk.click
  sleep(10)
  page.time_zone(timezone).click
  sleep(5)
  page.time_zonesave.click
  sleep(5)
  end
end