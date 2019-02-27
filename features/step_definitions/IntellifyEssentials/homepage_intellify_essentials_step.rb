Given(/^login to intellify essential page username and password$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
Then(/^Verify all element in the home page$/) do
  on IntellifyEssentialHomePage do |page|
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

When(/^click on the data source tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_source.click
  end
end

Then(/^Verify all element in data source tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_source_element.exists?.should be_true
  end
end

When(/^click on the data store tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_store.click
  end
end

Then(/^verify all element in data store tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_store_element.exists?.should be_true
  end
end

When(/^click on the data tools tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_tool.click
  end
end

Then(/^verify all element in the data tools$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_tool_element.exists?.should be_true
  end
end

When(/^click on the Account Settings  tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.acc_setting.click
  end
end

Then(/^verify all element in the Account Settings tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.acc_sett_element.exists?.should be_true
  end
end

When(/^click on the Help tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.help.click
  end
end

Then(/^verify all element in the help tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.help_element.exists?.should be_true
  end
end

When(/^click Refresh button on data source tab$/) do
  on IntellifyEssentialHomePage do |page|
  page.data_source.click
  page.refresh
  end
  end

Then(/^Verify the data source tab reload and stay on same page$/) do
  on IntellifyEssentialHomePage do |page|
  page.data_source_element.exists?.should be_true
    end
end

When(/^Click on the Logout icon$/) do
  on IntellifyEssentialHomePage do |page|
    page.logout.click
    sleep(5)
  end
end

Then(/^Verify the Login Page$/) do
  on IntellifyEssentialHomePage do |page|
    page.login_view.exists?.should be_true
  end
end