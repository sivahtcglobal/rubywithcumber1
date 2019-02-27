Given(/^Created a New URL for a course$/) do
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

  @urlName =  'at_url_'+@currnetTimeStamp.to_s
  @externalUrl = 'http://qaautomation'+@currnetTimeStamp.to_s+'.com'
  @urlDescription = 'Automated URL Description'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.urlname = @urlName
  configatron.externalurl = @externalUrl
  configatron.urldescription = @urlDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=url&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseURLPage do |page|
    page.url_name_txt.wait_until_present
    page.url_name_txt.set @urlName
    page.external_url_txt.set @externalUrl

    page.url_description_txt.click
    page.url_description_txt.send_keys [:control, 'a']
    page.url_description_txt.send_keys @urlDescription
    page.display_description_chkbox.click

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    @startTimeStamp = Time.new.to_i * 1000
    page.url_saveanddisplay_btn_clk

  end
end

When(/^The New URL got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.wait_until_present
    page.course_item_breadcrumb.text.should == @urlName
  end
  configatron.url_id = get_item_id()
end

Then(/^A Course Entity for New URL should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = URL name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @urlName
end

And(/^\['entity'\]\.\['extensions'\]\.\['restrictions'\] = false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['restrictions'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['externalurl'\] = Provided URL$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['externalurl'].should == @externalUrl
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'url'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'url'
end

Given(/^Updated the existing URL for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @urlId = configatron.url_id

  @browser.execute_script("window.onbeforeunload = null")
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@urlId+"&return=0&sr=0")

  @urlName = configatron.urlname+'updated'
  @externalUrl = configatron.externalurl+'updated'
  @urlDescription = configatron.urldescription+'updated'

  on CourseURLPage do |page|
    page.url_name_txt.wait_until_present
    page.url_name_txt.clear
    page.url_name_txt.set @urlName

    page.external_url_txt.clear
    page.external_url_txt.set @externalUrl

    page.url_description_txt.click
    page.url_description_txt.send_keys [:control, 'a']
    page.url_description_txt.send_keys @urlDescription

    #Update Tags
    page.tags_link.click
    page.delete_tag.click
    @startTimeStamp = Time.new.to_i * 1000
    page.url_saveanddisplay_btn_clk

  end
end

When(/^The existing URL got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.wait_until_present
    page.course_item_breadcrumb.text.should == @urlName
  end
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^A Course Entity for Update URL should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = URL name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @urlName
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['externalurl'\] = Provided URL$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['externalurl'].should == @externalUrl
end
