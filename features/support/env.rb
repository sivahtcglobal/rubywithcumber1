$: << File.dirname(__FILE__)+'/../../lib'

require 'intellify'

World Foundry
World StringFactory
World DateFactory
World Workflows

$test_site = configatron.workbenchURL
$test_site = ENV['TEST_SITE'] unless ENV['TEST_SITE'] == nil

browser = nil
browsertype = 'CHROME'
browsertype = ENV['BROWSER'] unless ENV['BROWSER'] == nil
headless = false
headless = ENV['HEADLESS'] unless ENV['HEADLESS'] == nil

Watir.default_timeout = 20
client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 20 # seconds default is 60

#Configure Driver with respect to the OS its currently running

if OS.windows? == true
  @chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","chrome","chromedriver_windows","chromedriver.exe")
  @firefoxdriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","firefox","geckodriver_windows","geckodriver.exe")
  @iedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","ie","IEDriverServer.exe")
  @safaridriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","safari","safari_windows","SafariDriver.safariextz")

elsif OS.linux? == true
  @chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","chrome","chromedriver_linux","chromedriver")
  @firefoxdriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","firefox","geckodriver_linux","geckodriver")

elsif OS.mac? == true
  @chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","chromedriver_mac","chromedriver")
  @safaridriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"Drivers","safari","safari_mac","SafariDriver.safariextz")

end


#Change the default download location to custom location
custom_download_path = File.join(Dir.pwd,"lib","intellify","support_files","download_files")

prefs = {
    :profile=>{
        :default_content_setting_values=>{:plugins => 1},
        :content_settings=>{:plugin_whitelist => {'adobe-flash-player' => 1},
                            :exceptions => {:plugins => {'*,*'=>{:per_resource => {'adobe-flash-player' => 1}}}}},

    },
    :download => {
        :prompt_for_download => false,
        :default_directory => "#{custom_download_path}"
    }
}


if OS.linux? == true
  require 'headless'
  headless = Headless.new #:destroy_at_exit => false
  headless.start
  puts "Using HEADLESS = true"
end


case browsertype

  when 'CHROME' then

    puts "Execution Started.. Initiating CHROME Browser"
    puts @chromedriver_path
    Selenium::WebDriver::Chrome.driver_path = @chromedriver_path
    # profile = Selenium::WebDriver::Chrome::Profile.new
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => [ "disable-save-password-bubble","disable-infobars","--enable-automation","--disable-web-security","start-maximized"]})

    #re-use browser for each scenario
    Before do
      if browser.nil?
        browser = Watir::Browser.new :chrome , :http_client => client , desired_capabilities: caps , :prefs => prefs
        browser.window.maximize
      end
      @browser = browser
    end


  when 'FF' then
    puts "Execution Started.. Initiating FireFox Browser"
    puts @firefoxdriver_path
    Selenium::WebDriver::Firefox.driver_path = @firefoxdriver_path
    Before do
      if browser.nil?
        browser = Watir::Browser.new :firefox , :http_client => client
        browser.window.maximize
      end
      @browser = browser
    end
  when 'IE' then
    puts "Execution Started.. Initiating IE Browser"
    puts @iedriver_path
    Selenium::WebDriver::IE.driver_path = @iedriver_path
    caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer(
        # platform: platform,
        :nativeEvents => false,
        javascript_enabled: true,
        enable_persistent_hover: true,
        require_window_focus: true,
    )
    Before do
      if browser.nil?
        browser = Watir::Browser.new :ie , desired_capabilities: caps , :http_client => client
        browser.window.maximize
      end
      @browser = browser
    end
  when 'SAFARI' then
    puts "Execution Started.. Initiating SAFARI Browser"

    if browser.nil?
      browser = Watir::Browser.new :safari , :http_client => client
      browser.window.maximize

    end
    @browser = browser
end


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
  $featureListHash << $feature #+ "--"+$featureStatus

  @result = "*Project:* Essentials UI Automated Test\n*Environment:* #{configatron.environment}\n*Host:* #{configatron.hostname1}\n*Status:*  #{$overAllStatus}\n\n*Total No. of Features Executed:* #{$featureCount}\n*Total No. of Scenario Executed:* #{$scenarioCount}\n*Total No. Of Scenarios Failed:* `#{$scenarioFailedCount}`\n\n*List of Features Verified*\n"

  # $featureListHash.each do |e|
  #   @result << e + "\n"
  # end

  #puts @result

  if ENV['SLACK_INTEGRATION'] =="true" then
      Slack.configure do |config|
        config.token = configatron.slackToken
      end

        client = Slack::Web::Client.new
        client.auth_test
        client.chat_postMessage(channel: 'qaonly', text: @result, as_user: true)
  end

end
