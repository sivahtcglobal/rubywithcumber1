Given(/^Launched a Lesson for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @lessonId = configatron.lessonId
  @lessonName = configatron.updatedlessonname

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

  @lessonLaunchStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/lesson/view.php?id='+@lessonId)
end

When(/^The Lesson got successfully launched by student$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.wait_until_present
    page.course_item_breadcrumb.text.include? @lessonName
  end
  sleep(configatron.eventWaitTime)
  @lessonLaunchEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Launch Lesson should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @lessonLaunchStartTimeStamp
  @endTimeStamp = @lessonLaunchEndTimeStamp

  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.@type\":\"http://purl.imsglobal.org/caliper/v1/Attempt\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'lesson'
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Started'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Started'
end

And(/^\['event'\]\.\['generated'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

And(/^\['event'\]\.\['generated'\]\.\['count'\] = 1$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['count'].should == 1
end

Then(/^An Event for Launch a Lesson should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 2

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Started' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Launch Lesson CSV \['Action'\] Column Value = 'Started'$/) do
  @latest_record['Action'].should == 'Started'
end

And(/^Launch Lesson CSV \['Page'\] Column Value = 'lesson_timer'$/) do
  @latest_record['Page'].should == 'lesson_timer'
end

And(/^Launch Lesson CSV \['Activity Type'\] Column Value = 'lesson'$/) do
  @latest_record['Activity Type'].should == 'lesson'
end

And(/^Launch Lesson CSV \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedlessonname
end

And(/^Launch Lesson CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Launch a Lesson should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 2

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Started' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Launch Lesson Tableau \['Action'\] Column Value = 'Started'$/) do
  @newest_record['Action'].should == 'Started'
end

And(/^Launch Lesson Tableau \['Page'\] Column Value = 'lesson_timer'$/) do
  @newest_record['Page'].should == 'lesson_timer'
end

And(/^Launch Lesson Tableau \['Activity Type'\] Column Value = 'lesson'$/) do
  @newest_record['ActivityType'].should == 'lesson'
end

And(/^Launch Lesson Tableau \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedlessonname
end

And(/^Launch Lesson Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Then(/^An Event for Lesson Question Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @lessonLaunchStartTimeStamp
  sleep(5)
  @endTimeStamp = @lessonLaunchEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.target.extensions.moduleType\":\"lesson_question\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['target'\]\.\['name'\] = Provided Question Title$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['name'].should == configatron.title
end

And(/^\['event'\]\.\['target'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson_question'$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['extensions']['moduleType'].should == 'lesson_question'
end

Then(/^An Event for Lesson Question Viewed should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 2

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Navigated To' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Lesson Question Viewed CSV \['Action'\] Column Value = 'Navigated To'$/) do
  @latest_record['Action'].should == 'Navigated To'
end

And(/^Lesson Question Viewed CSV \['Page'\] Column Value = 'lesson'$/) do
  @latest_record['Page'].should == 'lesson'
end

And(/^Lesson Question Viewed CSV \['Activity Type'\] Column Value = 'lesson'$/) do
  @latest_record['Activity Type'].should == 'lesson'
end

And(/^Lesson Question Viewed CSV \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedlessonname
end

And(/^Lesson Question Viewed CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Lesson Question Viewed should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 2

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Navigated To' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Lesson Question Viewed Tableau \['Action'\] Column Value = 'Navigated To'$/) do
  @newest_record['Action'].should == 'Navigated To'
end

And(/^Lesson Question Viewed Tableau \['Page'\] Column Value = 'lesson'$/) do
  @newest_record['Page'].should == 'lesson'
end

And(/^Lesson Question Viewed Tableau \['Activity Type'\] Column Value = 'lesson'$/) do
  @newest_record['ActivityType'].should == 'lesson'
end

And(/^Lesson Question Viewed Tableau \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedlessonname
end

And(/^Lesson Question Viewed Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
