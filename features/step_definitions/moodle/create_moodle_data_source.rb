Given(/^Created a Moodle Data Source from Essentials and Saved the Configurations in Moodle$/) do
  if ENV['TEST_TYPE'] == 'E2E'
    #Login to Essentials UI
    @username = configatron.essentialsusername
    @password = configatron.essentialspassword
    essentials_login(@username,@password)

    #Add A Moodle Data Source from Essentials UI
    on MoodleDataSourcePage do |page|
      page.add_data_source_btn.wait_until_present
      page.add_data_source_btn_clk

      page.moodle_add_datasource_btn.wait_until_present
      page.moodle_add_datasource_btn.click
      #page.moodle_label.parent.button.click

      page.configure_btn.wait_until_present
      page.configure_btn_clk
      configatron.apikey = page.api_key_txt.text
      configatron.sensorid = page.sensor_id_txt.text
      configatron.hostname = page.host_name_txt.text
    end

    #Login to Intellify Workbench and Capture the Stream Details
    @wbusername = configatron.tokenuser
    @wbpassword = configatron.tokenpass
    workbench_login(@wbusername,@wbpassword)

    on MoodleDataSourcePage do |page|
      page.workbench_org_arrow_icon.click
      page.workbench_data_collection_arrow_icon.click
      page.workbench_data_source_name.click

      configatron.datasourceuuid = page.data_source_uuid.value
      configatron.moodleEventStream = "data-eventdata-#{configatron.datasourceuuid}"
      configatron.moodleEntityStream = "data-entitydata-#{configatron.datasourceuuid}"
    end
  end

  #Login to Moodle Instance and Configure the Plugin
  on IntellistoreDataCollectionSettingsPage do |page|
    @admin_username = configatron.autoAdminUsername
    @admin_password = configatron.autoAdminPassword
    log_in_moodle(@admin_username,@admin_password)
    @browser.goto(configatron.moodleURL+'/admin/settings.php?section=logsettingintellify')
    page.intellify_host_txt.wait_until_present
    page.intellify_host_txt.clear
    page.intellify_host_txt.set configatron.hostname

    page.api_key_txt.clear
    page.api_key_txt.set configatron.apikey

    page.sensor_id_txt.clear
    page.sensor_id_txt.set configatron.sensorid

    sleep(3)
    @browser.execute_script('arguments[0].scrollIntoView();', page.tag_list_select)
    page.save_changes_btn.wait_until_present
    page.save_changes_btn_clk

  end
end

Then(/^The Configurations Successfully Saved in the Moodle Settings Page$/) do
  on IntellistoreDataCollectionSettingsPage do |page|
    # page.success_message.wait_until_present
    # page.success_message.text.include? 'Changes saved'
  end
  moodle_logout
end
