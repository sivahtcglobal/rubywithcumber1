Given(/^Created a New Chat under a course$/) do
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

  @chatName =  'at_chat_'+@currnetTimeStamp.to_s
  @chatDescription = 'Automated Chat Description'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.chatname = @chatName
  configatron.chatdescription = @chatDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=chat&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseChatPage do |page|

    page.chat_name_txt.set @chatName

    page.chat_description_txt.click
    page.chat_description_txt.send_keys [:control, 'a']
    page.chat_description_txt.send_keys @chatDescription
    page.display_description_chkbox.click

    #Provide Chat Session Parameters
    page.chat_sessions_link.click
    page.chat_time_day_select.select '8'
    page.chat_time_month_select.select 'October'
    page.chat_time_year_select.select '2018'
    page.chat_time_hour_select.select '10'
    page.chat_time_minute_select.select '40'
    page.chat_schedule_select.select 'At the same time every day'
    page.chat_save_sessions_select.select '7 days'
    page.chat_student_logs_select.select 'Yes'

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

    page.chat_saveanddisplay_btn_clk

  end
end

When(/^The New Chat got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @chatName
  end
  configatron.chat_id = get_item_id()

end

Then(/^A Course Entity for New Chat should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Chat name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @chatName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'chat'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'chat'
end

And(/^\['entity'\]\.\['extensions'\]\.\['chatTime'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['chatTime'].include? '2018-10-08'
end

And(/^\['entity'\]\.\['extensions'\]\.\['chatRepeatTimes'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['chatRepeatTimes'].should == 'sameTimeEveryDay'
end

Given(/^Updated the existing Chat under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @chatId = configatron.chat_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@chatId+"&return=0&sr=0")
  @chatName = configatron.chatname+'updated'
  @chatDescription = configatron.chatdescription+'updated'
  configatron.chatnameupdated = @chatName
  configatron.chatdescriptionupdated = @chatDescription

  on CourseChatPage do |page|

    page.chat_name_txt.set @chatName

    page.chat_description_txt.click
    page.chat_description_txt.send_keys [:control, 'a']
    page.chat_description_txt.send_keys @chatDescription

    #Provide Chat Session Parameters
    page.chat_sessions_link.click
    page.chat_time_day_select.select '9'
    page.chat_time_month_select.select 'November'
    page.chat_time_year_select.select '2018'
    page.chat_time_hour_select.select '10'
    page.chat_time_minute_select.select '40'
    page.chat_schedule_select.select 'At the same time every week'
    page.chat_save_sessions_select.select '21 days'
    page.chat_student_logs_select.select 'No'

    #Update Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_require_view_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'December'
    page.activity_completion_year_select.select '2018'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.chat_saveanddisplay_btn_clk
  end
end

When(/^The existing Chat got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @chatName
  end
  moodle_logout

end

Then(/^A Course Entity for Update Chat should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Chat name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.chatnameupdated
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['chatTime'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['chatTime'].include? '2018-11-09'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['chatRepeatTimes'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['chatRepeatTimes'].should == 'sameTimeEveryWeek'
end
