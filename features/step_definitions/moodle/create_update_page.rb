Given(/^Created a New Page for a course$/) do
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

  @pageName =  'at_page_'+@currnetTimeStamp.to_s
  @pageDescription = 'Automated Page Description'+@currnetTimeStamp.to_s
  @pageContent = 'Automated Page Content'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.pagename = @pageName
  configatron.pagedescription = @pageDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=page&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CoursePagePage do |page|

    page.page_name_txt.set @pageName

    page.page_description_txt.click
    page.page_description_txt.send_keys @pageDescription
    page.page_description_chkbox.click

    page.page_content_txt.click
    page.page_content_txt.send_keys @pageContent

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.page_saveanddisplay_btn_clk

  end
end

When(/^The New Page got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @pageName
  end
  configatron.page_id = get_item_id()
end

Then(/^A Course Entity for New Page should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/WebPage'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/WebPage'
end

And(/^\['entity'\]\.\['name'\] = page name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @pageName
end

And(/^\['entity'\]\.\['extensions'\]\.\['courseSection'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseSection'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['courseSection']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
end

And(/^\['entity'\]\.\['extensions'\]\.\['courseSection'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['courseSection']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['entity'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseOffering'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['courseSection']['subOrganizationOf']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'page'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'page'
end

Given(/^Updated the Page for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @pageId = configatron.page_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@pageId+"&return=0&sr=0")
  @pageName = configatron.pagename+'updated'

  on CoursePagePage do |page|

    page.page_name_txt.clear
    page.page_name_txt.set @pageName

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.page_saveanddisplay_btn_clk

  end
end

When(/^The Page got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @pageName
  end
  moodle_logout
end

Then(/^A Course Entity for Update Page should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] should have page name value as updated$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @pageName
end
