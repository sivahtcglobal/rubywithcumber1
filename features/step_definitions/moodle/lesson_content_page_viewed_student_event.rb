Given(/^Lesson Content Page Viewed for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @lessonId = configatron.lessonId
  @shortAnswer = 'at_short_answer'+@currnetTimeStamp.to_s
  @contentPageTitle = 'at_content_page_title'+@currnetTimeStamp.to_s

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

  @browser.goto(configatron.moodleURL+'/mod/lesson/edit.php?id='+@lessonId)

  on CreateAndUpdateQuestionPage do |page|
    page.action_select.select 'Add a content page'

    page.page_title_txt.set @contentPageTitle
    page.page_content_editor.send_keys 'CP1'
    page.answer1_content_txt.send_keys 'CP1'

    page.add_question_page_btn_clk
    moodle_logout
  end

  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)

  @browser.goto(configatron.moodleURL+'/mod/lesson/view.php?id='+@lessonId)

  on SubmitAnswersPage do |page|
    page.restart_lesson_btn_clk if page.restart_lesson_btn.exists?
    page.short_answer_txt.set @shortAnswer
    sleep(7)
    @lessonContentPageViewedStartTimeStamp = Time.new.to_i * 1000
    sleep(3)
    page.submit_btn_clk
  end

end

When(/^The Lesson Content Page successfully viewed by student$/) do

  on CourseItemPage do |page|
    page.lesson_content_page_txt.text.should == @contentPageTitle
  end
  configatron.content_page_id = get_item_id()
  sleep(15)
  @lessonContentPageViewedEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for Lesson Content Page Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @lessonContentPageViewedStartTimeStamp
  @endTimeStamp = @lessonContentPageViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.target.extensions.moduleType\":\"lesson_content_page\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['target'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Frame'$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Frame'
end

And(/^\['event'\]\.\['target'\]\.\['name'\] = Provided Content Page Name$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['name'].should == @contentPageTitle
end

And(/^\['event'\]\.\['target'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson_content_page'$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['extensions']['moduleType'].should == 'lesson_content_page'
end

Then(/^An Event for Lesson Content Page Viewed should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 4

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Navigated To' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Lesson Content Page Viewed CSV \['Action'\] Column Value = 'Navigated To'$/) do
  @latest_record['Action'].should == 'Navigated To'
end

And(/^Lesson Content Page Viewed CSV \['Page'\] Column Value = 'lesson'$/) do
  @latest_record['Page'].should == 'lesson'
end

And(/^Lesson Content Page Viewed CSV \['Activity Type'\] Column Value = 'lesson'$/) do
  @latest_record['Activity Type'].should == 'lesson'
end

And(/^Lesson Content Page Viewed CSV \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @latest_record['Activity Name'].should == configatron.updatedlessonname
end

And(/^Lesson Content Page Viewed CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Lesson Content Page Viewed should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 4

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Navigated To' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Lesson Content Page Viewed Tableau \['Action'\] Column Value = 'Navigated To'$/) do
  @newest_record['Action'].should == 'Navigated To'
end

And(/^Lesson Content Page Viewed Tableau \['Page'\] Column Value = 'lesson'$/) do
  @newest_record['Page'].should == 'lesson'
end

And(/^Lesson Content Page Viewed Tableau \['Activity Type'\] Column Value = 'lesson'$/) do
  @newest_record['ActivityType'].should == 'lesson'
end

And(/^Lesson Content Page Viewed Tableau \['Activity Name'\] Column Value = Provided Lesson Name$/) do
  @newest_record['ActivityName'].should == configatron.updatedlessonname
end

And(/^Lesson Content Page Viewed Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
