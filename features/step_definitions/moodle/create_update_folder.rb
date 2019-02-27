Given(/^Created a New Folder under a course$/) do
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

  @folderName =  'at_folder_'+@currnetTimeStamp.to_s
  @folderDescription = 'Automated Folder Description'+@currnetTimeStamp.to_s
  @folderIdNumber = @currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'

  configatron.foldername = @folderName
  configatron.folderdescription = @folderDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=folder&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseFolderPage do |page|

    page.folder_name_txt.set @folderName

    page.folder_description_txt.click
    page.folder_description_txt.send_keys [:control, 'a']
    page.folder_description_txt.send_keys @folderDescription
    page.display_description_chkbox.click

    #Provide Display Folder Contents Parameters
    page.display_folder_content_select.select 'On a separate page'

    #Provide Common Module Setting Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set @folderIdNumber

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.folder_saveanddisplay_btn_clk

  end
end

When(/^The New Folder got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @folderName
  end
  sleep(10)
  configatron.folder_id = get_item_id()

end

Then(/^A Course Entity for New Folder should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Entity'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Entity'
end

And(/^\['entity'\]\.\['name'\] = Folder name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @folderName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'folder'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'folder'
end

Given(/^Updated the existing Folder under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @folderId = configatron.folder_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@folderId+"&return=1")

  @folderName = configatron.foldername+'updated'
  @folderDescription = configatron.folderdescription+'updated'

  on CourseFolderPage do |page|

    #Update Name
    page.folder_name_txt.clear
    page.folder_name_txt.set @folderName

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.folder_saveanddisplay_btn_clk

  end
end

When(/^The existing Folder got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @folderName
  end
  moodle_logout

end

Then(/^A Course Entity for Update Folder should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Folder name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @folderName
end
