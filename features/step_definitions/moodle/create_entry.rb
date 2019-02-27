Given(/^Created a New Entry for Database Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Entry for Database for #{@courseId}"
  @databaseName = configatron.databasename unless configatron.databasename == nil
  @database_id = configatron.database_id unless configatron.database_id == nil
  @entryName = 'addEntry' + @currnetTimeStamp.to_s
  configatron.entryname = @entryName

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoStudentUsername
      @password = configatron.autoStudentPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Student.exists? && page.automation_site_Student.text.include?(configatron.autoStudentUsername))
  end
  @browser.goto(configatron.moodleURL+'/mod/data/view.php?id=' + @database_id.to_s)

  on CourseDatabaseEntryPage do |page|
    page.add_entry_link.wait_until_present
    page.add_entry_link.click
    page.new_entry_name_txt.send_keys @entryName
    page.color_chkbox.click
    page.entry_saveandview_btn.click
  end
end

When(/^The New Entry for Database Page Got successfully created$/) do

  on CourseDatabaseEntryPage do |page|
    page.fullname.wait_until_present
    page.fullname.text.should == @entryName
  end

  configatron.database_entry_id = get_item_id()
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for New Entry for Database Page should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @startTimeStamp = @currnetTimeStamp


  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"


  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'data'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'data'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'data_record'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'data_record'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'data'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'data'
end
