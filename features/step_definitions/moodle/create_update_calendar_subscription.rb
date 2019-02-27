Given(/^Created a New Calendar Subscription under a course$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = configatron.courseId unless configatron.courseId == nil

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoTeacherUsername
      @password = configatron.autoTeacherPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Teacher.exists? && page.automation_site_Teacher.text.include?(configatron.autoTeacherUsername))
  end

  @calendarName =  'at_calendar_name_'+@currnetTimeStamp.to_s
  @calendarURL = 'http://www.automationcalendar.com'
  configatron.calendarname = @calendarName
  configatron.calendarurl = @calendarURL

  @browser.goto(configatron.moodleURL+'/calendar/view.php?view=month')

  on ManageSubscriptionsPage do |page|
    page.manage_subscriptions_btn_clk
    sleep(3)

    page.calendar_name_txt.send_keys @calendarName
    page.import_from_select.select 'Calendar URL'
    page.calendar_url_txt.send_keys @calendarURL
    page.update_interval_select.select 'Daily'
    page.event_type_select.select 'User events'

    sleep(3)
    @startTimeStamp = Time.new.to_i * 1000
    page.add_btn_clk
  end
end

When(/^The New Calendar Subscription got successfully created$/) do
  on ManageSubscriptionsPage do |page|
    page.calendar_name_link.wait_until_present
    page.calendar_name_link.text.include? @calendarName
  end
end

Then(/^An Event for New Calendar Subscription should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Created\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'calendar_subscription'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'calendar_subscription'
end

And(/^\['event'\]\.\['extensions'\]\.\['name'\] = Provided Name$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['name'].should include configatron.calendarname
end

And(/^\['event'\]\.\['extensions'\]\.\['calendarUrl'\] = Provided Calendar URL$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['calendarUrl'].should include configatron.calendarurl
end

And(/^\['event'\]\.\['extensions'\]\.\['interval'\] = Provided Interval$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['interval'].should == '86400'
end

Given(/^Updated the existing Calendar Subscription under a course$/) do

  @startTimeStamp = Time.new.to_i * 1000
  on ManageSubscriptionsPage do |page|
    page.update_interval_select.wait_until_present
    page.update_interval_select.select 'Hourly'
    page.update_btn_clk
    sleep(configatron.eventWaitTime)
    @endTimeStamp = Time.new.to_i * 1000
  end
end

When(/^The existing Calendar Subscription got successfully updated$/) do
  on ManageSubscriptionsPage do |page|
    page.calendar_name_link.wait_until_present
    page.calendar_name_link.text.include? configatron.calendarname
    sleep(3)
    page.remove_btn_clk
  end
  moodle_logout
end

Then(/^An Event for Update Calendar Subscription should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Updated\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']

  @hits.should > 0
end

And(/^Updated \['event'\]\.\['extensions'\]\.\['interval'\] = Provided Interval$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['interval'].should == '3600'
end
