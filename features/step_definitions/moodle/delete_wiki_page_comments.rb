Given(/^Deleted a Wiki Page Comment for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = '4'
  @courseId = configatron.courseId unless configatron.courseId == nil

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

  @browser.goto(configatron.moodleURL+'/mod/wiki/view.php?id='+configatron.wiki_id)

  on WikiCommentPage do |page|
    page.comments_tab.click
    sleep(5)

    @deleteWikiPageCommentStartTimeStamp = Time.new.to_i * 1000
    page.delete_comment_link.click
    page.delete_confirm_btn.click
  end
end

When(/^The Wiki Page Comment got successfully deleted$/) do

  on WikiCommentPage do |page|
    page.alert_message.text.include? 'Deleting comment'
  end
  sleep(10)
  @deleteWikiPageCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for Delete Wiki Page Comment should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @deleteWikiPageCommentStartTimeStamp
  @endTimeStamp = @deleteWikiPageCommentEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Deleted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

Then(/^An Event for Delete Wiki Page Comment should get generated and sent to CSV\.$/) do
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

  @afterEventSend.count.should == @beforeEventSend.count + 3

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Deleted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Delete Wiki Page Comment CSV \['Action'\] Column Value = 'Deleted'$/) do
  @latest_record['Action'].should == 'Deleted'
end

And(/^Delete Wiki Page Comment CSV \['Page'\] Column Value = 'wiki_comment'$/) do
  @latest_record['Page'].should == 'wiki_comment'
end

And(/^Delete Wiki Page Comment CSV \['Activity Type'\] Column Value = 'wiki'$/) do
  @latest_record['Activity Type'].should == 'wiki'
end

And(/^Delete Wiki Page Comment CSV \['Activity Name'\] Column Value = Provided Wiki Name$/) do
  @latest_record['Activity Name'].should == configatron.wikinameupdated
end

And(/^Delete Wiki Page Comment CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Delete Wiki Page Comment should get generated and sent to Tableau\.$/) do
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

  @afterSend['data'].length.should == @beforeSend['data'].length + 3

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Deleted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Delete Wiki Page Comment Tableau \['Action'\] Column Value = 'Deleted'$/) do
  @newest_record['Action'].should == 'Deleted'
end

And(/^Delete Wiki Page Comment Tableau \['Page'\] Column Value = 'wiki_comment'$/) do
  @newest_record['Page'].should == 'wiki_comment'
end

And(/^Delete Wiki Page Comment Tableau \['Activity Type'\] Column Value = 'wiki'$/) do
  @newest_record['ActivityType'].should == 'wiki'
end

And(/^Delete Wiki Page Comment Tableau \['Activity Name'\] Column Value = Provided Wiki Name$/) do
  @newest_record['ActivityName'].should == configatron.wikinameupdated
end

And(/^Delete Wiki Page Comment Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
