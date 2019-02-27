Given(/^Uninstall, Reinstall then Configure the Plugin$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @hostName = configatron.workbenchHostName
  @apiKey = configatron.workbenchApiKey
  @sensorId = configatron.workbenchSensorId

  @baseDir = File.absolute_path "./"
  filename = Dir.glob("#{@baseDir}/lib/intellify/support_files/moodle_plugins/*.zip").max_by {|f| File.mtime(f)}
  puts filename

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @admin_username = configatron.autoAdminUsername
      @admin_password = configatron.autoAdminPassword
      log_in_moodle(@admin_username,@admin_password)
    end unless page.automation_site_admin.exists?
  end

  @browser.goto(configatron.moodleURL+'/admin/plugins.php?updatesonly=0&contribonly=1')

  on HistoricalDataPage do |page|
    if ENV['VERSION'] == "new"
      #Uninstall Plugin
      page.uninstall_plugin_link.click
      page.confirm_uninstall_continue_btn.click if page.confirm_uninstall_continue_btn.exists?
      page.confirm_remove_plugin_folder_btn.click
      page.upgrade_moodle_database_btn.click

      #Install Plugin
      @browser.goto(configatron.moodleURL+'/admin/tool/installaddon/index.php')

      sleep(5)
      page.select_files_link.click
      sleep(3)
      page.upload_files_link.click
      sleep(3)
      @browser.file_field(:id,//).set(filename)
      page.upload_files_btn.click
      sleep(3)
      page.install_plugin_btn.click
      sleep(3)
      page.continue_btn.click
      sleep(3)
      if page.upgrade_moodle_database_btn.exists?
        page.upgrade_moodle_database_btn.click
      else
        @browser.goto(configatron.moodleURL)
        page.upgrade_moodle_database_btn.click
      end
      sleep(3)
      page.upgrade_to_new_version_continue_btn.click

      #Configure Plugin
      page.host_name_txt.send_keys @hostName
      page.api_key_txt.send_keys @apiKey
      page.sensor_id_txt.send_keys @sensorId
      page.debugging_chkbox.click
      page.batch_size_txt.click
      page.batch_size_txt.send_keys [:control, 'a']
      page.batch_size_txt.send_keys '30'

      page.save_changes_btn_clk

      #Enable the Plugin
      @browser.goto(configatron.moodleURL+'/admin/plugins.php?updatesonly=0&contribonly=1')
      page.settings_gear_link_clk
      page.eye_symbol_disable.click
    else
      @browser.goto(configatron.moodleURL+'/admin/settings.php?section=managelogging')
    end
  end
end

When(/^Configuration saved successfully$/) do

  on HistoricalDataPage do |page|
    page.eye_symbol_enable.attribute_value('alt') == 'Disable'
  end
  sleep(10)
  moodle_logout
end

Then(/^Course Entities for Users, Courses and Course Categories should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  if ENV['VERSION'] == "new"
    puts @hits
    fail "historical data not flowing" if @hits == 0
  else
    puts @hits
    @hits.should == 0
  end
end
