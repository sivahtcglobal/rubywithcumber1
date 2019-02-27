Given(/^Submit Workshop grading Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Workshop grading for #{@courseId}"
  @workshop_id = configatron.workshop_id unless configatron.workshop_id == nil
  @workshopName = configatron.workshopname unless configatron.workshopname == nil

  on MoodleHomePage do |page|
    @username = configatron.autoTeacherUsername
    @password = configatron.autoTeacherPassword
    log_in_moodle(@username,@password)
  end
  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  on CourseWorkshopGradingPage do |page|
    page.switch_to_the_next_phase_link.click if page.switch_to_the_next_phase_link.exists?
    page.closed_switch_to_the_next_phase_image.click if page.closed_switch_to_the_next_phase_image.exists?
    page.continue_assessment_phase_btn_clk if page.continue_assessment_phase_btn.exists?
    page.continue_assessment_phase_button_clk if page.continue_assessment_phase_button.exists?
  end

end

When(/^Workshop grading got submitted successfully$/) do

  on CourseWorkshopGradingPage do |page|
    page.closed_txt.text.should == 'Closed'
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Workshop grading submitted Page should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 2
end

And(/^\['event'\]\.\['@type'\] ='http:\/\/purl\.imsglobal\.org\/caliper\/v1\/OutcomeEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['extensions']['moduleType'].should == 'workshop'
end

Then(/^An Event for Workshop Phase Switched should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.object.extensions.phase\":\"closed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Modified'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'workshop'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['phase'\] = 'closed'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['phase'].should == 'closed'
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'workshop_phase_changed'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'workshop_phase_changed'
end

Then(/^An Event for Submit Workshop Grading should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 2

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Graded' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Submit Workshop Grading CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Submit Workshop Grading CSV \['Page'\] Column Value = 'workshop'$/) do
  @latest_record['Page'].should == 'workshop'
end

And(/^Submit Workshop Grading CSV \['Activity Type'\] Column Value = 'workshop'$/) do
  @latest_record['Activity Type'].should == 'workshop'
end

And(/^Submit Workshop Grading CSV \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @latest_record['Activity Name'].should == configatron.workshopname
end

And(/^Submit Workshop Grading CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Submit Workshop Grading should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 2

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Graded' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Submit Workshop Grading Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Submit Workshop Grading Tableau \['Page'\] Column Value = 'workshop'$/) do
  @newest_record['Page'].should == 'workshop'
end

And(/^Submit Workshop Grading Tableau \['Activity Type'\] Column Value = 'workshop'$/) do
  @newest_record['ActivityType'].should == 'workshop'
end

And(/^Submit Workshop Grading Tableau \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @newest_record['ActivityName'].should == configatron.workshopname
end

And(/^Submit Workshop Grading Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
