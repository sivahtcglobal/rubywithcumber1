Given(/^Created a New Feedback under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil

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

  @feedbackName =  'at_feedback_'+@currnetTimeStamp.to_s
  @feedbackDescription = 'Automated Feedback Description'+@currnetTimeStamp.to_s
  @questionName = 'at_question_name_'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.feedbackname = @feedbackName
  configatron.feedbackdescription = @feedbackDescription
  configatron.feedbackquestionname = @questionName
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=feedback&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseFeedbackPage do |page|

    page.feedback_name_txt.set @feedbackName

    page.feedback_description_txt.click
    page.feedback_description_txt.send_keys [:control, 'a']
    page.feedback_description_txt.send_keys @feedbackDescription
    page.display_description_chkbox.click

    #Provide Availability
    page.availability_link.click
    page.time_open_chkbox.click
    page.time_open_day_select.select '1'
    page.time_open_month_select.select 'January'
    page.time_open_year_select.select '2017'
    page.time_open_hour_select.select '10'
    page.time_open_minute_select.select '40'
    page.time_close_chkbox.click
    page.time_close_day_select.select '1'
    page.time_close_month_select.select 'August'
    page.time_close_year_select.select '2019'
    page.time_close_hour_select.select '12'
    page.time_close_minute_select.select '55'

    #Question and submission settings
    page.question_submission_settings_link.click
    page.record_user_names_select.select "Anonymous"
    page.allow_multiple_submissions_select.select 'No'
    page.email_notification_select.select 'No'
    page.auto_numbering_select.select 'No'

    #After submission
    page.after_submission_link.click
    page.publish_stats_select.select 'No'
    page.completion_message_txt.click
    page.completion_message_txt.send_keys [:control, 'a']
    page.completion_message_txt.send_keys 'After Submission Completion Message'+@currnetTimeStamp.to_s
    page.link_to_next_activity_txt.set 'Link To Next Activity'+@currnetTimeStamp.to_s

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set '123'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Students can manually mark the activity as completed'
    page.activity_completion_expected_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'October'
    page.activity_completion_year_select.select '2018'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.feedback_saveanddisplay_btn_clk

    #Add A Question
    page.edit_questions_tab.click
    page.question_type_select.select 'Multiple choice'
    page.question_name_txt.set @questionName
    page.multiple_choice_values_txt.send_keys 'Choice 1'
    @browser.send_keys :enter
    page.multiple_choice_values_txt.send_keys 'Choice 2'
    @browser.send_keys :enter
    page.multiple_choice_values_txt.send_keys 'Choice 3'
    sleep(3)
    page.save_question_btn_clk
  end
end

When(/^The New Feedback got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == 'Edit questions'
  end
  configatron.feedback_id = get_item_id()

end

Then(/^A Course Entity for New Feedback should get generated and sent to our Raw Entity Index\.$/) do
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
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = Feedback name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @feedbackName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'feedback'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'feedback'
end

And(/^\['entity'\]\.\['extensions'\]\.\['recordUserNames'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['recordUserNames'].should == 'anonymous'
end

And(/^\['entity'\]\.\['extensions'\]\.\['allowMultipleSubmissions'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['allowMultipleSubmissions'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['enableNotifications'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['enableNotifications'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['autoNumberQuestions'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['autoNumberQuestions'].should == false
end

Given(/^Updated the existing Feedback under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @feedbackId = configatron.feedback_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@feedbackId+"&return=0&sr=0")
  @feedbackName = configatron.feedbackname+'updated'
  @feedbackDescription = configatron.feedbackdescription+'updated'
  configatron.feedbacknameupdated = @feedbackName
  configatron.feedbackdescriptionupdated = @feedbackDescription

  on CourseFeedbackPage do |page|

    page.feedback_name_txt.clear
    page.feedback_name_txt.set @feedbackName

    page.feedback_description_txt.click
    page.feedback_description_txt.send_keys [:control, 'a']
    page.feedback_description_txt.send_keys @feedbackDescription

    #Question and submission settings
    page.question_submission_settings_link.click
    page.record_user_names_select.select "User's name will be logged and shown with answers"
    page.allow_multiple_submissions_select.select 'Yes'
    page.email_notification_select.select 'Yes'
    page.auto_numbering_select.select 'Yes'

    #After submission
    page.after_submission_link.click
    page.publish_stats_select.select 'Yes'
    page.completion_message_txt.click
    page.completion_message_txt.send_keys [:control, 'a']
    page.completion_message_txt.send_keys 'After Submission Completion Message Updated'+@currnetTimeStamp.to_s
    page.link_to_next_activity_txt.set 'Link To Next Activity Updated'+@currnetTimeStamp.to_s

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_require_view_chkbox.click
    page.activity_completion_submit_chkbox.click
    page.activity_completion_day_select.select '7'
    page.activity_completion_month_select.select 'November'
    page.activity_completion_year_select.select '2018'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.feedback_saveanddisplay_btn_clk
  end
end

When(/^The existing Feedback got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @feedbackName
  end
  moodle_logout

end

Then(/^A Course Entity for Update Feedback should get generated and sent to our Raw Entity Index\.$/) do
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
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = Feedback name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @feedbackName
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['recordUserNames'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['recordUserNames'].should == 'logged'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['allowMultipleSubmissions'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['allowMultipleSubmissions'].should == true
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['enableNotifications'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['enableNotifications'].should == true
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['autoNumberQuestions'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['autoNumberQuestions'].should == true
end
