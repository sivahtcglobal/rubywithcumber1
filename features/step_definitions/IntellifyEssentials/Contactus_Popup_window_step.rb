Given(/^login to intellify essential With Valid username and password-contactus Popup$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify all element in the home page-contactus Popup$/) do
  on IntellifyEssentialcontactus do |page|
    page.data_source.wait_until_present
    page.pagetitle.should == "Intellify Essentials"
    page.element(:xpath=>"//span/img").visible?.should be true
    page.data_source.exists?.should be true
    page.acc_setting.exists?.should be true
    page.help.exists?.should be true
    page.data_tool.exists?.should be true
    page.username.should == 'Welcome EssentialsAdmin user'
  end
end

Then (/^Click on Contactus Icon and Validate the element$/) do
  on IntellifyEssentialcontactus do |page|
    page.contactus_icon.click
    sleep(3)
    page.contactus_username.should == 'EssentialsAdmin user'
    page.contactus_email.should == 'email@gmail.com'
    page.cancel_btn.click
    sleep(10)
    page.logout.click
    end
end

