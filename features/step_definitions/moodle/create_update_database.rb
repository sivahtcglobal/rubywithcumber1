Given(/^Created a New Database Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Database for #{@courseId}"
  @databaseName = 'DatabaseAuto_' + @currnetTimeStamp.to_s
  configatron.databasename = @databaseName

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

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=data&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseDatabasePage do |page|
    page.database_name_txt.set @databaseName
    page.database_description_txt.send_keys @databaseName + ' Description'
    page.show_description_chkbox.click

    page.entries_link.click
    page.approval_select.select 'No'
    #page.manageapproved_select.select 'Yes'
    page.comments_select.select 'No'
    page.requiredentries_select.select 'None'
    page.requiredentriestoview_select.select 'None'
    page.maxentries_select.select 'None'

    page.availability_link.click

    page.grade_link.click

    page.ratings_link.click
    page.assessed_select.select 'Average of ratings'
    page.scale_modgrade_type_select.select 'Point'
    page.scale_modgrade_point_txt.clear
    page.scale_modgrade_point_txt.send_keys '10'
    #page.ratingtime_chkbox.click

    page.common_module_settings_link.click
    page.visible_select.select 'Show'
    #page.cmidnumber_txt.set @currnetTimeStamp
    page.id_groupmode_select.select 'No groups'
    #page.id_groupingid_select.select 'None'

    page.restrict_access_link.click

    page.activity_completion_link.click
    page.completion_select.select 'Show activity as complete when conditions are met'
    page.completion_view_chkbox.click
    page.completion_use_grade_chkbox.click
    page.completion_expected_enabled_chkbox.click

    page.tags_link.click
    page.enter_tags.send_keys '25'
    @browser.send_keys :enter

    page.competencies_link.click
    page.competency_rule_select.select 'Send for review'

    page.database_saveanddisplay_btn.click

    page.presets_link.wait_until_present
    page.presets_link.click
    page.fields_link.wait_until_present
    page.fields_link.click
    page.create_new_field_select.select 'Text input'
    page.text_field_name_txt.send_keys 'Full Name'
    page.required_chkbox.click
    page.add_btn.click
    page.create_new_field_select.wait_until_present
    page.create_new_field_select.select 'Checkbox'
    page.text_field_name_txt.send_keys 'Color'
    page.required_chkbox.click
    page.options_list.send_keys 'Blue'
    page.add_btn.click

    page.save_btn.click
    page.templates_link.click
    page.templates_add_btn.click
    page.add_entry_link.click
    page.new_entry_name_txt.send_keys 'masterEntry'
    page.color_chkbox.click
    page.entry_saveandview_btn.click
    page.view_list_link.click
    page.view_single_link.click
    page.search_link.click
    page.export_link.click
    page.presets_link.click
  end

end

When(/^The New Database Page Got successfully created$/) do

  on CourseDatabasePage do |page|
    page.course_item_breadcrumb_databasename.click
    page.course_item_breadcrumb_databasename.text.should == @databaseName
  end
  sleep(15)
  configatron.database_id = get_item_id()

end

Then(/^An Entity for New Database Page should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Provided Database Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.databasename
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'data'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'data'
end

Given(/^Updated the New Database for the Given Course$/) do
  @database_id = configatron.database_id
  @currnetTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/data/view.php?id=' + @database_id.to_s)
  on CourseDatabasePage do |page|
    page.database_edit_dropdown.click if page.database_edit_dropdown.exists?
    page.database_edit_link.wait_until_present
    page.database_edit_link.click
  end

  @databaseName = 'AutoUpdated' + @currnetTimeStamp.to_s
  configatron.databasename = @databaseName
  @description =  @databaseName + ' Description'
  on CourseDatabasePage do |page|
    page.database_name_txt.clear
    page.database_name_txt.set @databaseName
    page.database_description_txt.send_keys @description
    page.database_saveanddisplay_btn.click
  end

end

When(/^The Database Got successfully Updated for the Given Course$/) do
  on CourseDetailPage do |page|
    puts @databaseName
    configatron.databasename = @databaseName
  end
  moodle_logout
end

Then(/^A Course Entity for the Updated Database should get generated and sent to our Raw Entity Index\.$/) do
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
  sleep(configatron.eventWaitTime)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^Updated Name \['entity'\]\.\['name'\] = Provided Database Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.databasename
end
