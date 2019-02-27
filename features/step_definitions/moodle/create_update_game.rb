Given(/^Created a New Game under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = configatron.courseId

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

  @gameName =  'at_game_'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.gamename = @gameName
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=game&type=bookquiz&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseGamePage do |page|

    page.game_name_txt.set @gameName
    page.source_module_select.select 'Questions'
    page.max_attempts_txt.set '4'
    page.disable_summarize_select.select 'Yes'
    page.show_high_score_txt.set '10'

    #Provide Grade Parameters
    page.grade_link.click
    page.gradepass_txt.set '73'
    page.max_grade_txt.click
    page.max_grade_txt.send_keys [:control, 'a']
    page.max_grade_txt.send_keys '95'
    page.grading_method_select.select 'Last attempt'
    page.open_game_chkbox.click
    page.open_game_day_select.select '10'
    page.open_game_month_select.select 'December'
    page.open_game_year_select.select '2017'
    page.open_game_hour_select.select '08'
    page.open_game_minute_select.select '41'
    page.close_game_chkbox.click
    page.close_game_day_select.select '12'
    page.close_game_month_select.select 'December'
    page.close_game_year_select.select '2019'
    page.close_game_hour_select.select '07'
    page.close_game_minute_select.select '43'

    #Provide Book Quiz Parameters
    page.bookquiz_options_link.click
    page.layout_select.select 'Question at the bottom of the book'

    ##Header/Footer Parameters
    page.header_footer_options_link.click
    page.text_at_top_description_txt.click
    page.text_at_top_description_txt.send_keys [:control, 'a']
    page.text_at_top_description_txt.send_keys 'Header Footer Text at Top'
    page.text_at_bottom_description_txt.click
    page.text_at_bottom_description_txt.send_keys [:control, 'a']
    page.text_at_bottom_description_txt.send_keys 'Header Footer Text at Bottom'

    #Provide Common Module Setting Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Hide'
    page.common_module_id_number_txt.set '876'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Students can manually mark the activity as completed'
    page.activity_completion_expected_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'October'
    page.activity_completion_year_select.select '2020'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.game_saveanddisplay_btn_clk
  end
end

When(/^The New Game got successfully created$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.gamename
  end
  sleep(10)
  configatron.game_id = get_item_id()
end

Then(/^A Course Entity for New Game should get generated and sent to our Raw Entity Index\.$/) do
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
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = Game name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.gamename
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'game'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'game'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['closeGame'\] = Provided Close Game Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['closeGame'].include? '2019-12-12'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2020-10-08'
end

And(/^\['entity'\]\.\['extensions'\]\.\['gameKind'\] = 'bookquiz'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gameKind'].should == 'bookquiz'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Grade To Pass$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 73
end

And(/^The \['entity'\]\.\['extensions'\]\.\['openGame'\] = Provided Open Game Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['openGame'].include? '2017-12-10'
end

Given(/^Updated the existing Game under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @gameId = configatron.game_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@gameId+"&return=1")

  @gameName = configatron.gamename+'updated'

  on CourseGamePage do |page|

    page.game_name_txt.clear
    page.game_name_txt.set @gameName
    page.max_attempts_txt.clear
    page.max_attempts_txt.set '6'
    page.disable_summarize_select.select 'No'
    page.show_high_score_txt.clear
    page.show_high_score_txt.set '13'

    #Provide Grade Parameters
    page.grade_link.click
    page.gradepass_txt.clear
    page.gradepass_txt.set '83'
    page.max_grade_txt.click
    page.max_grade_txt.send_keys [:control, 'a']
    page.max_grade_txt.send_keys '100'
    page.grading_method_select.select 'Highest grade'
    page.open_game_day_select.select '12'
    page.open_game_month_select.select 'November'
    page.open_game_year_select.select '2017'
    page.open_game_hour_select.select '07'
    page.open_game_minute_select.select '45'
    page.close_game_day_select.select '14'
    page.close_game_month_select.select 'November'
    page.close_game_year_select.select '2019'
    page.close_game_hour_select.select '08'
    page.close_game_minute_select.select '49'

    #Provide Book Quiz Parameters
    page.bookquiz_options_link.click
    page.layout_select.select 'Question at the top of the book'

    ##Header/Footer Parameters
    page.header_footer_options_link.click
    page.text_at_top_description_txt.click
    page.text_at_top_description_txt.send_keys [:control, 'a']
    page.text_at_top_description_txt.send_keys 'Header Footer Text at Top Updated'
    page.text_at_bottom_description_txt.click
    page.text_at_bottom_description_txt.send_keys [:control, 'a']
    page.text_at_bottom_description_txt.send_keys 'Header Footer Text at Bottom Updated'

    #Provide Common Module Setting Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set '876'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'No groups'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_completion_view_chkbox.click
    page.activity_completion_user_grade_chkbox.click
    page.activity_completion_pass_chkbox.click
    page.activity_completion_group_attempts_chkbox.click
    page.activity_completion_day_select.select '7'
    page.activity_completion_month_select.select 'November'
    page.activity_completion_year_select.select '2021'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click
    @startTimeStamp = Time.new.to_i * 1000
    page.game_saveanddisplay_btn_clk
  end
end

When(/^The existing Game got successfully updated$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @gameName
  end
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^A Course Entity for Update Game should get generated and sent to our Raw Entity Index\.$/) do
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

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = Game name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.gamename+'updated'
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['closeGame'\] = Provided Close Game Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['closeGame'].include? '2019-11-14'
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2021-11-07'
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Grade To Pass$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 83
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['openGame'\] = Provided Open Game Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['openGame'].include? '2017-11-12'
end
