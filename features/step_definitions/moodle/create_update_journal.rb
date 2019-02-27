Given(/^Created a New Journal under a course$/) do
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

  @journalName =  'at_journal_'+@currnetTimeStamp.to_s
  @journalQuestion = 'Automated Journal Question'+@currnetTimeStamp.to_s
  @tagName1 = 'tag1'
  @tagName2 = 'tag2'
  configatron.journalname = @journalName
  configatron.journalquestion = @journalQuestion
  configatron.tagname1 = @tagName1
  configatron.tagname2 = @tagName2

  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=journal&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseJournalPage do |page|

    page.journal_name_txt.set @journalName

    page.journal_description_txt.click
    page.journal_description_txt.send_keys [:control, 'a']
    page.journal_description_txt.send_keys @journalQuestion
    page.days_available_select.select '10 weeks'

    #Provide Grade Parameters
    page.grade_link.click
    page.modgrade_type_select.select 'Scale'
    page.modgrade_scale_select.select 'Separate and Connected ways of knowing'
    page.grade_category_select.select 'Uncategorised'
    page.gradepass_txt.set '2'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set '123'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

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

    page.journal_saveanddisplay_btn_clk

  end
end

When(/^The New Journal got successfully created$/) do

  on CourseItemPage do |page|
    page.journal_name_link.text.should == @journalName
  end
  configatron.journal_id = get_item_id()

end

Then(/^A Course Entity for New Journal should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^\['entity'\]\.\['name'\] = Journal name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @journalName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'journal'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'journal'
end

And(/^\['entity'\]\['extensions'\]\['gradeType'\] == 'scale'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'scale'
end

And(/^\['entity'\]\['extensions'\]\['gradeScale'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeScale'].include? 'Separate and Connected ways of knowing'
end

And(/^\['entity'\]\['extensions'\]\['gradeToPass'\] == Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 2
end

And(/^\['entity'\]\['extensions'\]\['grouping'\] == false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['grouping'].should == false
end

And(/^\['entity'\]\['extensions'\]\['groupMode'\] == 'visible'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'visible'
end

And(/^\['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Provided Completion Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2018-10-08'
end

And(/^\['entity'\]\.\['extensions'\]\.\['daysAvailable'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['daysAvailable'].should == '70'
end

Given(/^Updated the existing Journal under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @journalId = configatron.journal_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@journalId+"&return=0&sr=0")
  @journalName = configatron.journalname+'updated'
  @journalQuestion = configatron.journalquestion+'updated'
  configatron.journalnameupdated = @journalName
  configatron.journalquestionupdated = @journalQuestion

  on CourseJournalPage do |page|

    page.journal_name_txt.set @journalName

    page.journal_description_txt.click
    page.journal_description_txt.send_keys [:control, 'a']
    page.journal_description_txt.send_keys @journalQuestion
    page.days_available_select.select 'Always open'

    #Update Grade Parameters
    page.grade_link.click
    page.modgrade_type_select.select 'Point'
    page.maxgrade_txt.set '100'
    page.grade_category_select.select 'Uncategorised'
    page.gradepass_txt.set '91'

    #Provide Common Module Settings Parameters
    page.common_module_settings_link.click
    page.common_module_visible_select.select 'Show'
    page.common_module_id_number_txt.set '123'+@currnetTimeStamp.to_s
    page.common_module_group_mode_select.select 'Visible groups'
    page.common_module_grouping_select.select 'None'

    #Update Activity Completion Parameters
    page.activity_completion_link.click
    page.activity_completion_tracking_select.select 'Show activity as complete when conditions are met'
    page.activity_require_view_chkbox.click
    page.activity_require_grade_chkbox.click
    page.activity_completion_day_select.select '8'
    page.activity_completion_month_select.select 'December'
    page.activity_completion_year_select.select '2018'

    #Update Tags
    page.tags_link.click
    page.delete_tag.click

    page.journal_saveanddisplay_btn_clk
  end
end

When(/^The existing Journal got successfully updated$/) do

  on CourseItemPage do |page|
    page.journal_name_link.text.should == configatron.journalnameupdated
  end
  moodle_logout

end

Then(/^A Course Entity for Update Journal should get generated and sent to our Raw Entity Index\.$/) do
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

And(/^Updated \['entity'\]\.\['name'\] = Journal name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == configatron.journalnameupdated
end

And(/^\['entity'\]\['extensions'\]\['gradeType'\] == 'point'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeType'].should == 'point'
end

And(/^\['entity'\]\['extensions'\]\['gradeToPass'\] == Updated Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 91
end

And(/^\['entity'\]\.\['extensions'\]\.\['expectedCompletionDate'\] = Updated Completion Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['expectedCompletionDate'].include? '2018-12-08'
end

And(/^\['entity'\]\.\['extensions'\]\.\['daysAvailable'\] = Updated Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['daysAvailable'].should == 'always_open'
end
