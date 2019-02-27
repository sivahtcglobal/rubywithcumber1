Given(/^Added a Wiki Page Comment for a course$/) do
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

  @wikiPageComments =  'at_wiki_page_comments'+@currnetTimeStamp.to_s
  configatron.wikipagecomments = @wikiPageComments

  @browser.goto(configatron.moodleURL+'/mod/wiki/view.php?id='+configatron.wiki_id)

  on WikiCommentPage do |page|
    page.comments_tab.click
    page.add_comment_link.click
    page.wiki_page_comment_txt.wait_until_present

    @addWikiPageCommentStartTimeStamp = Time.new.to_i * 1000
    page.wiki_page_comment_txt.click
    page.wiki_page_comment_txt.send_keys [:control, 'a']
    page.wiki_page_comment_txt.send_keys @wikiPageComments

    page.save_changes_btn_clk
  end
end

When(/^The Wiki Page Comment got successfully added$/) do

  on WikiCommentPage do |page|
    page.added_comment_txt.text.should == @wikiPageComments
  end
  sleep(10)
  @addWikiPageCommentEndTimeStamp = Time.new.to_i * 1000
  configatron.comment_id = get_item_id()
  moodle_logout

end

Then(/^An Event for Wiki Page Comment should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @addWikiPageCommentStartTimeStamp
  @endTimeStamp = @addWikiPageCommentEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.@type\":\"http://purl.imsglobal.org/caliper/v1/MessageEvent\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Posted'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
end

And(/^\['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'wiki_comment'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'wiki_comment'
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'wiki'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['assignable']['extensions']['moduleType'].should == 'wiki'
end

And(/^\['event'\]\.\['object'\]\.\['body'\] = Provided Wiki Page Comment$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].include? @wikiPageComments
end

Then(/^An Event for Wiki Page Comment should get generated and sent to CSV\.$/) do
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

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Action']=='Posted' }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReport}"] }.last
  puts @latest_record
end

And(/^Wiki Page Comment CSV \['Action'\] Column Value = 'Posted'$/) do
  @latest_record['Action'].should == 'Posted'
end

And(/^Wiki Page Comment CSV \['Page'\] Column Value = 'wiki_comment'$/) do
  @latest_record['Page'].should == 'wiki_comment'
end

And(/^Wiki Page Comment CSV \['Activity Type'\] Column Value = 'wiki'$/) do
  @latest_record['Activity Type'].should == 'wiki'
end

And(/^Wiki Page Comment CSV \['Activity Name'\] Column Value = Provided Wiki Name$/) do
  @latest_record['Activity Name'].should == configatron.wikinameupdated
end

And(/^Wiki Page Comment CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == 'Moodle'
end

Then(/^An Event for Wiki Page Comment should get generated and sent to Tableau\.$/) do
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

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Action']=='Posted' }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateAndTimeFieldStudentActivityReportTableau}"] }.last
  puts @newest_record
end

And(/^Wiki Page Comment Tableau \['Action'\] Column Value = 'Posted'$/) do
  @newest_record['Action'].should == 'Posted'
end

And(/^Wiki Page Comment Tableau \['Page'\] Column Value = 'wiki_comment'$/) do
  @newest_record['Page'].should == 'wiki_comment'
end

And(/^Wiki Page Comment Tableau \['Activity Type'\] Column Value = 'wiki'$/) do
  @newest_record['ActivityType'].should == 'wiki'
end

And(/^Wiki Page Comment Tableau \['Activity Name'\] Column Value = Provided Wiki Name$/) do
  @newest_record['ActivityName'].should == configatron.wikinameupdated
end

And(/^Wiki Page Comment Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == 'Moodle'
end
