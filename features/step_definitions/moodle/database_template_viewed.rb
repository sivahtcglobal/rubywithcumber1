Given(/^Instructor View the Database Template$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @database_id = configatron.database_id
  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)

  @browser.goto(configatron.moodleURL+'/mod/data/view.php?id='+@database_id)

  on CourseDatabasePage do |page|
    page.templates_link.wait_until_present
    @instructorDatabaseTemplateViewedStartTimeStamp = Time.new.to_i * 1000
    page.templates_link.click
    sleep(configatron.eventWaitTime)
    @instructorDatabaseTemplateViewedEndTimeStamp = Time.new.to_i * 1000

  end
end

When(/^The Database Template got successfully viewed by the Instructor$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.wait_until_present
    page.course_item_breadcrumb.text.include? 'List template'
  end
  moodle_logout
end

Then(/^An Event for Instructor Database Template Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @startTimeStamp = @instructorDatabaseTemplateViewedStartTimeStamp
  @endTimeStamp = @instructorDatabaseTemplateViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)
  puts @response

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'data_template'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'data_template'
end
