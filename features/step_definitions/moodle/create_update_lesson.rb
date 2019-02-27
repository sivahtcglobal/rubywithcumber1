Given(/^Created a New Lesson for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless  configatron.courseId == nil
  puts "Creating Lesson for Course : #{@courseId}"

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

  @lessonname =  'at_lesson_'+@currnetTimeStamp.to_s
  @lessonDescription = 'Automated Lesson Description'
  @passscore = 100
  @startDate = '2017-01-01'
  @endDate = '2018-10-03'
  configatron.lessonname = @lessonname
  configatron.lessonDescription = @lessonDescription

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=lesson&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseLessonPage do |page|
    page.lesson_name_txt.set @lessonname
    page.lesson_description_editor.send_keys @lessonDescription
    page.lesson_description_chkbox.click

    page.appearance_link.click
    page.availability_link.click

    page.available_enabled_chkbox.click
    page.available_deadline_chkbox.click

    #Provide Start and End Date
    page.available_day_select.select '1'
    page.available_month_select.select 'January'
    page.available_year_select.select '2017'
    page.available_hour_select.select '08'
    page.available_minute_select.select '05'
    page.deadline_day_select.select '3'
    page.deadline_month_select.select 'October'
    page.deadline_year_select.select '2018'
    page.deadline_hour_select.select '14'
    page.deadline_minute_select.select '05'

    page.flow_control_link.click
    page.grade_link.click unless page.modgrade_type_select.visible?
    page.modgrade_type_select.select 'Scale'
    page.gradepass_txt.set 2
    page.retakes_allowed_select.select 'Yes'
    page.common_module_settings_link.click
    page.restrict_access_link.click
    page.tags_link.click unless page.lesson_tags_txt.visible?

    page.lesson_tags_txt.set 'Auto tag 1'
    page.lesson_tags_txt.send_keys :enter
    page.lesson_tags_txt.set 'Auto tag 2'
    page.lesson_tags_txt.send_keys :enter
    page.lesson_tags_txt.set 'Auto tag 3'
    page.lesson_tags_txt.send_keys :enter
    page.competencies_link.click
    @currnetTimeStamp = Time.new.to_i * 1000
    page.lesson_saveanddisplay_btn_clk

  end

end

When(/^The New Lesson Got successfully created$/) do

  on LessonDetailsPage do |page|
    # page.lesson_name_link(@lessonname).exists?.should be_true
    # @lessonLink =  page.lesson_name_parent_link(@lessonname).attribute_value('href')
    @lessonLink =  page.url
    @lessonId = @lessonLink.scan(/=(\w+)/).last
    configatron.lessonId = @lessonId[0]
    page.add_question_page_link.click

  end
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000
  on CreateAndUpdateQuestionPage do |page|
    @title = "Short answer" + @currnetTimeStamp.to_s
    configatron.title = @title
    configatron.essaytitle = @title + 'Essay'

    page.question_type_select.select 'Short answer'
    page.add_question_page_btn.click
    page.page_title_txt.set @title
    page.page_content_editor.send_keys "Automated Short answer Question Page Content"
    page.use_regular_expression_chk.click

    page.answer1_link.click unless page.answer1_content_txt.visible?
    page.answer1_content_txt.set 'Short answer Answer 1'
    page.answer1_response_editor.send_keys 'Short answer response 1'
    page.answer1_page_jump_select.select  'Next page'
    page.answer1_page_score_txt.set 10

    page.answer2_link.click unless page.answer2_content_txt.visible?
    page.answer2_content_txt.set 'Short answer Answer 2'
    page.answer2_response_editor.send_keys 'Short answer response 2'
    page.answer2_page_jump_select.select  'Next page'
    page.answer2_page_score_txt.set 10

    page.answer3_link.click unless page.answer3_content_txt.visible?
    page.answer3_content_txt.set 'Short answer Answer 3'
    page.answer3_response_editor.send_keys 'Short answer response 3'
    page.answer3_page_jump_select.select  'Next page'
    page.answer3_page_score_txt.set 10

    page.answer4_link.click unless page.answer4_content_txt.visible?
    page.answer4_content_txt.set 'Short answer Answer 4'
    page.answer4_response_editor.send_keys 'Short answer response 4'
    page.answer4_page_jump_select.select  'Next page'
    page.answer4_page_score_txt.set 10

    page.answer5_link.click unless page.answer5_content_txt.visible?
    page.answer5_content_txt.set 'Short answer Answer 5'
    page.answer5_response_editor.send_keys 'Short answer response 5'
    page.answer5_page_jump_select.select  'Next page'
    page.answer5_page_score_txt.set 10

    page.add_question_page_btn_clk

    page.action_select.select 'Question'
    page.question_type_select.select 'Essay'
    page.add_question_page_btn.click

    page.page_title_txt.set configatron.essaytitle
    page.page_content_editor.send_keys "Automated Essay Question Page Content"
    page.add_question_page_btn_clk

  end
end

Then(/^A Course Entity for New Lesson should get generated and sent to our Raw Entity Index\.$/) do

  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp


  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1

end

And(/^\['entity'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['entity'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['entity'\]\.\['name'\] = lesson name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @lessonname
end

And(/^\['entity'\]\.\['description'\] = Lesson description$/) do
  @response['hits']['hits'][0]['_source']['entity']['description'].should == @lessonDescription
end

And(/^\['entity'\]\.\['extensions'\]\.\['visible'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['visible'].should == true
end

And(/^\['entity'\]\.\['extensions'\]\.\['gradeType'\] = scale$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'scale'
end

And(/^\['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Pass Score$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 2
end

And(/^\['entity'\]\.\['extensions'\]\.\['availableFromDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['availableFromDate'].include? @startDate
end

And(/^\['entity'\]\.\['extensions'\]\.\['deadlineDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['deadlineDate'].include? @endDate
end

And(/^\['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'lesson'
end

####### Update Lesson Step Definition

Given(/^Updated the Lesson for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @lessonId = configatron.lessonId
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@lessonId.to_s+"&return=0&sr=0")
  @lessonname = configatron.lessonname + 'updated'
  configatron.updatedlessonname = @lessonname
  @passscore = 75
  @startDate = '2017-04-03'
  @endDate = '2018-10-30'
  on CourseLessonPage do |page|
    page.lesson_name_txt.set @lessonname
    page.lesson_description_editor.send_keys 'Updated'
    page.lesson_description_chkbox.click

    page.appearance_link.click
    page.availability_link.click

    # page.available_enabled_chkbox.click
    # page.available_deadline_chkbox.click

    #Provide Start and End Date
    page.available_day_select.select '3'
    page.available_month_select.select 'April'
    page.available_year_select.select '2017'
    page.available_hour_select.select '10'
    page.available_minute_select.select '15'
    page.deadline_day_select.select '30'
    page.deadline_month_select.select 'October'
    page.deadline_year_select.select '2018'
    page.deadline_hour_select.select '11'
    page.deadline_minute_select.select '25'

    page.flow_control_link.click
    page.grade_link.click
    page.modgrade_type_select.select 'Point'
    page.gradetopass_txt.set '100'
    page.gradepass_txt.set @passscore
    page.common_module_settings_link.click
    page.restrict_access_link.click
    page.tags_link.click unless page.lesson_tags_txt.visible?
    page.lesson_tags_txt.set 'Auto tag 4'
    page.lesson_tags_txt.send_keys :enter
    page.lesson_tags_txt.set 'Auto tag 5'
    page.lesson_tags_txt.send_keys :enter

    page.competencies_link.click
    page.lesson_saveandreturn_btn_clk

  end

end

When(/^The Lesson Got successfully Update$/) do
  on CourseDetailPage do |page|
    page.lesson_name_link(@lessonname).exists?.should be_true
  end
  moodle_logout
end

Then(/^A Course Entity for Update Lesson should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = lesson name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @lessonname
end

And(/^Updated \['entity'\]\.\['description'\] = Lesson description$/) do
  @response['hits']['hits'][0]['_source']['entity']['description'].should == 'Updated' + configatron.lessonDescription
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['gradeType'\]  = Point$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'point'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Pass Score$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 75
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['availableFromDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['availableFromDate'].include? @startDate
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['deadlineDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['deadlineDate'].include? @endDate
end

And(/^Lesson Tag \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[0\] = Provided First Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][0].should == 'Auto tag 1'
end

And(/^Lesson Tag \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[1\] = Provided Second Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][1].should == 'Auto tag 2'
end

And(/^Lesson Tag \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[2\] = Provided Third Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][2].should == 'Auto tag 3'
end

And(/^Updated Lesson Tag \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[3\] = Provided Fourth Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][3].should == 'Auto tag 4'
end

And(/^Updated Lesson Tag \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[4\] = Provided Fifth Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][4].should == 'Auto tag 5'
end
