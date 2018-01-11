Given(/^login to with Valid credentials as Essential Admin\-Moodle$/) do
  #Login to Essentials UI
  @username = configatron.essusername
  @password = configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(10)
end

And(/^Verify element Present in the home page\-Moodle$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source.wait_until_present
    page.pagetitle.should == 'Intellify Essentials'
    page.element(:xpath=>"//span/img").visible?.should be true
    page.data_source.exists?.should be true
    page.data_tool.exists?.should be true
    page.acc_setting.exists?.should be true
    page.help.exists?.should be true
    page.username.should == 'Welcome EssentialsAdmin user'
  end
end

Then(/^click data source tab\-Moodle$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source.click
  end
end

Then(/^Add new DataSource for organization\-Moodle$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.datasource_btn.click
    sleep(5)
    page.moodle_label.parent.button.click
    sleep(10)
  end
end

Then(/^Verify element in data source Page\-Moodle$/) do
  on IntellifyEssentialDatasourcePage do |page|
    page.data_source_element.exists?.should be true
    @browser.execute_script('arguments[0].scrollIntoView();', page.moodle_img)
    sleep(10)
    page.moodle_img.parent.parent.button.click
    page.module_header.text.include? 'Moodle'
    page.instructions_header_txt.text.should == 'Follow the step by step instructions below to configure your Moodle Intellify Sensor Plugin:'
    page.instructions_steps_txt.text.include? 'Download the Intellify Sensor for Moodle'
    page.instructions_steps_txt.text.include? 'Login as a Moodle Administrator or contact your LMS Administrator.'
    page.instructions_steps_txt.text.include? 'Go to Site Administration > Plugins > Install Add-ons.'
    page.instructions_steps_txt.text.include? 'Click choose a file and upload the Intellify Sensor Plugin to your Moodle instance.'
    page.instructions_steps_txt.text.include? 'Click Install plugin from the ZIP file, leaving all other settings at their default.'
    page.instructions_steps_txt.text.include? 'Go to Site Administration > Plugins > Plugins Overview and search for the IntelliStore plugin.'
    page.instructions_steps_txt.text.include? 'Enter the Essentials URL, along with the API key and Sensor ID shown here to configure the Intellify Sensor Plugin.'
    page.instructions_steps_txt.text.include? 'Select the courses that will be part of the Essentials data collection.'
    page.api_label.text.should == 'API Key'
    page.sensor_id_label.text.should == 'Sensor ID'
    page.host_label.text.should == 'Host Field'
    page.provider_name_label.text.should == 'Provider Name'
    page.provider_name_txt.value.should == 'Moodle'
    page.support_name_label.text.should == 'Support'
    page.support_module_help_link.text.should == 'Need more help? Click to see more documentation'
    sleep(5)
    page.logout_btn.click
  end
end
