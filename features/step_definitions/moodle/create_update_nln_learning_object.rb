Given(/^Created a New NLN Learning Object under a course$/) do
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

  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=nln&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on NLNLearningObjectPage do |page|

    page.display_description_chkbox.click

    #Provide Content Parameters
    page.nln_browse_btn.click
    sleep(3)
    @browser.driver.switch_to.window(@browser.driver.window_handles[1])
    page.subjects_material_link.click
    sleep(3)
    page.subject_link.click
    sleep(3)
    page.topic_link.click
    sleep(3)
    page.add_to_moodle_course_btn.click
    sleep(6)
    @browser.driver.switch_to.window(@browser.driver.window_handles[0])

    #Capture NLN Learning Object id and name
    @nln_learning_object_id = page.nln_learning_object_id_txt.value
    @nln_learning_object_name = page.nln_name_txt.value
    configatron.nlnlearningobjectid = @nln_learning_object_id
    configatron.nlnlearningobjectname = @nln_learning_object_name

    #Provide Options
    page.options_link.click
    page.display_select.select 'In pop-up'
    page.pop_up_width_txt.clear
    page.pop_up_width_txt.send_keys '839'
    page.pop_up_height_txt.clear
    page.pop_up_height_txt.send_keys '529'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Hide'
    page.common_module_id_number_txt.set '789'+@currnetTimeStamp.to_s

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

    page.nln_saveanddisplay_btn_clk
    sleep(10)
  end
end

When(/^The New NLN Learning Object got successfully created$/) do

  on CourseItemPage do |page|
    page.nln_learning_object_name_txt.text.should == configatron.nlnlearningobjectname
  end
  configatron.nln_id = get_item_id()

end

Then(/^A Course Entity for New NLN Learning Object should get generated and sent to our Raw Entity Index\.$/) do
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

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = NLN Learning Object Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.nlnlearningobjectname
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'nln'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'nln'
end

And(/^\['entity'\]\.\['extensions'\]\.\['nlnLearningObjectId'\] = NLN learning object ID$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['nlnLearningObjectId'].should == configatron.nlnlearningobjectid
end

Given(/^Updated the existing NLN Learning Object under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @nlnId = configatron.nln_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?sr&return=1&update="+@nlnId)

  @nlnName = configatron.nlnlearningobjectname+'updated'

  on NLNLearningObjectPage do |page|
    #Update Name
    sleep(3)
    page.nln_name_txt.click
    page.nln_name_txt.send_keys [:control, 'a']
    page.nln_name_txt.send_keys @nlnName

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    #Update Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'

    page.nln_saveanddisplay_btn_clk
    sleep(5)
  end
end

When(/^The existing NLN Learning Object got successfully updated$/) do

  on CourseItemPage do |page|
    page.nln_learning_object_name_txt.text.should == configatron.nlnlearningobjectname+'updated'
  end
  moodle_logout
end

Then(/^A Course Entity for Update NLN Learning Object should get generated and sent to our Raw Entity Index\.$/) do
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

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = NLN Learning Object Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.nlnlearningobjectname+'updated'
end
