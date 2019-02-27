Given(/^Added a New Glossary Entry for a course$/) do
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

  @glossaryName =  'at_glossary_'+@currnetTimeStamp.to_s
  @glossaryDescription = 'Automated Glossary Description'+@currnetTimeStamp.to_s
  @glossaryEntryConcept = 'at_glossary_entry'+@currnetTimeStamp.to_s
  @glossaryEntryDefinition = 'Automated Glossary Entry Definition'+@currnetTimeStamp.to_s
  @glossaryEntryKeywords = 'Automated_Glossary_Entry_Keyword'+@currnetTimeStamp.to_s
  configatron.glossaryname_glossaryentry = @glossaryName
  configatron.glossarydescription = @glossaryDescription
  configatron.glossaryentryconcept = @glossaryEntryConcept
  configatron.glossaryentrydefinition = @glossaryEntryDefinition
  configatron.glossaryentrykeywords = @glossaryEntryKeywords
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=glossary&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseGlossaryPage do |page|
    page.glossary_name_txt.wait_until_present
    page.glossary_name_txt.set @glossaryName

    page.glossary_description_txt.click
    page.glossary_description_txt.send_keys [:control, 'a']
    page.glossary_description_txt.send_keys @glossaryDescription
    page.display_description_chkbox.click

    #Provide Rating Parameters
    page.ratings_link.click
    page.ratings_assessed_select.select 'Average of ratings'
    page.ratings_scale_grade_type_select.select 'Point'
    page.ratings_scale_grade_point_txt.set '80'
    page.ratings_rating_time_chkbox.click
    page.ratings_from_day_select.select '1'
    page.ratings_from_month_select.select 'January'
    page.ratings_from_year_select.select '2017'
    page.ratings_from_hour_select.select '08'
    page.ratings_from_minute_select.select '05'
    page.ratings_to_day_select.select '31'
    page.ratings_to_month_select.select 'December'
    page.ratings_to_year_select.select '2018'
    page.ratings_to_hour_select.select '18'
    page.ratings_to_minute_select.select '05'

    page.glossary_saveanddisplay_btn_clk

    configatron.glossary_id = get_item_id()
    sleep(10)
    @addGlossaryEntryStartTimeStamp = Time.new.to_i * 1000
  end

  on CourseItemPage do |page|
    page.add_a_new_glossary_entry_btn_clk
  end

  on CourseGlossaryEntryPage do |page|
    page.glossary_entry_concept_txt.wait_until_present
    page.glossary_entry_concept_txt.set @glossaryEntryConcept

    page.glossary_entry_definition_txt.click
    page.glossary_entry_definition_txt.send_keys [:control, 'a']
    page.glossary_entry_definition_txt.send_keys @glossaryEntryDefinition

    page.keywords_txt_area.click
    page.keywords_txt_area.send_keys [:control, 'a']
    page.keywords_txt_area.send_keys @glossaryEntryKeywords

    page.auto_linking_dynamic_link_chkbox.click
    page.auto_linking_case_sensitive_chkbox.click
    page.auto_linking_full_match_chkbox.click

    page.glossary_entry_save_changes_btn_clk
  end

end

When(/^The New Glossary Entry got successfully added$/) do

  on CourseItemPage do |page|
    page.glossary_entry_concept_lbl.text.should == @glossaryEntryConcept
  end
  sleep(10)
  @addGlossaryEntryEndTimeStamp = Time.new.to_i * 1000
  configatron.glossary_entry_id = get_item_id()

end

Then(/^An Event for New Glossary Entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @addGlossaryEntryStartTimeStamp
  @endTimeStamp = @addGlossaryEntryEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'glossary'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'glossary'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'glossary_entry'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'glossary_entry'
end

Given(/^Updated the Existing Glossary Entry for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @glossaryId = configatron.glossary_id
  @glossaryEntryId = configatron.glossary_entry_id
  @browser.goto(configatron.moodleURL+"/mod/glossary/edit.php?cmid="+@glossaryId+"&id="+@glossaryEntryId+"&mode=entry&hook="+@glossaryEntryId)

  @glossaryEntryConcept = configatron.glossaryentryconcept+'updated'
  @glossaryEntryDefinition = configatron.glossaryentrydefinition+'updated'

  on CourseGlossaryEntryPage do |page|
    page.glossary_entry_concept_txt.wait_until_present
    @updateGlossaryEntryStartTimeStamp = Time.new.to_i * 1000
    page.glossary_entry_concept_txt.set @glossaryEntryConcept

    page.glossary_entry_definition_txt.click
    page.glossary_entry_definition_txt.send_keys [:control, 'a']
    page.glossary_entry_definition_txt.send_keys @glossaryEntryDefinition

    page.glossary_entry_save_changes_btn_clk
  end
end

When(/^The Existing Glossary Entry got successfully updated$/) do

  on CourseItemPage do |page|
    page.glossary_entry_concept_lbl.text.should == @glossaryEntryConcept
  end
  sleep(10)
  @updateGlossaryEntryEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^An Event for Update Glossary Entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @updateGlossaryEntryStartTimeStamp
  @endTimeStamp = @updateGlossaryEntryEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Given(/^Added a New Student Glossary Entry for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @glossaryId = configatron.glossary_id
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  @glossaryEntryConcept = 'at_glossary_entry'+@currnetTimeStamp.to_s
  @glossaryEntryDefinition = 'Automated Glossary Entry Definition'+@currnetTimeStamp.to_s
  @glossaryEntryKeywords = 'Automated_Glossary_Entry_Keyword'+@currnetTimeStamp.to_s
  configatron.studentglossaryentryconcept = @glossaryEntryConcept
  configatron.studentglossaryentrydefinition = @glossaryEntryDefinition
  configatron.studentglossaryentrykeywords = @glossaryEntryKeywords
  @browser.goto(configatron.moodleURL+'/mod/glossary/edit.php?cmid='+@glossaryId)

  on CourseGlossaryEntryPage do |page|
    page.glossary_entry_concept_txt.wait_until_present
    @addGlossaryEntryStartTimeStamp = Time.new.to_i * 1000
    page.glossary_entry_concept_txt.set @glossaryEntryConcept

    page.glossary_entry_definition_txt.click
    page.glossary_entry_definition_txt.send_keys [:control, 'a']
    page.glossary_entry_definition_txt.send_keys @glossaryEntryDefinition

    page.keywords_txt_area.click
    page.keywords_txt_area.send_keys [:control, 'a']
    page.keywords_txt_area.send_keys @glossaryEntryKeywords

    page.glossary_entry_save_changes_btn_clk
  end
end

Then(/^An Event for New Student Glossary Entry should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("http://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^New Student Glossary Entry CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^New Student Glossary Entry CSV \['Page'\] Column Value = 'glossary_entry'$/) do
  @latest_record['Page'].should == 'glossary_entry'
end

And(/^New Student Glossary Entry CSV \['Activity Type'\] Column Value = 'glossary'$/) do
  @latest_record['Activity Type'].should == 'glossary'
end

And(/^New Student Glossary Entry CSV \['Activity Name'\] Column Value = Provided Glossary Name$/) do
  @latest_record['Activity Name'].should == configatron.glossaryname_glossaryentry
end

And(/^New Student Glossary Entry CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for New Student Glossary Entry should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("http://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^New Student Glossary Entry Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^New Student Glossary Entry Tableau \['Page'\] Column Value = 'glossary_entry'$/) do
  @newest_record['Page'].should == 'glossary_entry'
end

And(/^New Student Glossary Entry Tableau \['Activity Type'\] Column Value = 'glossary'$/) do
  @newest_record['ActivityType'].should == 'glossary'
end

And(/^New Student Glossary Entry Tableau \['Activity Name'\] Column Value = Provided Glossary Name$/) do
  @newest_record['ActivityName'].should == configatron.glossaryname_glossaryentry
end

And(/^New Student Glossary Entry Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Given(/^Updated the Existing Student Glossary Entry for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @glossaryId = configatron.glossary_id
  @glossaryEntryId = configatron.glossary_entry_id
  @browser.goto(configatron.moodleURL+"/mod/glossary/edit.php?cmid="+@glossaryId+"&id="+@glossaryEntryId+"&mode=entry&hook="+@glossaryEntryId)

  @glossaryEntryConcept = configatron.studentglossaryentryconcept+'updated'
  @glossaryEntryDefinition = configatron.studentglossaryentrydefinition+'updated'
  @glossaryEntryKeywords = configatron.studentglossaryentrykeywords+'updated'

  on CourseGlossaryEntryPage do |page|
    page.glossary_entry_concept_txt.wait_until_present
    @updateGlossaryEntryStartTimeStamp = Time.new.to_i * 1000
    page.glossary_entry_concept_txt.set @glossaryEntryConcept

    page.glossary_entry_definition_txt.click
    page.glossary_entry_definition_txt.send_keys [:control, 'a']
    page.glossary_entry_definition_txt.send_keys @glossaryEntryDefinition

    page.keywords_txt_area.click
    page.keywords_txt_area.send_keys [:control, 'a']
    page.keywords_txt_area.send_keys @glossaryEntryKeywords

    page.glossary_entry_save_changes_btn_clk
  end
end

Then(/^An Event for Update Student Glossary Entry should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("http://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Update Student Glossary Entry CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Update Student Glossary Entry CSV \['Page'\] Column Value = 'glossary_entry'$/) do
  @latest_record['Page'].should == 'glossary_entry'
end

And(/^Update Student Glossary Entry CSV \['Activity Type'\] Column Value = 'glossary'$/) do
  @latest_record['Activity Type'].should == 'glossary'
end

And(/^Update Student Glossary Entry CSV \['Activity Name'\] Column Value = Provided Glossary Name$/) do
  @latest_record['Activity Name'].should == configatron.glossaryname_glossaryentry
end

And(/^Update Student Glossary Entry CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Update Student Glossary Entry should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("http://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Update Student Glossary Entry Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Update Student Glossary Entry Tableau \['Page'\] Column Value = 'glossary_entry'$/) do
  @newest_record['Page'].should == 'glossary_entry'
end

And(/^Update Student Glossary Entry Tableau \['Activity Type'\] Column Value = 'glossary'$/) do
  @newest_record['ActivityType'].should == 'glossary'
end

And(/^Update Student Glossary Entry Tableau \['Activity Name'\] Column Value = Provided Glossary Name$/) do
  @newest_record['ActivityName'].should == configatron.glossaryname_glossaryentry
end

And(/^Update Student Glossary Entry Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
