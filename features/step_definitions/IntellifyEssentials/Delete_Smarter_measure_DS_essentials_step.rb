Given(/^Login with valid Liass Admin User-Delete Smarter Measure DS$/) do
  @username= configatron.essLDAPusername
  @password= configatron.essLDAPpassword
  log_in_intellifyessential(@username,@password)
end

And(/^Verify the Created Smarter Measure Data Source$/) do
  on IntellifyEssentialDatasourcePage do |page|
  page.data_source.wait_until_present
  page.data_source.click
  page.smarter_img.wait_until_present
  page.smarter_img.exists?.should be true
  row = 0
  until page.smarter_name(row) == 'Smarter Measure'
    puts row
    row += 1
  end
  page.smarter_name(row).should == 'Smarter Measure'
  page.smarterconfig_btn(row).exists?.should be true
    end
end

Then(/^Click on the Delete Icon to Delete the Smarter Measure Data Source$/) do
  on IntellifyEssentialDatasourcePage do |page|
    row = 0
    until page.smarter_name(row) == 'Smarter Measure'
      puts row
      row += 1
    end
    page.send_keys :page_down
    page.sm_delete(row).click
    sleep(5)
    page.delete_popup.click
    sleep(15)
    page.logout_btn.click
  end
end