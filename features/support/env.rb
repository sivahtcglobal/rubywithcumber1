$: << File.dirname(__FILE__)+'/../../lib'

require 'intellify'
require 'csv'
require 'json'

World Foundry
World StringFactory
World DateFactory
World Workflows

$test_site = configatron.workbenchURL
$test_site = ENV['TEST_SITE'] unless ENV['TEST_SITE'] == nil
$tempHash = Array.new

browser = nil
browsertype = 'CHROME'
browsertype = ENV['BROWSER'] unless ENV['BROWSER'] == nil
headless = false
headless = ENV['HEADLESS'] unless ENV['HEADLESS'] == nil

#Skipping of DataCollector tests on Smoketest Failer
      skipCollectorTests = false

      After('@smoketest') do |scenario|
        if scenario.failed? then
          skipCollectorTests = true
        end
      end

      Before('@collectorAPITest') do
        if skipCollectorTests == true then
          skip_this_scenario
        end
      end

Watir.default_timeout = 120


case browsertype

  #Execute the Test in CHROME Browser
  when 'CHROME' then
    prefs = {
        :profile=>{
            :default_content_setting_values=>{:plugins => 1},
            :content_settings=>{:plugin_whitelist => {'adobe-flash-player' => 1},
                                :exceptions => {:plugins => {'*,*'=>{:per_resource => {'adobe-flash-player' => 1}}}}}
        }
    }
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => [ "disable-save-password-bubble","disable-infobars","--enable-automation","--disable-web-security","--start-maximized"]})

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 # seconds default is 60

    #Run all the test in headless browser
    if headless == "true"

      require 'headless'
      headless = Headless.new :destroy_at_exit => false
      headless.start

      puts "Execution Started.. Initiating Browser CHROME with HEADLESS = true"


      chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","chromedriver")

      Selenium::WebDriver::Chrome.driver_path = chromedriver_path
      profile = Selenium::WebDriver::Chrome::Profile.new

      Before do
        if browser.nil?
          browser = Watir::Browser.new :chrome , :http_client => client , desired_capabilities: caps , :prefs => prefs
        end
        @browser = browser
      end

    else
      puts "Execution Started With Windows Browser CHROME with HEADLESS = false"

          chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","chromedriver.exe")
          Selenium::WebDriver::Chrome.driver_path = chromedriver_path
          profile = Selenium::WebDriver::Chrome::Profile.new

      Before do
        if browser.nil?
          browser = Watir::Browser.new :chrome , :http_client => client , desired_capabilities: caps  , :prefs => prefs
        end
        @browser = browser
      end

    end

  #Execute the Test in FireFox Browser
  when 'FF' then
    if headless
      puts "Execution Started.. Initiating Browser FireFox with HEADLESS = true"
      require 'headless'
      headless = Headless.new
      headless.start
      #at_exit do
      #  headless.destroy
      #end
      #boost timeout value
      

      #re-use browser for each scenario
      Before do

        client = Selenium::WebDriver::Remote::Http::Default.new
        client.timeout = 120 # seconds default is 60

        if browser.nil?
          browser = Watir::Browser.new :firefox , :http_client => client
          browser.window.resize_to(1140, 964)
          # else
          #   browser.window.resize_to(1440, 864)
        end
        @browser = browser
      end
    else
      puts "Execution Started.. Initiating Browser FireFox with HEADLESS = false"

      #re-use browser for each scenario
      Before do

        client = Selenium::WebDriver::Remote::Http::Default.new
        client.timeout = 120 # seconds default is 60

        if browser.nil?
          browser = Watir::Browser.new :firefox , :http_client => client
          browser.window.resize_to(1140, 964)
          # else
          #   browser.window.resize_to(1440, 864)
        end
        @browser = browser
      end

    end

end

$project = ENV['PROJECT']
$tempHash ||=[]
$featureListHash ||=[]

$feature =""
$featureStatus = "*PASS*"
$featureCount=0
$scenarioCount=0
$scenarioFailedCount=0
$overAllStatus = "*PASS*"
After do |scenario|
  # Do something after each scenario.
  # The +scenario+ argument is optional, but
  # if you use it, you can inspect status with
  # the #failed?, #passed? and #exception methods.

  if scenario.failed?
    $status = "fail"
    $overAllStatus = "`FAIL`"
    $featureStatus = "`FAIL`"
    #Calculate Scenario Failed Count
    $scenarioFailedCount +=1
  else if scenario.passed?
         $status = "pass"
       end
  end
  tempHash = {"test_name" => scenario.name, "status" => $status}

  if $scenarioCount == 0 then
    $feature = scenario.feature.name
    $featureCount = 1
  end

  #Calculate Scenario Count
  $scenarioCount += 1

  # Calculate Feature Count
  if $feature != scenario.feature.name then
    $featureListHash << $feature #+ "--"+$featureStatus
    $featureStatus = "*PASS*"
    $feature = scenario.feature.name
    $featureCount += 1
  end

  $tempHash  << tempHash

  File.open("lib/intellify/support_files/temp.json","w") do |f|
    f.write($tempHash.to_json)
  end
end

at_exit do
  #headless.destroy
  $featureListHash << $feature #+ "--"+$featureStatus

  @result = "*Project:* #{$project}\n*Environment:* #{configatron.environment}\n*Host:* #{configatron.hostname1}\n*Status:*  #{$overAllStatus}\n\n*Total No. of Features Executed:* #{$featureCount}\n*Total No. of Scenario Executed:* #{$scenarioCount}\n*Total No. of Scenarios Failed:* `#{$scenarioFailedCount}`\n\n"#*List of Features Verified*\n"

  # $featureListHash.each do |e|
  #   @result << e + "\n"
  # end

  #puts @result

  #Project Image Location
  project_image_path = File.join(Dir.pwd,"lib","intellify","support_files","moodle.jpg")

  if ENV['SLACK_INTEGRATION'] =="true" then
    # if ENV['PROJECT_NAME'] == "moodle" then
    #   client.files_upload(
    #       channels: 'qaonly',
    #       as_user: true,
    #       file: Faraday::UploadIO.new(project_image_path, 'image/jpeg'),
    #       title: $project,
    #       filename: $project,
    #       initial_comment: @result
    #   )
    # else
      Slack.configure do |config|
        config.token = configatron.slackToken
      end

      client = Slack::Web::Client.new
      client.auth_test
      client.chat_postMessage(channel: 'qaonly', text: @result, as_user: true)
    # end

  end

end
