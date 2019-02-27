Given(/^Created a New Group under a course$/) do
  @baseDir = File.absolute_path "./"
  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","testImage.jpg")

  @currnetTimeStamp = Time.new.to_i * 1000
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

  @groupName =  'at_group_name_'+@currnetTimeStamp.to_s
  @groupDescription = 'Automated Group Description'+@currnetTimeStamp.to_s
  @groupIdNumber = '888_' + @currnetTimeStamp.to_s
  configatron.groupname = @groupName
  configatron.groupdescription = @groupDescription
  configatron.groupidnumber = @groupIdNumber

  @browser.goto(configatron.moodleURL+'/group/group.php?courseid='+@courseId)

  on CourseGroupPage do |page|
    page.group_name_txt.set @groupName
    page.group_id_number_txt.set @groupIdNumber

    page.group_description_txt.click
    page.group_description_txt.send_keys [:control, 'a']
    page.group_description_txt.send_keys @groupDescription

    page.enrolment_key_link.click
    page.enrolment_key_txt.set 'P@ssw0rd' + @currnetTimeStamp.to_s

    page.choose_file_btn.click
    sleep(3)
    page.upload_files_link.click
    sleep(3)
    @browser.file_field(:id,//).set(uploadfile_path)
    page.upload_files_btn.click

    page.save_changes_btn_clk
  end
end

When(/^The New Group got successfully created$/) do
  on CourseGroupPage do |page|
    page.added_group.text.include? @groupName
    configatron.group_id = page.url.split('?').last.split('=').last
  end
end

Then(/^A Course Entity for New Group should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Group name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.groupname
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'group'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'group'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['idNumber'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['idNumber'].should == configatron.groupidnumber
end

And(/^The \['entity'\]\.\['extensions'\]\.\['description'\] = Provided Description$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['description'].include? configatron.groupdescription
end

And(/^The \['entity'\]\.\['extensions'\]\.\['hidePicture'\] = false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['hidePicture'].should == false
end

Given(/^Updated the existing Group under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @groupId = configatron.group_id
  @browser.goto(configatron.moodleURL+"/group/group.php?courseid="+configatron.courseId+"&id="+@groupId)

  @groupName =  configatron.groupname+'updated'
  @groupDescription = configatron.groupdescription+'updated'
  @groupIdNumber = '999_' + @currnetTimeStamp.to_s
  configatron.groupnameupdated = @groupName
  configatron.groupdescriptionupdated = @groupDescription
  configatron.groupidnumberupdated = @groupIdNumber

  on CourseGroupPage do |page|
    page.group_name_txt.click
    page.group_name_txt.send_keys [:control, 'a']
    page.group_name_txt.send_keys @groupName

    page.group_id_number_txt.click
    page.group_id_number_txt.send_keys [:control, 'a']
    page.group_id_number_txt.send_keys @groupIdNumber

    page.group_description_txt.click
    page.group_description_txt.send_keys [:control, 'a']
    page.group_description_txt.send_keys @groupDescription

    page.edit_password_link.click
    page.enrolment_key_txt.click
    page.enrolment_key_txt.send_keys [:control, 'a']
    page.enrolment_key_txt.send_keys 'P@ssw0rd' + @currnetTimeStamp.to_s

    page.hide_picture_select.select 'Yes'

    sleep(3)
    page.save_changes_btn_clk
    sleep(2)
  end
end

When(/^The existing Group got successfully updated$/) do
  on CourseGroupPage do |page|
    page.added_group.text.include? @groupName
  end
  moodle_logout
end

Then(/^A Course Entity for Update Group should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Group name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.groupnameupdated
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['idNumber'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['idNumber'].should == configatron.groupidnumberupdated
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['description'\] = Provided Description$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['description'].include? configatron.groupdescriptionupdated
end

And(/^The \['entity'\]\.\['extensions'\]\.\['hidePicture'\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['hidePicture'].should == true
end
