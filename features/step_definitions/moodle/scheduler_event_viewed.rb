Given(/^Instructor View the Scheduler Event$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @schedulerId = configatron.scheduler_id
  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @instructorSchedulerViewedStartTimeStamp = Time.new.to_i * 1000
  sleep(5)
  @browser.goto(configatron.moodleURL+'/mod/scheduler/view.php?id='+@schedulerId)
  sleep(10)
  @instructorSchedulerViewedEndTimeStamp = Time.new.to_i * 1000
end

When(/^The Scheduler Event got successfully viewed by the Instructor$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.schedulernameupdated
  end
  moodle_logout
end

Then(/^An Event for Instructor Scheduler Event Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @instructorSchedulerViewedStartTimeStamp
  @endTimeStamp = @instructorSchedulerViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'scheduler_appointment_list'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'scheduler_appointment_list'
end

Given(/^Student View the Scheduler Event$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @schedulerId = configatron.scheduler_id
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @studentSchedulerViewedStartTimeStamp = Time.new.to_i * 1000
  sleep(5)
  @browser.goto(configatron.moodleURL+'/mod/scheduler/view.php?id='+@schedulerId)
  sleep(10)
  @studentSchedulerViewedEndTimeStamp = Time.new.to_i * 1000
end

When(/^The Scheduler Event got successfully viewed by the Student$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.schedulernameupdated
  end
  moodle_logout
end

Then(/^An Event for Student Scheduler Event Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @studentSchedulerViewedStartTimeStamp
  @endTimeStamp = @studentSchedulerViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'scheduler_booking_form'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'scheduler_booking_form'
end
