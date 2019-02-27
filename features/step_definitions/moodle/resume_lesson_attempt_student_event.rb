Given(/^Resumed a Lesson Attempt for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @lessonId = configatron.lessonId
  @shortAnswer = 'at_short_answer'+@currnetTimeStamp.to_s

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

  @browser.goto(configatron.moodleURL+'/mod/lesson/view.php?id='+@lessonId)
  sleep(10)

  on SubmitAnswersPage do |page|
    page.short_answer_txt.set @shortAnswer
    page.submit_btn_clk
    moodle_logout
    @username = configatron.autoStudentUsername
    @password = configatron.autoStudentPassword
    log_in_moodle(@username,@password)
    @browser.goto(configatron.moodleURL+'/mod/lesson/view.php?id='+@lessonId)
    sleep(20)
    @resumeLessonAttemptStartTimeStamp = Time.new.to_i * 1000
    page.resume_lesson_link.click
  end
end

When(/^The Lesson attempt got successfully resumed by student$/) do

  on SubmitAnswersPage do |page|
    page.submit_btn.exists?.should be_true
  end
  sleep(20)
  @resumeLessonAttemptEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for Resume Lesson Attempt should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @resumeLessonAttemptStartTimeStamp
  @endTimeStamp = @resumeLessonAttemptEndTimeStamp

  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Then(/^An Event for Resume Lesson Attempt should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 6

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Resumed' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Resume Lesson Attempt CSV \['Action'\] Column Value = 'Resumed'$/) do
  @latest_record['Action'].should == 'Resumed'
end

And(/^Resume Lesson Attempt CSV \['Page'\] Column Value = 'lesson_timer'$/) do
  @latest_record['Page'].should == 'lesson_timer'
end

And(/^Resume Lesson Attempt CSV \['Activity Type'\] Column Value = 'lesson'$/) do
  @latest_record['Activity Type'].should == 'lesson'
end

And(/^Resume Lesson Attempt CSV \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedlessonname
end

And(/^Resume Lesson Attempt CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Resume Lesson Attempt should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 6

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Resumed' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Resume Lesson Attempt Tableau \['Action'\] Column Value = 'Resumed'$/) do
  @newest_record['Action'].should == 'Resumed'
end

And(/^Resume Lesson Attempt Tableau \['Page'\] Column Value = 'lesson_timer'$/) do
  @newest_record['Page'].should == 'lesson_timer'
end

And(/^Resume Lesson Attempt Tableau \['Activity Type'\] Column Value = 'lesson'$/) do
  @newest_record['ActivityType'].should == 'lesson'
end

And(/^Resume Lesson Attempt Tableau \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedlessonname
end

And(/^Resume Lesson Attempt Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
