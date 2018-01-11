Given(/^Login with valid Liass Admin User-Delete Datasource$/) do
  @username= configatron.essLDAPusername
  @password= configatron.essLDAPpassword
  log_in_intellifyessential(@username,@password)

end

And(/^Verify the Created Data Source$/) do
  on IntellifyEssentialDatasourcePage do |page|
  page.data_source.wait_until_present
  page.data_source.click
  page.canvas_image.wait_until_present
  page.canvas_image.exists?.should be true
  page.canvas_name.should == 'Canvas'
  page.canvas_version.should == 'Connector Version 1.0.9'
  page.canvas_status.should == 'Status: Paused'
  page.config_canvas.exists?.should be true
    end
end

Then(/^Click on the Delete Icon to Delete the Data Source$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.delete_datasource.click
    sleep(5)
    page.delete_popup.click
    sleep(20)
    page.logout_btn.click
  end
end

Then(/^Click on the Delete Icon to Delete the Moodle Data Source$/) do
  on IntellifyEssentialDatasourcePage do |page|
    sleep(10)
    page.moodle_delete.click
    sleep(5)
    page.delete_popup.click
    sleep(10)
    page.logout_btn.click
  end
end