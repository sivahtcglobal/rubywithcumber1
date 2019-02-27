Given(/^Created a New Forum for a course$/) do
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

  @forumName =  'at_forum_'+@currnetTimeStamp.to_s
  @forumDescription = 'Automated Forum Description'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.forumname = @forumName
  configatron.forumdescription = @forumDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=forum&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseForumPage do |page|
    page.forum_name_txt.set @forumName

    page.forum_description_txt.click
    page.forum_description_txt.send_keys [:control, 'a']
    page.forum_description_txt.send_keys @forumDescription
    page.display_description_chkbox.click

    page.forum_type_select.select 'A single simple discussion'

    #Provide attachments and word count
    page.attachments_link.click
    page.max_size_select.select '2MB'
    page.max_attachments_select.select '5'
    page.display_word_count_select.select 'Yes'

    #Provide subscription and tracking
    page.subscription_link.click
    page.subscription_mode_select.select 'Auto subscription'
    page.read_tracking_select.select 'Off'

    #Post threshold for blocking
    page.post_threshold_link.click
    page.block_period_select.select '1 Week'
    page.block_after_txt.send_keys '4'
    page.warn_after_txt.send_keys '1'

    #Provide Grade Parameters
    page.grade_link.click

    #Provide Rating Parameters
    page.ratings_link.click
    page.aggregate_type_select.select 'Average of ratings'
    page.ratings_scale_grade_type_select.select 'Point'
    page.ratings_scale_grade_point_txt.set '95'
    page.rating_time_chkbox.click
    page.from_day_select.select '1'
    page.from_month_select.select 'January'
    page.from_year_select.select '2017'
    page.from_hour_select.select '08'
    page.from_minute_select.select '05'
    page.to_day_select.select '31'
    page.to_month_select.select 'December'
    page.to_year_select.select '2018'
    page.to_hour_select.select '18'
    page.to_minute_select.select '05'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set '123'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'No groups'
    page.common_module_grouping_select.select 'None'

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.forum_saveanddisplay_btn_clk
  end
end

When(/^The New Forum got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @forumName
  end
  configatron.forum_id = get_item_id()
end

Then(/^A Course Entity for New Forum should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Forum name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @forumName
end

And(/^\['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'forum'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'forum'
end

And(/^\['entity'\]\.\['extensions'\]\.\['forumType'\] = 'single'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['forumType'].should == 'single'
end

And(/^\['entity'\]\.\['extensions'\]\.\['ratingAggregateType'\] = Provided Aggregate Type$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['ratingAggregateType'].should == 'average'
end

And(/^\['entity'\]\.\['extensions'\]\.\['gradeType'\] = Provided Scale Type$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'point'
end

And(/^\['entity'\]\.\['extensions'\]\.\['groupMode'\] = 'none'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'none'
end

And(/^\['entity'\]\.\['extensions'\]\.\['grouping'\] = false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['grouping'].should == false
end

And(/^\['entity'\]\.\['extensions'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^\['entity'\]\.\['extensions'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['edApp']['name'].should == 'IntellifyLearning'
end

Given(/^Updated the Forum for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @forumId = configatron.forum_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@forumId+"&return=0&sr=0")
  @forumName = configatron.forumname+'updated'
  @forumDescription = configatron.forumdescription+'updated'

  on CourseForumPage do |page|

    #Update Name
    page.forum_name_txt.set @forumName

    #Update Description
    page.forum_description_txt.click
    page.forum_description_txt.send_keys [:control, 'a']
    page.forum_description_txt.send_keys @forumDescription

    #Update Forum Type
    page.forum_type_select.select 'Standard forum for general use'

    #Update Aggregate Type
    page.ratings_link.click
    page.aggregate_type_select.select 'Count of ratings'

    #Update Scale Maximum Grade
    page.ratings_scale_grade_point_txt.set '85'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.forum_saveanddisplay_btn_clk
  end
end

When(/^The Forum got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @forumName
  end
  moodle_logout
end

Then(/^A Course Entity for Update Forum should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Forum name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @forumName
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['ratingAggregateType'\] = Provided Aggregate Type$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['ratingAggregateType'].should == 'count'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['forumType'\] = 'general'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['forumType'].should == 'general'
end
