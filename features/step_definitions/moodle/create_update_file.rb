Given(/^Created a New File for a course$/) do
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

  @fileName =  'at_file_'+@currnetTimeStamp.to_s
  @fileDescription = 'Automated File Description'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'

  configatron.filename = @fileName
  configatron.filedescription = @fileDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2
  puts "Course Id #{@courseId}"
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=resource&type=&course='+@courseId+'&section=1&return=0&sr=0')
  @courseName = configatron.courseName
  on CourseFilePage do |page|

    page.file_name_txt.set @fileName

    page.file_description_txt.click
    page.file_description_txt.send_keys [:control, 'a']
    page.file_description_txt.send_keys @fileDescription
    page.display_description_chkbox.click
    sleep(5)

    page.select_files_link.click
    sleep(10)
    page.server_files_link.click
    sleep(5)
    page.select_course_link(@courseName).click
    sleep(5)
    page.select_a_file.click
    sleep(5)
    page.select_a_file.click
    sleep(5)
    page.select_this_file_btn.click
    sleep(10)

    #Provide Activity Completion Parameters
    # page.activity_completion_link.click
    # page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    # page.activity_completion_view_chkbox.click
    # page.activity_completion_expected_chkbox.click
    # page.activity_completion_day_select.select '30'
    # page.activity_completion_month_select.select 'December'
    # page.activity_completion_year_select.select '2017'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    #Add Competencies
    # page.competencies_link.click
    # page.search_competencies.click
    # sleep(1)
    # page.select_first_competency.click

    page.file_saveanddisplay_btn_clk

  end
end

When(/^The New File got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @fileName
  end
  configatron.file_id = get_item_id()

end

Then(/^A Course Entity for New File should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Document'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Document'
end

And(/^\['entity'\]\.\['name'\] = File Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @fileName
end

And(/^\['entity'\]\.\['extensions'\]\.\['tags'\]\.\[0\] = Provided Tags$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][0].should == configatron.tagname1
end

And(/^\['entity'\]\.\['extensions'\]\.\['courseSection'\]\.\['@id'\] value includes the course id$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['courseSection']['@id'].include? configatron.courseId
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'resource'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'resource'
end

Given(/^Updated the Existing File for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @fileId = configatron.file_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?sr&return=1&update="+@fileId)

  @fileName = configatron.filename+'updated'
  @fileDescription = configatron.filedescription+'updated'

  on CourseFilePage do |page|

    #Update Name
    page.file_name_txt.clear
    page.file_name_txt.set @fileName

    #Update Description
    page.file_description_txt.click
    page.file_description_txt.send_keys [:control, 'a']
    page.file_description_txt.send_keys @fileDescription

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    #Update Competencies
    page.competencies_link.click
    # page.delete_competency.click
    # page.search_competencies.click
    # sleep(1)
    # page.select_second_competency.click

    page.file_saveanddisplay_btn_clk

  end
end

When(/^The Existing File got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @fileName
  end
  moodle_logout
end

Then(/^A Course Entity for Update File should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = File Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @fileName
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['tags'\]\.\[0\] = Provided Tags$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][0].should == configatron.tagname2
end
