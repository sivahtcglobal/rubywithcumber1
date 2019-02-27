Given(/^Created a New Calendar Event under a course$/) do
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

  @eventTitle =  'at_calendar_event_'+@currnetTimeStamp.to_s
  @eventDescription = 'Automated Calendar Description'+@currnetTimeStamp.to_s
  configatron.eventname = @eventTitle
  configatron.eventdescription = @eventDescription

  @browser.goto(configatron.moodleURL+'/calendar/view.php?view=month')

  on CourseCalendarPage do |page|
    page.new_event_btn_clk
    sleep(3)

    page.event_type_select.select 'User'
    page.event_title_txt.set @eventTitle

    page.event_description_txt.click
    page.event_description_txt.send_keys [:control, 'a']
    page.event_description_txt.send_keys @eventDescription

    page.duration_link.click
    page.event_time_day_select.select '10'
    page.event_time_month_select.select 'March'
    page.event_time_year_select.select '2018'
    page.event_time_hour_select.select '08'
    page.event_time_minute_select.select '40'
    page.until_radio.click
    page.duration_until_day_select.select '14'
    page.duration_until_month_select.select 'March'
    page.duration_until_year_select.select '2018'
    page.duration_until_hour_select.select '04'
    page.duration_until_minute_select.select '50'

    page.repeated_events_link.click
    page.repeat_this_event_chkbx.click
    page.repeat_weekly_txt.click
    page.repeat_weekly_txt.send_keys [:control, 'a']
    page.repeat_weekly_txt.send_keys '2'

    page.save_changes_btn_clk
  end
end

When(/^The New Calendar Event got successfully created$/) do
  on CourseCalendarPage do |page|
    page.calendar_event.text.include? @eventTitle
    configatron.calendar_event_id = page.url.split('?').last.split('=').last.split('_').last
  end
end

Then(/^An Event for New Calendar Event should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Created\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 2
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Created'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Created'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'calendar'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'calendar'
end

And(/^\['event'\]\.\['extensions'\]\.\['description'\] = Provided Description$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['description'].should include configatron.eventdescription
end

And(/^\['event'\]\.\['extensions'\]\.\['title'\] = Provided Title$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['title'].should include configatron.eventname
end

Given(/^Updated the existing Calendar Event under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @calendarEventId = configatron.calendar_event_id
  @browser.goto(configatron.moodleURL+"/calendar/event.php?action=edit&id="+@calendarEventId+"&course=1")

  @eventTitle =  configatron.eventname+'updated'
  @eventDescription = configatron.eventdescription+'updated'
  configatron.eventnameupdated = @eventTitle
  configatron.eventdescriptionupdated = @eventDescription

  on CourseCalendarPage do |page|
    page.event_title_txt.click
    page.event_title_txt.send_keys [:control, 'a']
    page.event_title_txt.send_keys @eventTitle

    page.event_description_txt.click
    page.event_description_txt.send_keys [:control, 'a']
    page.event_description_txt.send_keys @eventDescription

    page.duration_link.click
    page.event_time_day_select.select '12'
    page.event_time_month_select.select 'April'
    page.event_time_year_select.select '2018'
    page.event_time_hour_select.select '09'
    page.event_time_minute_select.select '45'
    page.until_radio.click
    page.duration_until_day_select.select '16'
    page.duration_until_month_select.select 'April'
    page.duration_until_year_select.select '2018'
    page.duration_until_hour_select.select '06'
    page.duration_until_minute_select.select '55'

    page.repeated_events_link.click
    page.save_changes_btn_clk
  end
end

When(/^The existing Calendar Event got successfully updated$/) do
  on CourseCalendarPage do |page|
    page.calendar_event.text.include? @eventTitle
  end
  moodle_logout
end

Then(/^An Event for Update Calendar Event should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Updated\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 2
end

And(/^Updated \['event'\]\.\['extensions'\]\.\['description'\] = Provided Description$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['description'].should include configatron.eventdescriptionupdated
end

And(/^Updated \['event'\]\.\['extensions'\]\.\['title'\] = Provided Title$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['title'].should include configatron.eventnameupdated
end
