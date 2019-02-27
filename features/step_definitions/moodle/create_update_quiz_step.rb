Given(/^Created a New Quiz Page for a Course$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4' #Will be using the Dynamic Course Created In the previous features
  @courseId = configatron.courseId unless configatron.courseId == nil
  @quizName = 'AutoQuiz_' + @currnetTimeStamp.to_s

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

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=quiz&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CreateAndUpdateQuizPage do |page|

    #page.general_quiz_page_link.click
    page.quiz_name_txt.wait_until_present
    page.quiz_name_txt.set @quizName
    page.quiz_description_editor.send_keys 'Auto Quiz Description'
    page.quiz_description_display_chk.click
    page.timing_quiz_page_link.click unless page.quiz_timeopen_chkbox.visible?
    page.quiz_timeopen_chkbox.click
    page.quiz_timeclose_chkbox.click
    page.timeopen_day_select.select '1'
    page.timeopen_month_select.select 'January'
    page.timeopen_year_select.select '2018'
    page.timeopen_hour_select.select '08'
    page.timeopen_minute_select.select '25'
    page.timeclose_day_select.select '12'
    page.timeclose_month_select.select 'December'
    page.timeclose_year_select.select '2018'
    page.timeclose_hour_select.select '13'
    page.timeclose_minute_select.select '15'

    page.quiz_timelimit_chkbox.click
    page.quiz_timelimit_txt.set 1
    page.quiz_timelimit_unit_select.select 'days'
    page.quiz_overdue_select.select 'There is a grace period when open attempts can be submitted, but no more questions answered'

    #page.quiz_graceperiod_chkbox.click
    page.quiz_graceperiod_txt.set 1
    page.quiz_graceperiod_unit_select.select 'hours'

    page.grade_quiz_page_link.click unless page.quiz_grade_pass_txt.visible?
    page.quiz_grade_pass_txt.set 5
    page.quiz_attempts_select.select '2'
    page.quiz_grademethod_select.select 'First attempt'


    page.layout_quiz_page_link.click unless page.quiz_questionsperpage_select.visible?
    page.quiz_questionsperpage_select.select 'Every 6 questions'

    page.quiz_showmore_link.click unless page.quiz_navmethod_select.visible?
    page.quiz_navmethod_select.select 'Sequential'
    page.quiz_showless_link.click

    page.question_behaviour_quiz_page_link.click unless page.quiz_shuffleanswers_select.visible?
    page.quiz_shuffleanswers_select.select 'Yes'
    page.quiz_preferredbehaviour_select.select 'Deferred feedback'

    page.quiz_showmore_link.click unless page.quiz_canredoquestions_select.visible?
    # page.quiz_showmore_link.click unless page.quiz_canredoquestions_select.visible?
    # page.quiz_canredoquestions_select.select 'Students may redo another version of any finished question'
    # page.quiz_attemptonlast_select.select 'Yes'
    page.quiz_showless_link.click
    page.review_options_quiz_page_link.click


    page.appearance_quiz_page_link.click


    page.extra_restrictions_attempts_quiz_page_link.click


    page.overall_feedback_quiz_page_link.click


    page.common_module_settings_quiz_page_link.click


    page.restrict_access_quiz_page_link.click

    page.tags_quiz_page_link.click unless page.quiz_tags_txt.visible?
    page.quiz_tags_txt.set 'Auto tag 1'
    page.quiz_tags_txt.send_keys :enter
    page.quiz_tags_txt.set 'Auto tag 2'
    page.quiz_tags_txt.send_keys :enter

    page.competencies_quiz_page_link.click
    @startTimeStamp = Time.new.to_i * 1000

    page.add_quiz_page_btn_clk

    sleep(configatron.eventWaitTime)
    @endTimeStamp = Time.new.to_i * 1000

  end
  on CourseDetailPage do |page|
    page.quiz_name_parent_link(@quizName).exists?.should be true
    @quizLink =  page.quiz_name_parent_link(@quizName).attribute_value('href')
    @quizId = @quizLink.scan(/=(\w+)/).last
    page.quiz_name_parent_link(@quizName).click
    configatron.quizId = @quizId[0]
  end
  on CourseQuizDetailPage do |page|
    @quizPageName = 'Auto TF Quiz' + @currnetTimeStamp.to_s
    configatron.quizName = @quizPageName
    page.quiz_edit_btn_click
    page.quiz_add_dropdown.click
    page.quiz_add_newquestion_link.click

    #Select True or False Question
    page.quiz_type_truefalse_rbtn.click
    page.course_add_quiz_button.click
    page.quiz_question_name_txt.set @quizPageName
    page.quiz_question_editor.send_keys 'Auto TF Question'
    page.quiz_question_mark_txt.set 2
    page.quiz_feedback_editor.send_keys 'Auto Quiz Feedback'
    page.quiz_correct_answ_select.select 'True'
    page.quiz_feedback_true_editor.send_keys 'Auto True Feedback'
    page.quiz_feedback_false_editor.send_keys 'Auto False Feedback'
    page.quiz_tags_lnk.click
    page.quiz_tags_sendkeys_ent_txt.set 'Auto TF 1'
    page.quiz_tags_sendkeys_ent_txt.send_keys :enter
    page.quiz_tags_sendkeys_ent_txt.set 'Auto TF 2'
    page.quiz_tags_sendkeys_ent_txt.send_keys :enter

    page.quiz_question_save_btn.wait_until_present
    page.quiz_question_save_btn_click
  end

end

When(/^The New Quiz Page Got successfully created$/) do

  on CourseQuizDetailPage do |page|
    page.quiz_name_link(@quizPageName).wait_until_present
    page.quiz_name_link(@quizPageName).exists?.should be true
  end
  # moodle_logout

end

Then(/^A Entity for New Quiz Page should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')



  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['entity'\]\.\['@context'\] ='http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['entity'\]\.\['@type'\] ='http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end
And(/^\['entity'\]\.\['name'\] = Provided Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @quizName
end

And(/^\['entity'\]\.\['extensions'\]\.\['tags'\]\.\[0\] = Provided First Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][0].should == 'Auto tag 1'
end

And(/^\['entity'\]\.\['extensions'\]\.\['tags'\]\.\[1\] = Provided Second Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][1].should == 'Auto tag 2'
end

And(/^\['entity'\]\.\['extensions'\]\.\['openQuizDate'\] = Provided Open Date Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['openQuizDate'].include? '2018-01-01'
end

And(/^\['entity'\]\.\['extensions'\]\.\['closeQuizDate'\] = Provided Close Date Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['closeQuizDate'].include? '2018-12-12'
end

And(/^\['entity'\]\.\['extensions'\]\.\['timeLimit'\] = Provided Time Limit$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['timeLimit'].should == 'PT86400S'
end

And(/^\['entity'\]\.\['extensions'\]\.\['overdueHandling'\] = Provided Overdue Handling$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['overdueHandling'].should == 'graceperiod'
end

And(/^\['entity'\]\.\['extensions'\]\.\['gracePeriod'\] = Provided Grace Period$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gracePeriod'].should == 'PT3600S'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'quiz'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'quiz'
end

Given(/^Updated the Created Quiz Page for the Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @quizName = 'AutoQuizUpdated_' + @currnetTimeStamp.to_s
  @quizId = configatron.quizId
  configatron.updatedquizname = @quizName
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@quizId.to_s+"&return=0&sr=0")
  @description = 'UpdatedAuto Quiz Description'
  on CreateAndUpdateQuizPage do |page|

    #page.general_quiz_page_link.click
    page.quiz_name_txt.set @quizName
    page.quiz_description_editor.send_keys 'Updated'
    page.quiz_description_display_chk.click

    page.timing_quiz_page_link.click unless page.timeopen_day_select.visible?
    page.timeopen_day_select.select '3'
    page.timeopen_month_select.select 'January'
    page.timeopen_year_select.select '2018'
    page.timeopen_hour_select.select '09'
    page.timeopen_minute_select.select '35'
    page.timeclose_day_select.select '28'
    page.timeclose_month_select.select 'November'
    page.timeclose_year_select.select '2018'
    page.timeclose_hour_select.select '14'
    page.timeclose_minute_select.select '05'


    page.quiz_timelimit_txt.set 2
    page.quiz_timelimit_unit_select.select 'days'
    page.quiz_overdue_select.select 'There is a grace period when open attempts can be submitted, but no more questions answered'

    page.quiz_graceperiod_txt.set 1
    page.quiz_graceperiod_unit_select.select 'days'

    page.grade_quiz_page_link.click unless page.quiz_grade_pass_txt.visible?
    page.quiz_grade_pass_txt.set 6
    page.quiz_attempts_select.select '1'
    page.quiz_grademethod_select.select 'First attempt'

    page.layout_quiz_page_link.click unless page.quiz_questionsperpage_select.visible?
    page.quiz_questionsperpage_select.select 'Every 2 questions'

    page.quiz_showmore_link.click unless page.quiz_navmethod_select.visible?
    page.quiz_navmethod_select.select 'Sequential'
    page.quiz_showless_link.click

    page.question_behaviour_quiz_page_link.click unless page.quiz_shuffleanswers_select.visible?
    page.quiz_shuffleanswers_select.select 'Yes'
    page.quiz_preferredbehaviour_select.select 'Deferred feedback'

    page.quiz_showmore_link.click unless page.quiz_canredoquestions_select.visible?

    #page.quiz_canredoquestions_select.select 'Students may redo another version of any finished question'
    # page.quiz_attemptonlast_select.select 'Yes'
    page.quiz_showless_link.click
    page.review_options_quiz_page_link.click


    page.appearance_quiz_page_link.click


    page.extra_restrictions_attempts_quiz_page_link.click


    page.overall_feedback_quiz_page_link.click


    page.common_module_settings_quiz_page_link.click


    page.restrict_access_quiz_page_link.click

    page.tags_quiz_page_link.click unless page.quiz_tags_txt.visible?
    page.quiz_tags_txt.set 'Auto tag 3'
    page.quiz_tags_txt.send_keys :enter


    page.competencies_quiz_page_link.click
    @startTimeStamp = Time.new.to_i * 1000
    page.add_quiz_page_btn_clk

  end


end


When(/^The Quiz Page Got successfully Updated$/) do

  on CourseDetailPage do |page|
    page.quiz_name_parent_link(@quizName).wait_until_present
    page.quiz_name_parent_link(@quizName).exists?.should be_true

  end
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^A Entity for Update Quiz Page should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Updated \['entity'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^Updated \['entity'\]\.\['name'\] = Updated Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @quizName
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[0\] = Provided First Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][0].should == 'Auto tag 1'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[1\] = Provided Second Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][1].should == 'Auto tag 2'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[2\] = Provided Third Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][2].should == 'Auto tag 3'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['openQuizDate'\] = Updated Open Date Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['openQuizDate'].include? '2018-01-03'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['closeQuizDate'\] = Updated Close Date Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['closeQuizDate'].include? '2018-11-28'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['timeLimit'\] = Updated Time Limit$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['timeLimit'].should == 'PT172800S'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['overdueHandling'\] = Updated Overdue Handling$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['overdueHandling'].should == 'graceperiod'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['gracePeriod'\] = Updated Grace Period$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gracePeriod'].should == 'PT86400S'
end
