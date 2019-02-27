Given(/^Instructor Update the Database Template$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @database_id = configatron.database_id
  @databaseTemplateHeader = 'Automated Database Template Header'+@currnetTimeStamp.to_s
  @databaseTemplateFooter = 'Automated Database Template Footer'+@currnetTimeStamp.to_s
  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)

  @browser.goto(configatron.moodleURL+'/mod/data/view.php?id='+@database_id.to_s)

  on CourseDatabasePage do |page|
    page.templates_link.wait_until_present
    page.templates_link.click
    page.template_header_txt.wait_until_present
    @instructorDatabaseTemplateUpdateStartTimeStamp = Time.new.to_i * 1000
    page.template_header_txt.click
    page.template_header_txt.send_keys [:control, 'a']
    page.template_header_txt.send_keys @databaseTemplateHeader

    page.template_footer_txt.click
    page.template_footer_txt.send_keys [:control, 'a']
    page.template_footer_txt.send_keys @databaseTemplateFooter

    page.templates_add_btn.click
    sleep(configatron.eventWaitTime)
    @instructorDatabaseTemplateUpdateEndTimeStamp = Time.new.to_i * 1000
  end
end

When(/^The Database Template got successfully updated by the Instructor$/) do

  on CourseDatabasePage do |page|
    page.success_msg_txt.wait_until_present
    page.success_msg_txt.text.include? 'Template saved'
  end

  moodle_logout
end

Then(/^An Event for Instructor Database Template Updated should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @instructorDatabaseTemplateUpdateStartTimeStamp
  @endTimeStamp = @instructorDatabaseTemplateUpdateEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Updated\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Updated'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Updated'
end
