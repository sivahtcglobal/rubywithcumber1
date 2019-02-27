Given(/^Rated a Forum under a Topic\(Discussion\) for a course$/) do
  #Rate a forum by teacher
  @advancedForumId = configatron.advanced_forum_id
  @topicStudentPost = configatron.topicstudentpost
  @studentPostId = configatron.post_id

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


  @rateForumStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/hsuforum/view.php?id='+@advancedForumId)

  on CourseTopicPage do |page|
    page.topic_new_link.wait_until_present
    page.topic_new_link_clk
    page.ratings_select.select '7'
  end
end

When(/^The Forum got successfully rated$/) do

  on CourseItemPage do |page|
    page.student_post_txt.wait_until_present
    page.student_post_txt.text.should == @topicStudentPost
  end
  sleep(configatron.eventWaitTime)
  @rateForumEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for rate forum should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @rateForumStartTimeStamp
  @endTimeStamp = @rateForumEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"


  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/OutcomeEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Graded'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
end

And(/^\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

And(/^\['event'\]\.\['generated'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Result'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Result'
end

And(/^Rate Advanced Forum \['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Advanced Forum Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 100
end

And(/^Rate Advanced Forum \['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Advanced Forum Weight Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 32.79
end

And(/^Rate Advanced Forum \['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Advanced Forum Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 7
end

And(/^Rate Advanced Forum \['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Advanced Forum Contribution Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 2.3
end

And(/^\['event'\]\.\['generated'\]\.\['totalScore'\] = Selected Rating$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == 7
end

Then(/^An Event for Rate Advanced Forum should get generated and sent to CSV\.$/) do
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

And(/^Rate Advanced Forum CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Rate Advanced Forum CSV \['Page'\] Column Value = 'hsuforum'$/) do
  @latest_record['Page'].should == 'hsuforum'
end

And(/^Rate Advanced Forum CSV \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @latest_record['Activity Type'].should == 'hsuforum'
end

And(/^Rate Advanced Forum CSV \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @latest_record['Activity Name'].should == configatron.advancedforumname+'updated'
end

And(/^Rate Advanced Forum CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Rate Advanced Forum CSV \['Score'\] Column Value = Selected Rating$/) do
  @latest_record['Score'].should == '7'
end

And(/^Rate Advanced Forum CSV \['Max Score'\] Column Value = Provided Advanced Forum Max Grade$/) do
  @latest_record['Max Score'].should == '100'
end

And(/^Rate Advanced Forum CSV \['Score\(Percent\)'\] Column Value = Provided Advanced Forum Percentage$/) do
  @latest_record['Score (Percent)'].should == '7'
end

Then(/^An Event for Rate Advanced Forum should get generated and sent to Tableau\.$/) do
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

And(/^Rate Advanced Forum Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Rate Advanced Forum Tableau \['Page'\] Column Value = 'hsuforum'$/) do
  @newest_record['Page'].should == 'hsuforum'
end

And(/^Rate Advanced Forum Tableau \['Activity Type'\] Column Value = 'hsuforum'$/) do
  @newest_record['ActivityType'].should == 'hsuforum'
end

And(/^Rate Advanced Forum Tableau \['Activity Name'\] Column Value = Provided Advanced Forum Name$/) do
  @newest_record['ActivityName'].should == configatron.advancedforumname+'updated'
end

And(/^Rate Advanced Forum Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Rate Advanced Forum Tableau \['Score'\] Column Value = Selected Rating$/) do
  @newest_record['Score'].should == 7
end

And(/^Rate Advanced Forum Tableau \['Max Score'\] Column Value = Provided Advanced Forum Max Grade$/) do
  @newest_record['MaxScore'].should == 100
end

And(/^Rate Advanced Forum Tableau \['Score\(Percent\)'\] Column Value = Provided Advanced Forum Percentage$/) do
  @newest_record['Score_Percent_'].should == 7
end
