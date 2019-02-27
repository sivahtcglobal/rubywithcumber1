Given(/^Added a New Advanced Forum for a course$/) do
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

  @advancedForumName =  'at_advanced_forum_'+@currnetTimeStamp.to_s
  @advancedForumDescription = 'Automated Advanced Forum Description'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.advancedforumname = @advancedForumName
  configatron.advancedforumdescription = @advancedForumDescription
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=hsuforum&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseAdvancedForumPage do |page|

    page.advanced_forum_name_txt.wait_until_present
    page.advanced_forum_name_txt.set @advancedForumName

    page.advanced_forum_description_txt.click
    page.advanced_forum_description_txt.send_keys [:control, 'a']
    page.advanced_forum_description_txt.send_keys @advancedForumDescription
    page.display_description_chkbox.click

    page.forum_type_select.select 'Standard forum for general use'

    #Provide Grade Parameters
    page.grade_link.click
    page.grade_type_select.select 'Manual'
    page.scale_grade_type_select.select 'Point'

    page.grade_to_pass_txt.send_keys '80'

    #Provide Rating Parameters
    page.ratings_link.click
    page.aggregate_type_select.select 'Average of ratings'
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

    #Add Tags
    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter
    page.enter_tags.send_keys @tagName2
    @browser.send_keys :enter

    page.advanced_forum_saveanddisplay_btn_clk
  end

end

When(/^The New Advanced Forum got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @advancedForumName
  end
  configatron.advanced_forum_id = get_item_id()
end

Then(/^A Course Entity for New Advanced Forum should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Advanced Forum name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @advancedForumName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'hsuforum'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'hsuforum'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['forumType'\] = 'general'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['forumType'].should == 'general'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradingType'\] = 'manual'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradingType'].should == 'manual'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradeType'\] = 'point'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'point'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 80
end

And(/^\['entity'\]\.\['extensions'\]\.\['ratingAggregateType'\] = 'average'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['ratingAggregateType'].should == 'average'
end

Given(/^Updated the Advanced Forum for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @advancedForumId = configatron.advanced_forum_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@advancedForumId+"&return=0&sr=0")
  @advancedForumName = configatron.advancedforumname+'updated'
  @advancedForumDescription = configatron.advancedforumdescription+'updated'

  on CourseAdvancedForumPage do |page|
    page.advanced_forum_name_txt.wait_until_present
    page.advanced_forum_name_txt.clear
    page.advanced_forum_name_txt.set @advancedForumName

    page.advanced_forum_description_txt.click
    page.advanced_forum_description_txt.send_keys [:control, 'a']
    page.advanced_forum_description_txt.send_keys @advancedForumDescription

    page.grade_link.click
    page.grade_type_select.select 'Rating'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.advanced_forum_saveanddisplay_btn_clk

  end
end

When(/^The Advanced Forum got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @advancedForumName
  end
  moodle_logout
end

Then(/^A Course Entity for Update Advanced Forum should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] should have advanced forum name value as updated$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @advancedForumName
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['gradingType'\] = 'rating'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradingType'].should == 'rating'
end
