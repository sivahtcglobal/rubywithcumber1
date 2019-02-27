Given(/^Added a New Wiki for a course$/) do
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

  @wikiName =  'at_wiki_'+@currnetTimeStamp.to_s
  @wikiDescription = 'Automated Wiki Description'+@currnetTimeStamp.to_s
  @wikiFirstPageName = 'Wiki_First_Page'+@currnetTimeStamp.to_s
  @wikiPageContent = 'Automated Wiki Page Content'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'

  configatron.wikiname = @wikiName
  configatron.wikidescription = @wikiDescription
  configatron.wikifirstpagename = @wikiFirstPageName
  configatron.wikipagecontent = @wikiPageContent
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2
  puts "Course Id #{@courseId}"
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=wiki&type=&course='+@courseId+'&section=1&return=0&sr=0')
  @courseName = configatron.courseName
  on CourseWikiPage do |page|
    page.wiki_name_txt.wait_until_present
    page.wiki_name_txt.set @wikiName

    page.wiki_description_txt.click
    page.wiki_description_txt.send_keys [:control, 'a']
    page.wiki_description_txt.send_keys @wikiDescription
    page.display_description_chkbox.click
    page.wiki_mode_select.select 'Collaborative wiki'
    page.first_page_name_txt.set @wikiFirstPageName

    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set 'New_Wiki'+ @currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

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

    page.wiki_saveanddisplay_btn_clk

    #Create Wiki Page
    page.create_page_btn.wait_until_present

    page.create_page_btn_clk
    page.wiki_page_content.click
    page.wiki_page_content.send_keys [:control, 'a']
    page.wiki_page_content.send_keys @wikiPageContent
    @createWikiPageStartTimeStamp = Time.new.to_i * 1000
    page.save_btn_clk
    sleep(10)
    @createWikiPageEndTimeStamp = Time.new.to_i * 1000
  end
end

When(/^The New Wiki got successfully added$/) do

  on CourseItemPage do |page|
    page.wiki_name_link.click
    page.wiki_page_txt.text.should == @wikiName
  end

  configatron.wiki_id = get_item_id()


end

Then(/^A Course Entity for New Wiki should get generated and sent to our Raw Entity Index\.$/) do
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

  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = Wiki name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.wikiname
end

And(/^\['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'wiki'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'wiki'
end

And(/^\['entity'\]\.\['extensions'\]\.\['completionTracking'\] = 'manual'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'].should == 'manual'
end

And(/^\['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2018-10-08'
end

And(/^\['entity'\]\.\['extensions'\]\.\['wikiMode'\] = 'collaborative'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['wikiMode'].should == 'collaborative'
end

Then(/^An Event for Wiki Page should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @createWikiPageStartTimeStamp
  @endTimeStamp = @createWikiPageEndTimeStamp

  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'wiki'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'wiki'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'wiki_page'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'wiki_page'
end

And(/^The \['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'wiki'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'wiki'
end

Given(/^Updated the Wiki for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @wikiId = configatron.wiki_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@wikiId+"&return=0&sr=0")
  @wikiName = configatron.wikiname+'updated'
  @wikiDescription = configatron.wikidescription+'updated'
  @wikiPageContent = configatron.wikipagecontent+'updated'
  configatron.wikinameupdated = @wikiName
  configatron.wikidescriptionupdated = @wikiDescription
  configatron.wikipagecontentupdated = @wikiPageContent

  on CourseWikiPage do |page|
    page.wiki_name_txt.wait_until_present
    page.wiki_name_txt.clear
    page.wiki_name_txt.set @wikiName

    page.wiki_description_txt.click
    page.wiki_description_txt.send_keys [:control, 'a']
    page.wiki_description_txt.send_keys @wikiDescription

    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_completion_view_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'December'
    page.activity_completion_year_select.select '2018'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.wiki_saveanddisplay_btn_clk

    #Update Wiki Page
    page.edit_wiki_page_tab.wait_until_present
    @updateWikiPageStartTimeStamp = Time.new.to_i * 1000
    page.edit_wiki_page_tab.click
    page.wiki_page_content.click
    page.wiki_page_content.send_keys [:control, 'a']
    page.wiki_page_content.send_keys @wikiPageContent
    page.save_btn_clk

  end
end

When(/^The Wiki got successfully updated$/) do

  on CourseItemPage do |page|
    page.wiki_page_txt.text.should == @wikiName
  end
  sleep(10)
  @updateWikiPageEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^A Course Entity for Update Wiki should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Wiki name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.wikinameupdated
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['completionTracking'\] = 'conditions'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'].should == 'conditions'
end

And(/^Updated \['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Provided Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2018-12-08'
end

Then(/^An Event for Update Wiki Page should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @updateWikiPageStartTimeStamp
  @endTimeStamp = @updateWikiPageEndTimeStamp

  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end
