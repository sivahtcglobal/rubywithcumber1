Given(/^I am logging in as an Student in Canvas Instance$/) do
  @browser.driver.switch_to.window(@browser.driver.window_handles[0])

  visit MediaEventsloginPage do |page|
  @tokenuser = configatron.osrt_user
  @tokenpass = configatron.osrt_pass
  configatron.osrt_apitoken =  get_apitoken(configatron.osrt_host,@tokenuser,@tokenpass)
  if page.login_button.exists? == true then
  page.username.set configatron.canvas_osrt_user
  page.password.set configatron.canvas_osrt_pass
  page.login_button.click
  elsif page.login_button.exists? == false then

      on MediaEventsModulePage do |page|
    @browser.driver.switch_to.window(@browser.driver.window_handles[0])
      page.account_tab.wait_until_present
      page.account_tab.click
      page.logout.wait_until_present
      page.logout.click
       sleep(5)
      end

      visit MediaEventsloginPage do |page|
        page.username.set configatron.canvas_osrt_user
        page.password.set configatron.canvas_osrt_pass
        page.login_button.click

      end
  end
end
  end





When(/^I am Successfully logged in to the Canvas Instance and Launched the URL (.*?) and header name (.*?) for the Module (.*?)$/) do |url,header,modul|
  on MediaEventsModulePage do |page|
    page.account_tab.wait_until_present
    page.account_tab.click
    sleep(8)
    page.user_name.should == 'Autouser1'
    page.course_tab.wait_until_present
    page.course_tab.click
    page.ccc_test.wait_until_present
    page.ccc_test.click
    sleep(5)
    page.ccc_title.should == 'CCC test'
    page.module_clk.click
    sleep(5)
    configatron.module = modul
    @browser.goto url
    sleep(4)
    page.header(header).exists?
    page.launch_video.click
    end
end

When(/^I Clicked the Section (.*?) for the chaptername (.*?) and chapternumber (.*?) an event should get successfully sent to the Raw Index$/) do |sections,chaptername,chapternumber|
  on MediaEventsModulePage do |page|
    @browser.driver.switch_to.window(@browser.driver.window_handles[1])
    sleep(5)
    page.sectionElement(sections).wait_until_present
    @myth1StartTimeStamp = Time.new.to_i * 1000
    page.sectionElement(sections).click
    @chaptername = chaptername
    @chapternumber = chapternumber
    @module = configatron.module
  end
    sleep(8)
    @myth1EndTimeStamp = Time.new.to_i * 1000

    @posturl = File.join('http://',configatron.osrt_host,'/intellisearch/',configatron.osrt_intellistream,'/_search')
    @streamDelayTime = configatron.streamDelayTime
    @startTimeStamp = @myth1StartTimeStamp
    @endTimeStamp = @myth1EndTimeStamp

    @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

    @response = post_request(@posturl,@query,configatron.osrt_apitoken)
    @response.to_json
    @hits = @response['hits']['total']
    # @hits.should_not == 0
    if  @hits > 1 then
      puts @response.to_json
    elsif @hits == 1 then
      puts 'No of hits is one'
    end

  @response['hits']['hits'][0]['_source']['event']['data']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MediaEvent'
  @response['hits']['hits'][0]['_source']['event']['data']['action'].should include 'http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@id'].should == '1cfe94d27d72a5dbc969dc6ad7e911bbfdcb3ca6'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_api_domain'].should == 'intellify.instructure.com'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_course_id'].should == '21'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_user_id'].should == '48'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['tool_consumer_instance_name'].should == 'Intellify Learning'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['name'].should == 'Autouser1 '
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@id'].should == 'http://www.cccco.edu/'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['description'].should == 'CCC OSRT Web Application'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['name'].should == 'OSRT'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/VideoObject'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['action'].should == 'click'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterName'].should include"#{@chaptername}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterNumber'].should == "#{@chapternumber}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['item'].should == 'chapter'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaLocation'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaTime'].should >= '0'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['moduleId'].should == "#{@module}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['type'].should == 'media'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['name'].should == "#{@module}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['version'].should == '0.9.0'
  @response['hits']['hits'][0]['_source']['event']['data']['target']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['target']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['target']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MediaLocation'
  @response['hits']['hits'][0]['_source']['event']['data']['target']['currentTime'].should >= '0'
  @response['hits']['hits'][0]['_source']['event']['data']['target']['version'].should == '0.9.0'
  @response['hits']['hits'][0]['_source']['event']['dataVersion'].should == 'http://purl.imsglobal.org/ctx/caliper/v1p1'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

When(/^Action for (.*) for the (.*) and (.*) and (.*) and (.*), an event should get generated successfully and sent to the Raw Index$/) do |sections, action, chaptername, chapternumber, itemname|

  on MediaEventsModulePage do |page|
      @action = action
      @chaptername = chaptername
      @chapternumber = chapternumber
      @itemname = itemname
      @module = configatron.module
      page.sectionElement(sections).wait_until_present
      page.sectionElement(sections).click
      sleep(5)
      case
        when @itemname == "pause"
          page.pause.wait_until_present
          @myth1vedioStartTimeStamp = Time.new.to_i * 1000
          page.pause.click
          sleep(8)
        when @itemname == "resume"
          page.pause.wait_until_present
          page.pause.click
          sleep(5)
          page.play.wait_until_present
          @myth1vedioStartTimeStamp = Time.new.to_i * 1000
          page.play.click
          sleep(8)
        when @itemname == "restart"
          page.restart.wait_until_present
          @myth1vedioStartTimeStamp = Time.new.to_i * 1000
          page.restart.click
          sleep(8)
        when @itemname == "forward"
          page.forward.wait_until_present
          @myth1vedioStartTimeStamp = Time.new.to_i * 1000
          page.forward.click
          sleep(8)
        when @itemname == "rewind"
          page.rewind.wait_until_present
          @myth1vedioStartTimeStamp = Time.new.to_i * 1000
          page.rewind.click
          sleep(8)
        when @itemname == "slower"
          page.slower.wait_until_present
          @myth1vedioStartTimeStamp = Time.new.to_i * 1000
          page.slower.click
          sleep(8)
        when @itemname == "faster"
          page.faster.wait_until_present
          @myth1vedioStartTimeStamp = Time.new.to_i * 1000
          page.faster.click
          sleep(4)
        else
          puts "No action performed"
      end
  end

      @myth1vedioEndTimeStamp = Time.new.to_i * 1000
      @posturl = File.join('http://',configatron.osrt_host,'/intellisearch/',configatron.osrt_intellistream,'/_search')
      @streamDelayTime = configatron.streamDelayTime
      @startTimeStamp = @myth1vedioStartTimeStamp
      @endTimeStamp = @myth1vedioEndTimeStamp

      @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

      @response = post_request(@posturl,@query,configatron.osrt_apitoken)
      @response.to_json
      @hits = @response['hits']['total']
      # @hits.should_not == 0
           if  @hits > 1 then
             puts @response.to_json
           elsif @hits == 1 then
             puts 'No of hits is one'
            end


      @response['hits']['hits'][0]['_source']['event']['data']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
      @response['hits']['hits'][0]['_source']['event']['data']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MediaEvent'
      @response['hits']['hits'][0]['_source']['event']['data']['action'].should == "#{@action}"
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['@id'].should == '1cfe94d27d72a5dbc969dc6ad7e911bbfdcb3ca6'
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_api_domain'].should == 'intellify.instructure.com'
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_course_id'].should == '21'
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_user_id'].should == '48'
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['tool_consumer_instance_name'].should == 'Intellify Learning'
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['name'].should == 'Autouser1 '
      @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
      @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@id'].should == 'http://www.cccco.edu/'
      @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
      @response['hits']['hits'][0]['_source']['event']['data']['edApp']['description'].should == 'CCC OSRT Web Application'
      @response['hits']['hits'][0]['_source']['event']['data']['edApp']['name'].should == 'OSRT'
      @response['hits']['hits'][0]['_source']['event']['data']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
      @response['hits']['hits'][0]['_source']['event']['data']['object']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
      @response['hits']['hits'][0]['_source']['event']['data']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/VideoObject'
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['action'].should == 'click'
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterName'].should include"#{@chaptername}"
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterNumber'].should == "#{@chapternumber}"
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['item'].should == 'button'
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['itemName'].should == "#{@itemname}"
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaLocation'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaTime'].should >= '0'
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['moduleId'].should == "#{@module}"
      @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['type'].should == 'media'
      @response['hits']['hits'][0]['_source']['event']['data']['object']['name'].should == "#{@module}"
      @response['hits']['hits'][0]['_source']['event']['data']['object']['version'].should == '0.9.0'
      @response['hits']['hits'][0]['_source']['event']['data']['target']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
      @response['hits']['hits'][0]['_source']['event']['data']['target']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
      @response['hits']['hits'][0]['_source']['event']['data']['target']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MediaLocation'
      @response['hits']['hits'][0]['_source']['event']['data']['target']['currentTime'].should >= '0'
      @response['hits']['hits'][0]['_source']['event']['data']['target']['version'].should == '0.9.0'
      @response['hits']['hits'][0]['_source']['event']['dataVersion'].should == 'http://purl.imsglobal.org/ctx/caliper/v1p1'
      @response['hits']['hits'][0]['_source']['event']['data']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end


When(/^I Clicked the Transcript tab an event should get successfully sent to the Raw Index$/) do
  on MediaEventsModulePage do |page|
    @browser.driver.switch_to.window(@browser.driver.window_handles[1])
    sleep(10)
    @module = configatron.module
    page.transcript_tab.wait_until_present
    @myth1vedioStartTimeStamp = Time.new.to_i * 1000
    page.transcript_tab.click
    sleep(8)
  end

  @myth1vedioEndTimeStamp = Time.new.to_i * 1000
  @posturl = File.join('http://',configatron.osrt_host,'/intellisearch/',configatron.osrt_intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @myth1vedioStartTimeStamp
  @endTimeStamp = @myth1vedioEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,configatron.osrt_apitoken)
  @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  if  @hits > 1 then
    puts @response.to_json
  elsif @hits == 1 then
    puts 'No of hits is one'
  end

  @response['hits']['hits'][0]['_source']['event']['data']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/ViewEvent'
  @response['hits']['hits'][0]['_source']['event']['data']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@id'].should == '1cfe94d27d72a5dbc969dc6ad7e911bbfdcb3ca6'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_api_domain'].should == 'intellify.instructure.com'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_course_id'].should == '21'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_user_id'].should == '48'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['tool_consumer_instance_name'].should == 'Intellify Learning'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['name'].should == 'Autouser1 '
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@id'].should == 'http://www.cccco.edu/'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['description'].should == 'CCC OSRT Web Application'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['name'].should == 'OSRT'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/WebPage'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['action'].should == 'click'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterName'].should include "Title"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterNumber'].should == '1'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['item'].should == 'tab'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaLocation'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaTime'].should >= '0'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['moduleId'].should == "#{@module}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['tabName'].should == 'Transcript'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['type'].should == 'view'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['name'].should == 'Transcript'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['version'].should == '0.9.0'
  @response['hits']['hits'][0]['_source']['event']['dataVersion'].should == 'http://purl.imsglobal.org/ctx/caliper/v1p1'
end



When(/^I Clicked the Menu tab an event should get successfully sent to the Raw Index$/) do
  on MediaEventsModulePage do |page|
    @module = configatron.module
    page.menu_tab.wait_until_present
    @myth1vedioStartTimeStamp = Time.new.to_i * 1000
    page.menu_tab.click
    sleep(8)
  end

  @myth1vedioEndTimeStamp = Time.new.to_i * 1000
  @posturl = File.join('http://',configatron.osrt_host,'/intellisearch/',configatron.osrt_intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @myth1vedioStartTimeStamp
  @endTimeStamp = @myth1vedioEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,configatron.osrt_apitoken)
  @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  if  @hits > 1 then
    puts @response.to_json
  elsif @hits == 1 then
    puts 'No of hits is one'
  end

  @response['hits']['hits'][0]['_source']['event']['data']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/ViewEvent'
  @response['hits']['hits'][0]['_source']['event']['data']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@id'].should == '1cfe94d27d72a5dbc969dc6ad7e911bbfdcb3ca6'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_api_domain'].should == 'intellify.instructure.com'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_course_id'].should == '21'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_user_id'].should == '48'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['tool_consumer_instance_name'].should == 'Intellify Learning'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['name'].should == 'Autouser1 '
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@id'].should == 'http://www.cccco.edu/'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['description'].should == 'CCC OSRT Web Application'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['name'].should == 'OSRT'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/WebPage'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['action'].should == 'click'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterName'].should include "Title"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterNumber'].should == '1'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['item'].should == 'tab'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaLocation'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaTime'].should >= '0'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['moduleId'].should == "#{@module}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['tabName'].should == 'Menu'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['type'].should == 'view'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['name'].should == 'Menu'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['version'].should == '0.9.0'
  @response['hits']['hits'][0]['_source']['event']['dataVersion'].should == 'http://purl.imsglobal.org/ctx/caliper/v1p1'
end


When(/^I Clicked the Resource tab an event should get successfully sent to the Raw Index$/) do
  on MediaEventsModulePage do |page|
    @module = configatron.module
    page.resource_tab.wait_until_present
    @myth1vedioStartTimeStamp = Time.new.to_i * 1000
    page.resource_tab.click
    sleep(8)
  end

  @myth1vedioEndTimeStamp = Time.new.to_i * 1000
  @posturl = File.join('http://',configatron.osrt_host,'/intellisearch/',configatron.osrt_intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @myth1vedioStartTimeStamp
  @endTimeStamp = @myth1vedioEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,configatron.osrt_apitoken)
  @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  if  @hits > 1 then
    puts @response.to_json
  elsif @hits == 1 then
    puts 'No of hits is one'
  end

  @response['hits']['hits'][0]['_source']['event']['data']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/ViewEvent'
  @response['hits']['hits'][0]['_source']['event']['data']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@id'].should == '1cfe94d27d72a5dbc969dc6ad7e911bbfdcb3ca6'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_api_domain'].should == 'intellify.instructure.com'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_course_id'].should == '21'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_user_id'].should == '48'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['tool_consumer_instance_name'].should == 'Intellify Learning'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['name'].should == 'Autouser1 '
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@id'].should == 'http://www.cccco.edu/'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['description'].should == 'CCC OSRT Web Application'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['name'].should == 'OSRT'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/WebPage'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['action'].should == 'click'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterName'].should include "Title"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterNumber'].should == '1'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['item'].should == 'tab'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaLocation'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaTime'].should >= '0'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['moduleId'].should == "#{@module}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['tabName'].should == 'Resources'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['type'].should == 'view'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['name'].should == 'Resources'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['version'].should == '0.9.0'
  @response['hits']['hits'][0]['_source']['event']['dataVersion'].should == 'http://purl.imsglobal.org/ctx/caliper/v1p1'
end


When(/^I Clicked the Help tab an event should get successfully sent to the Raw Index$/) do
  on MediaEventsModulePage do |page|
    @module = configatron.module
    page.help_tab.wait_until_present
    @myth1vedioStartTimeStamp = Time.new.to_i * 1000
    page.help_tab.click
    sleep(8)
    @browser.driver.close
  end

  @myth1vedioEndTimeStamp = Time.new.to_i * 1000
  @posturl = File.join('http://',configatron.osrt_host,'/intellisearch/',configatron.osrt_intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @myth1vedioStartTimeStamp
  @endTimeStamp = @myth1vedioEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,configatron.osrt_apitoken)
  @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  if  @hits > 1 then
    puts @response.to_json
  elsif @hits == 1 then
    puts 'No of hits is one'
  end


  @response['hits']['hits'][0]['_source']['event']['data']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/ViewEvent'
  @response['hits']['hits'][0]['_source']['event']['data']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@id'].should == '1cfe94d27d72a5dbc969dc6ad7e911bbfdcb3ca6'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_api_domain'].should == 'intellify.instructure.com'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_course_id'].should == '21'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['custom_canvas_user_id'].should == '48'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['extensions']['tool_consumer_instance_name'].should == 'Intellify Learning'
  @response['hits']['hits'][0]['_source']['event']['data']['actor']['name'].should == 'Autouser1 '
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@id'].should == 'http://www.cccco.edu/'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['description'].should == 'CCC OSRT Web Application'
  @response['hits']['hits'][0]['_source']['event']['data']['edApp']['name'].should == 'OSRT'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@id'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/WebPage'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['action'].should == 'click'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterName'].should include "Title"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['chapterNumber'].should == '1'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['item'].should == 'tab'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaLocation'].should == "https://osrt-dev.intellify.io/oei/modules/#{@module}/story/"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['mediaTime'].should >= '0'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['moduleId'].should == "#{@module}"
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['tabName'].should == 'Help'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['extensions']['type'].should == 'view'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['name'].should == 'Help'
  @response['hits']['hits'][0]['_source']['event']['data']['object']['version'].should == '0.9.0'
  @response['hits']['hits'][0]['_source']['event']['dataVersion'].should == 'http://purl.imsglobal.org/ctx/caliper/v1p1'
end



Then(/^Logout Application$/) do
  on MediaEventsModulePage do |page|
    @browser.driver.switch_to.window(@browser.driver.window_handles[0])
    page.account_tab.wait_until_present
    page.account_tab.click
    page.logout.wait_until_present
    page.logout.click
    sleep(5)
    @browser.driver.close
  end
end