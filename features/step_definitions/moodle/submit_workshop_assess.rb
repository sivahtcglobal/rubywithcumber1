Given(/^Submit Workshop Assess Page for a Course$/) do
  @courseId = configatron.courseId unless configatron.courseId == nil
  puts "Create a New Workshop Assess for #{@courseId}"
  @workshop_id = configatron.workshop_id unless configatron.workshop_id == nil
  @workshopName = configatron.workshopname unless configatron.workshopname == nil

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
  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  @currnetTimeStamp = Time.new.to_i * 1000

  on CourseWorkshopAssessPage do |page|
    page.allocate_submissions_link.click
    sleep(5)
    page.add_reviewer_select.select configatron.autoStudentUsername+'_fname '+configatron.autoStudentUsername+'_lname'
    @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
    page.switch_to_the_next_phase_link.click if page.switch_to_the_next_phase_link.exists?
    page.assessment_switch_to_the_next_phase_image.click if page.assessment_switch_to_the_next_phase_image.exists?
    page.continue_assessment_phase_btn_clk if page.continue_assessment_phase_btn.exists?
    page.continue_assessment_phase_button_clk if page.continue_assessment_phase_button.exists?
    moodle_logout
  end

  on MoodleHomePage do |page|
    begin
      moodle_logout if page.profile_dropdown.exists?
      @username = configatron.autoStudentUsername
      @password = configatron.autoStudentPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Student.exists? && page.automation_site_Student.text.include?(configatron.autoStudentUsername))
  end
  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  on CourseWorkshopAssessPage do |page|
    page.assess_btn.click
    page.aspect1_select.select '9 / 10'
    page.comment_aspect1_txt.send_keys 'Comment for Aspect'
    page.overall_feedback_txt.send_keys 'Overall feedback'
    @browser.execute_script('arguments[0].scrollIntoView();', page.add_attachment_btn)
    page.saveandclose_btn.click
  end
end

When(/^Workshop Assess got submitted successfully$/) do

  on CourseWorkshopAssessPage do |page|
    page.assess_yourself_txt.text.include? 'Assess yourself'
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Workshop Assess submitted Page should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"workshop_submission_assessed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'workshop_submission_assessed'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'workshop_submission_assessed'
end

Then(/^An Event for Workshop Assess submitted Page should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Modified' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Workshop Assess submitted Page CSV \['Action'\] Column Value = 'Modified'$/) do
  @latest_record['Action'].should == 'Modified'
end

And(/^Workshop Assess submitted Page CSV \['Page'\] Column Value = 'workshop_submission'$/) do
  @latest_record['Page'].should == 'workshop_submission'
end

And(/^Workshop Assess submitted Page CSV \['Activity Type'\] Column Value = 'workshop'$/) do
  @latest_record['Activity Type'].should == 'workshop'
end

And(/^Workshop Assess submitted Page CSV \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @latest_record['Activity Name'].should == configatron.workshopname
end

And(/^Workshop Assess submitted Page CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Workshop Assess submitted Page should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Modified' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Workshop Assess submitted Page Tableau \['Action'\] Column Value = 'Modified'$/) do
  @newest_record['Action'].should == 'Modified'
end

And(/^Workshop Assess submitted Page Tableau \['Page'\] Column Value = 'workshop_submission'$/) do
  @newest_record['Page'].should == 'workshop_submission'
end

And(/^Workshop Assess submitted Page Tableau \['Activity Type'\] Column Value = 'workshop'$/) do
  @newest_record['ActivityType'].should == 'workshop'
end

And(/^Workshop Assess submitted Page Tableau \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @newest_record['ActivityName'].should == configatron.workshopname
end

And(/^Workshop Assess submitted Page Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

Given(/^Submit Workshop Re-assess Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  puts "Submit Re-assess for #{@courseId}"
  @workshop_id = configatron.workshop_id unless configatron.workshop_id == nil
  @workshopName = configatron.workshopname unless configatron.workshopname == nil

  on MoodleHomePage do |page|
    begin
      moodle_logout if page.profile_dropdown.exists?
      @username = configatron.autoStudentUsername
      @password = configatron.autoStudentPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Student.exists? && page.automation_site_Student.text.include?(configatron.autoStudentUsername))
  end
  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  on CourseWorkshopAssessPage do |page|
    page.re_assess_btn.click
    page.aspect1_select.select '8 / 10'
    page.comment_aspect1_txt.clear
    page.comment_aspect1_txt.send_keys 'Comment for Aspect'

    page.overall_feedback_txt.click
    page.overall_feedback_txt.send_keys [:control, 'a']
    page.overall_feedback_txt.send_keys 'Overall feedback'

    @browser.execute_script('arguments[0].scrollIntoView();', page.add_attachment_btn)
    page.saveandclose_btn.click
  end
end

When(/^Workshop Re-assess got submitted successfully$/) do

  on CourseWorkshopAssessPage do |page|
    page.assess_yourself_txt.text.include? 'Assess yourself'
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Workshop Re-assess submitted Page should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"workshop_submission_assessed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

Then(/^An Event for Workshop Re\-assess submitted Page should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Modified' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Workshop Re\-assess submitted Page CSV \['Action'\] Column Value = 'Modified'$/) do
  @latest_record['Action'].should == 'Modified'
end

And(/^Workshop Re\-assess submitted Page CSV \['Page'\] Column Value = 'workshop_submission'$/) do
  @latest_record['Page'].should == 'workshop_submission'
end

And(/^Workshop Re\-assess submitted Page CSV \['Activity Type'\] Column Value = 'workshop'$/) do
  @latest_record['Activity Type'].should == 'workshop'
end

And(/^Workshop Re\-assess submitted Page CSV \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @latest_record['Activity Name'].should == configatron.workshopname
end

And(/^Workshop Re\-assess submitted Page CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Workshop Re\-assess submitted Page should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Modified' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Workshop Re\-assess submitted Page Tableau \['Action'\] Column Value = 'Modified'$/) do
  @newest_record['Action'].should == 'Modified'
end

And(/^Workshop Re\-assess submitted Page Tableau \['Page'\] Column Value = 'workshop_submission'$/) do
  @newest_record['Page'].should == 'workshop_submission'
end

And(/^Workshop Re\-assess submitted Page Tableau \['Activity Type'\] Column Value = 'workshop'$/) do
  @newest_record['ActivityType'].should == 'workshop'
end

And(/^Workshop Re\-assess submitted Page Tableau \['Activity Name'\] Column Value = Provided Workshop Name$/) do
  @newest_record['ActivityName'].should == configatron.workshopname
end

And(/^Workshop Re\-assess submitted Page Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
