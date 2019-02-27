Given(/^Graded a Journal Entry under a course$/) do
  #Grade a journal entry by teacher
  @journalId = configatron.journal_id

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

  sleep(10)
  @gradeJournalEntryStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/journal/view.php?id='+@journalId)

  on GradeJournalEntryPage do |page|
    page.view_journal_entry_link.click
    page.select_grade.select '97 / 100'
    sleep(3)

    page.save_my_feedback_btn_clk
  end
end

When(/^The Journal Entry got successfully graded$/) do

  on GradeJournalEntryPage do |page|
    page.alert_success_message.text.include? 'Feedback updated for 1 entries'
  end
  sleep(configatron.eventWaitTime)
  @gradeJournalEntryEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for grade journal entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @gradeJournalEntryStartTimeStamp
  @endTimeStamp = @gradeJournalEntryEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'journal'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['extensions']['moduleType'].should == 'journal'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Journal Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 100
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Journal Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 13.33
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Journal Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 97
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Journal Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 14.48
end

And(/^\['event'\]\.\['generated'\]\.\['totalScore'\] = Graded Journal Entry Score$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == 97
end

Then(/^An Event for Grade Journal Entry should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Graded' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Grade Journal Entry CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Grade Journal Entry CSV \['Page'\] Column Value = 'journal'$/) do
  @latest_record['Page'].should == 'journal'
end

And(/^Grade Journal Entry CSV \['Activity Type'\] Column Value = 'journal'$/) do
  @latest_record['Activity Type'].should == 'journal'
end

And(/^Grade Journal Entry CSV \['Activity Name'\] Column Value = Provided Journal Name$/) do
  @latest_record['Activity Name'].should == configatron.journalnameupdated
end

And(/^Grade Journal Entry CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Grade Journal Entry CSV \['Score'\] Column Value = Graded Journal Entry Score$/) do
  @latest_record['Score'].should == '97'
end

And(/^Grade Journal Entry CSV \['Max Score'\] Column Value = Provided Journal Max Grade$/) do
  @latest_record['Max Score'].should == '100'
end

And(/^Grade Journal Entry CSV \['Score\(Percent\)'\] Column Value = Provided Journal Percentage$/) do
  @latest_record['Score (Percent)'].should == '97'
end

Then(/^An Event for Grade Journal Entry should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Graded' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Grade Journal Entry Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Grade Journal Entry Tableau \['Page'\] Column Value = 'journal'$/) do
  @newest_record['Page'].should == 'journal'
end

And(/^Grade Journal Entry Tableau \['Activity Type'\] Column Value = 'journal'$/) do
  @newest_record['ActivityType'].should == 'journal'
end

And(/^Grade Journal Entry Tableau \['Activity Name'\] Column Value = Provided Journal Name$/) do
  @newest_record['ActivityName'].should == configatron.journalnameupdated
end

And(/^Grade Journal Entry Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Grade Journal Entry Tableau \['Score'\] Column Value = Graded Journal Entry Score$/) do
  @newest_record['Score'].should == 97
end

And(/^Grade Journal Entry Tableau \['Max Score'\] Column Value = Provided Journal Max Grade$/) do
  @newest_record['MaxScore'].should == 100
end

And(/^Grade Journal Entry Tableau \['Score\(Percent\)'\] Column Value = Provided Journal Percentage$/) do
  @newest_record['Score_Percent_'].should == 97
end
