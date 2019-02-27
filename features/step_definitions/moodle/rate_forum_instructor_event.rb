Given(/^Rated a Forum Post under a Discussion for a course$/) do
  #Rate a forum post by teacher
  @forumId = configatron.forum_id
  @topicStudentMessage = configatron.topicstudentmessage
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

  @rateForumPostStartTimeStamp = Time.new.to_i * 1000
  @browser.goto(configatron.moodleURL+'/mod/forum/view.php?id='+@forumId)

  on CourseTopicPage do |page|
    page.reply_link.wait_until_present
    page.reply_link_clk
    page.ratings_select.select '78'
  end
end

When(/^The Forum Post got successfully rated$/) do

  on CourseItemPage do |page|
    page.student_message_txt.text.should == @topicStudentMessage
  end
  sleep(configatron.eventWaitTime)
  @rateForumPostEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for rate forum post should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @rateForumPostStartTimeStamp
  @endTimeStamp = @rateForumPostEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Graded\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'forum'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['assignable']['extensions']['moduleType'].should == 'forum'
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['maxGrade'\] = Provided Max Grade$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['maxGrade'].should == 85
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['weight'\] = Calculated Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['weight'].should == 21.8
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['percentage'\] = Provided Percentage$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['percentage'].should == 1.18
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['contributionToCourseTotal'\] = Calculated Value$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['contributionToCourseTotal'].should == 0.26
end

And(/^\['event'\]\.\['generated'\]\.\['totalScore'\] = Selected Forum Post Rating$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['totalScore'].should == 1
end

Then(/^An Event for Rate a Forum Post should get generated and sent to CSV\.$/) do
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

And(/^Rate a Forum Post CSV \['Action'\] Column Value = 'Graded'$/) do
  @latest_record['Action'].should == 'Graded'
end

And(/^Rate a Forum Post CSV \['Page'\] Column Value = 'forum'$/) do
  @latest_record['Page'].should == 'forum'
end

And(/^Rate a Forum Post CSV \['Activity Type'\] Column Value = 'forum'$/) do
  @latest_record['Activity Type'].should == 'forum'
end

And(/^Rate a Forum Post CSV \['Activity Name'\] Column Value = Provided Forum Name$/) do
  @latest_record['Activity Name'].should == configatron.forumname+'updated'
end

And(/^Rate a Forum Post CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

And(/^Rate a Forum Post CSV \['Score'\] Column Value = Selected Forum Post Rating$/) do
  @latest_record['Score'].should == '1'
end

And(/^Rate a Forum Post CSV \['Max Score'\] Column Value = Provided Max Grade$/) do
  @latest_record['Max Score'].should == '85'
end

And(/^Rate a Forum Post CSV \['Score\(Percent\)'\] Column Value = Provided Percentage$/) do
  @latest_record['Score (Percent)'].should == '1.18'
end

Then(/^An Event for Rate a Forum Post should get generated and sent to Tableau\.$/) do
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

And(/^Rate a Forum Post Tableau \['Action'\] Column Value = 'Graded'$/) do
  @newest_record['Action'].should == 'Graded'
end

And(/^Rate a Forum Post Tableau \['Page'\] Column Value = 'forum'$/) do
  @newest_record['Page'].should == 'forum'
end

And(/^Rate a Forum Post Tableau \['Activity Type'\] Column Value = 'forum'$/) do
  @newest_record['ActivityType'].should == 'forum'
end

And(/^Rate a Forum Post Tableau \['Activity Name'\] Column Value = Provided Forum Name$/) do
  @newest_record['ActivityName'].should == configatron.forumname+'updated'
end

And(/^Rate a Forum Post Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end

And(/^Rate a Forum Post Tableau \['Score'\] Column Value = Selected Forum Post Rating$/) do
  @newest_record['Score'].should == 1
end

And(/^Rate a Forum Post Tableau \['Max Score'\] Column Value = Provided Max Grade$/) do
  @newest_record['MaxScore'].should == 85
end

And(/^Rate a Forum Post Tableau \['Score\(Percent\)'\] Column Value = Provided Percentage$/) do
  @newest_record['Score_Percent_'].should == 1.18
end
