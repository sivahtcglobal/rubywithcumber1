Given(/^Created a New RecordingsBN under a course$/) do
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

  @recordingsName =  'at_recordings_'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.recordingsname = @recordingsName
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=recordingsbn&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseRecordingsBnPage do |page|

    page.recordings_name_txt.set @recordingsName

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Hide'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Students can manually mark the activity as completed'
    page.activity_completion_expected_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'October'
    page.activity_completion_year_select.select '2019'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.recordingsbn_saveanddisplay_btn_clk

  end
end

When(/^The New RecordingsBN got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @recordingsName
  end
  configatron.recordingsbn_id = get_item_id()

end

Then(/^A Course Entity for New RecordingsBN should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = RecordingsBN name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @recordingsName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'recordingsbn'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'recordingsbn'
end

And(/^\['entity'\]\.\['extensions'\]\.\['visible'\] = false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['visible'].should == false
end

Given(/^Updated the existing RecordingsBN under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @recordingsBnId = configatron.recordingsbn_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@recordingsBnId+"&return=0&sr=0")
  @recordingsName = configatron.recordingsname+'updated'
  configatron.recordingsnameupdated = @recordingsName

  on CourseRecordingsBnPage do |page|

    page.recordings_name_txt.clear
    page.recordings_name_txt.set @recordingsName

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_settings_link.click unless page.common_module_visible_select.present?
    page.common_module_visible_select.select 'Show'

    #Provide Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_day_select.select '6'
    page.activity_completion_month_select.select 'November'
    page.activity_completion_year_select.select '2019'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.recordingsbn_saveanddisplay_btn_clk

  end
end

When(/^The existing RecordingsBN got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.recordingsnameupdated
  end
  sleep(10)
  moodle_logout
end

Then(/^A Course Entity for Update RecordingsBN should get generated and sent to our Raw Entity Index\.$/) do
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
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = RecordingsBN name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.recordingsnameupdated
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['visible'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['visible'].should == true
end
