Given(/^Created a New Student Journal Entry for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @journalId = configatron.journal_id
  @journalName = configatron.journalnameupdated
  @journalEntryDescription = 'Automated Journal Entry Description'+@currnetTimeStamp.to_s

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoStudentUsername
      @password = configatron.autoStudentPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Student.exists? && page.automation_site_Student.text.include?(configatron.autoStudentUsername))
  end

  sleep(10)
  @browser.goto(configatron.moodleURL+'/mod/journal/view.php?id='+@journalId)

  on CourseJournalEntryPage do |page|
    page.start_my_journal_entry_btn.click if page.start_my_journal_entry_btn.exists?
    page.start_my_journal_entry_button.click if page.start_my_journal_entry_button.exists?
    sleep(5)
    @journalEntryStartTimeStamp = Time.new.to_i * 1000
    sleep(3)
    page.journal_entry_txt.click
    page.journal_entry_txt.send_keys [:control, 'a']
    page.journal_entry_txt.send_keys @journalEntryDescription
    page.journal_entry_save_changes_btn_clk
  end
end

When(/^The New Journal Entry got successfully created$/) do

  on CourseJournalEntryPage do |page|
    page.journal_item_breadcrumb.text.should == @journalName
  end
  sleep(10)
  @journalEntryEndTimeStamp = Time.new.to_i * 1000

end

Then(/^An Event for New Journal Entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @journalEntryStartTimeStamp
  @endTimeStamp = @journalEntryEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'journal'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'journal'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'journal_entry'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'journal_entry'
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'journal'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'journal'
end

Then(/^An Event for New Journal Entry should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^New Journal Entry CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^New Journal Entry CSV \['Page'\] Column Value = 'journal_entry'$/) do
  @latest_record['Page'].should == 'journal_entry'
end

And(/^New Journal Entry CSV \['Activity Type'\] Column Value = 'journal'$/) do
  @latest_record['Activity Type'].should == 'journal'
end

And(/^New Journal Entry CSV \['Activity Name'\] Column Value = Provided Journal Name$/) do
  @latest_record['Activity Name'].should == configatron.journalnameupdated
end

And(/^New Journal Entry CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for New Journal Entry should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^New Journal Entry Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^New Journal Entry Tableau \['Page'\] Column Value = 'journal_entry'$/) do
  @newest_record['Page'].should == 'journal_entry'
end

And(/^New Journal Entry Tableau \['Activity Type'\] Column Value = 'journal'$/) do
  @newest_record['ActivityType'].should == 'journal'
end

And(/^New Journal Entry Tableau \['Activity Name'\] Column Value = Provided Journal Name$/) do
  @newest_record['ActivityName'].should == configatron.journalnameupdated
end

And(/^New Journal Entry Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Given(/^Updated the Existing Student Journal Entry for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @journalName = configatron.journalnameupdated
  @journalEntryDescriptionUpdated = 'Automated Journal Entry Description Updated'+@currnetTimeStamp.to_s

  on CourseJournalEntryPage do |page|
    page.start_my_journal_entry_btn.click if page.start_my_journal_entry_btn.exists?
    page.start_my_journal_entry_button.click if page.start_my_journal_entry_button.exists?
    sleep(5)
    @journalEntryUpdatedStartTimeStamp = Time.new.to_i * 1000
    sleep(3)
    page.journal_entry_txt.click
    page.journal_entry_txt.send_keys [:control, 'a']
    page.journal_entry_txt.send_keys @journalEntryDescriptionUpdated
    page.journal_entry_save_changes_btn_clk
  end
end

When(/^The Existing Journal Entry got successfully updated$/) do

  on CourseJournalEntryPage do |page|
    page.journal_item_breadcrumb.text.should == @journalName
  end
  sleep(10)
  @journalEntryUpdatedEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for Update Journal Entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @journalEntryUpdatedStartTimeStamp
  @endTimeStamp = @journalEntryUpdatedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Then(/^An Event for Update Journal Entry should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Submitted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Update Journal Entry CSV \['Action'\] Column Value = 'Submitted'$/) do
  @latest_record['Action'].should == 'Submitted'
end

And(/^Update Journal Entry CSV \['Page'\] Column Value = 'journal_entry'$/) do
  @latest_record['Page'].should == 'journal_entry'
end

And(/^Update Journal Entry CSV \['Activity Type'\] Column Value = 'journal'$/) do
  @latest_record['Activity Type'].should == 'journal'
end

And(/^Update Journal Entry CSV \['Activity Name'\] Column Value = Provided Journal Name$/) do
  @latest_record['Activity Name'].should == configatron.journalnameupdated
end

And(/^Update Journal Entry CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Update Journal Entry should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleStudentActivityReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Submitted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Update Journal Entry Tableau \['Action'\] Column Value = 'Submitted'$/) do
  @newest_record['Action'].should == 'Submitted'
end

And(/^Update Journal Entry Tableau \['Page'\] Column Value = 'journal_entry'$/) do
  @newest_record['Page'].should == 'journal_entry'
end

And(/^Update Journal Entry Tableau \['Activity Type'\] Column Value = 'journal'$/) do
  @newest_record['ActivityType'].should == 'journal'
end

And(/^Update Journal Entry Tableau \['Activity Name'\] Column Value = Provided Journal Name$/) do
  @newest_record['ActivityName'].should == configatron.journalnameupdated
end

And(/^Update Journal Entry Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
