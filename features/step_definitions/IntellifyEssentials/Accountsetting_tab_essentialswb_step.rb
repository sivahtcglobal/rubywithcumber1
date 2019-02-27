Given(/^login to with Valid credentials-Account setting tab$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
When(/^Verify element Present in the home page -Account setting tab$/) do
  on IntellifyEssentialAccSettingPage do |page|
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

Then(/^click Account setting tab$/) do
  on IntellifyEssentialAccSettingPage do |page|
    page.acc_setting.click
  end
end

And(/^Verify element in Account setting Page$/) do
  on IntellifyEssentialAccSettingPage do |page|
    page.acc_sett_element.exists?.should be_true
    page.acc_view.exists?.should be_true
    sleep(5)
    page.org_edit.click
    page.org_name_ip.set 'EssentialsQAorg'
    page.org_address_ip.set 'Boston'
    page.org_save.click
    sleep(10)
    page.acc_con_edit.click
    page.acc_name_ip.set 'EssentialsAccUser'
    page.acc_title_ip.set 'EssentialAcc'
    page.acc_email_ip.set 'EssentialsAcc@gmail.com'
    page.acc_contact_ip.set '324525461'
    page.acc_save.click
    sleep(10)
    page.tech_con_edit.click
    page.tech_name_ip.set 'EssentialsTechUser'
    page.tech_title_ip.set 'EssentialTech'
    page.tech_email_ip.set 'EssentialsTech@gmail.com'
    page.tech_contact_ip.set '323656465'
    page.tech_save.click
    sleep(5)
    page.logout.click
  end
end


