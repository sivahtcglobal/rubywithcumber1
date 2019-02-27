Given(/^Rated a Student Entry under a Glossary for a course$/) do
  #Rate a Student Entry by teacher
  @glossaryId = configatron.glossary_id
  @glossaryName = configatron.glossaryname_glossaryentry
  @glossaryEntryId = configatron.glossary_entry_id

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
  @rateStudentGlossaryEntryStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/glossary/view.php?id='+@glossaryId)

  on CourseTopicPage do |page|
    page.ratings_select.select '7'
    sleep(5)
  end
end

When(/^The Student Entry got successfully rated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @glossaryName
  end
  sleep(configatron.eventWaitTime)
  @rateStudentGlossaryEntryEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for rate entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @rateStudentGlossaryEntryStartTimeStamp
  @endTimeStamp = @rateStudentGlossaryEntryEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)
  puts @response

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'glossary'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['extensions']['moduleType'].should == 'glossary'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Glossary Entry Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 80
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Glossary Entry Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 14.55
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Glossary Entry Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 8.75
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Glossary Entry Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 1.49
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'glossary'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'glossary'
end

Then(/^An Event for Rate Glossary Entry should get generated and sent to CSV\.$/) do
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

And(/^Rate Glossary Entry CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Rate Glossary Entry CSV \['Page'\] Column Value = 'glossary'$/) do
  @latest_record['Page'].should == 'glossary'
end

And(/^Rate Glossary Entry CSV \['Activity Type'\] Column Value = 'glossary'$/) do
  @latest_record['Activity Type'].should == 'glossary'
end

And(/^Rate Glossary Entry CSV \['Activity Name'\] Column Value = Provided Glossary Name$/) do
  @latest_record['Activity Name'].should == configatron.glossaryname_glossaryentry
end

And(/^Rate Glossary Entry CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Rate Glossary Entry CSV \['Score'\] Column Value = Selected Rating$/) do
  @latest_record['Score'].should == '7'
end

And(/^Rate Glossary Entry CSV \['Max Score'\] Column Value = Provided Glossary Entry Max Grade$/) do
  @latest_record['Max Score'].should == '80'
end

And(/^Rate Glossary Entry CSV \['Score\(Percent\)'\] Column Value = Provided Glossary Entry Percentage$/) do
  @latest_record['Score (Percent)'].should == '8.75'
end

Then(/^An Event for Rate Glossary Entry should get generated and sent to Tableau\.$/) do
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

And(/^Rate Glossary Entry Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Rate Glossary Entry Tableau \['Page'\] Column Value = 'glossary'$/) do
  @newest_record['Page'].should == 'glossary'
end

And(/^Rate Glossary Entry Tableau \['Activity Type'\] Column Value = 'glossary'$/) do
  @newest_record['ActivityType'].should == 'glossary'
end

And(/^Rate Glossary Entry Tableau \['Activity Name'\] Column Value = Provided Glossary Name$/) do
  @newest_record['ActivityName'].should == configatron.glossaryname_glossaryentry
end

And(/^Rate Glossary Entry Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Rate Glossary Entry Tableau \['Score'\] Column Value = Selected Rating$/) do
  @newest_record['Score'].should == 7
end

And(/^Rate Glossary Entry Tableau \['Max Score'\] Column Value = Provided Glossary Entry Max Grade$/) do
  @newest_record['MaxScore'].should == 80
end

And(/^Rate Glossary Entry Tableau \['Score\(Percent\)'\] Column Value = Provided Glossary Entry Percentage$/) do
  @newest_record['Score_Percent_'].should == 8.75
end
