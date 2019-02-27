Given(/^Deleted a Moodle Data Source from Essentials$/) do
  #Login to Essentials UI
  @username = configatron.essLDAPusername
  @password = configatron.essLDAPpassword
  essentials_login(@username,@password)

  #Delete the Moodle Data Source
  on MoodleDataSourcePage do |page|
    @browser.execute_script('arguments[0].scrollIntoView();', page.delete_data_source_btn)
    page.delete_data_source_btn.click
    page.delete_btn.click
    sleep(15)
  end
end

Then(/^Moodle Data Source Deleted Successfully$/) do
  on MoodleDataSourcePage do |page|
    page.delete_data_source_btn.exists?.should be_false
    sleep(10)
    page.logout_lnk_clk
    sleep(5)
  end
end
