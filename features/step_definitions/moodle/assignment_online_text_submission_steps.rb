Given(/^Login as Valid Moodle Student user$/) do

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      @username = configatron.autoStudentUsername
      @password = configatron.autoStudentPassword
      log_in_moodle(@username,@password)
    end
  end
 end

When(/^Create online text submission is succesfully added$/) do
  sleep(3)
    @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + configatron.courseId)
    on AddSubmissionPage do |page|
      if page.add_submission.present?
        page.add_submission.click
      else
        page.edit_submission.click
      end
      sleep(5)
      page.online_text_select.send_keys 'Online submission test'
      @startTimeStamp = Time.new.to_i * 1000
      page.save_change_button.click
      sleep(5)
      @endTimeStamp = Time.new.to_i * 1000
      if page.error_comments.exists?
      puts 'Error exist during adding submission'
    else
      puts 'No Error'
     end
  page.continue_link.click
  sleep(2)
end
end

Then(/^A Submitted Event for the Given Course should get generated and sent to our Raw Event Index$/) do
  on AddSubmissionPage do |page|
    @tokenhost = configatron.moodleWorkbench
    @tokenuser = configatron.tokenuser
    @tokenpass = configatron.tokenpass
    @intellistream = configatron.moodleEventStream
    @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
    @posturl =  File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
        @streamDelayTime = configatron.streamDelayTime
    sleep(5)
    @query = "{\"query\":{\"filtered\":{\"filter\":{\"and\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}},{\"term\":{\"event.@type\":\"http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent\"}}]}}}}"
    puts @query
    @response = post_request(@posturl,@query,@apitoken)
    puts @response.to_json
    @hits = @response['hits']['total']
    @hits.should == 1

  end
  end


When(/^Edit online text submission is succesfully added$/) do
  @browser.goto(configatron.moodleURL+'/mod/assign/view.php?id=' + configatron.courseId)
  on AddSubmissionPage do |page|
    if page.add_submission.present?
      page.add_submission.click
    else
      page.edit_submission.click
    end
    sleep(5)
    page.online_text_select.send_keys 'Online submission test'
    @startTimeStamp = Time.new.to_i * 1000
    page.save_change_button.click
    sleep(5)
    @endTimeStamp = Time.new.to_i * 1000
    if page.error_comments.exists?
      puts 'Error exist during adding submission'
    else
      puts 'No Error'
    end
    page.continue_link.click
    sleep(2)
  end
end
And(/^Onlinetext submission\['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentItemEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
end

And(/^Onlinetext submission\['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Completed'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
end

And(/^Onlinetext submission\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentItem'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
end

And(/^Onlinetext submission\['event'\]\.\['generated'\]\.\['@id'\] value includes the assignment id submitted by student$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@id'].include?("id=" + @assignmentId)
end

And(/^Onlinetext submission\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'assign_text'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'assign_text'
end

And(/^Onlinetext submission\['event'\]\.\['generated'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Onlinetext submission\['event'\]\.\['generated'\]\.\['assignable'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Onlinetext submission\['event'\]\.\['generated'\]\.\['assignable'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^Onlinetext submission\['event'\]\.\['generated'\]\.\['assignable'\]\.\['extensions'\]\.\['moduleType'\] = 'assign'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'assign'
end

And(/^Onlinetext submission\['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Onlinetext submission\['event'\]\.\['object'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Entity'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Entity'
end

And(/^Onlinetext submission\['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Onlinetext submission\['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^Onlinetext submission\['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end
And(/^Onlinetext submission\['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']
end

And(/^Onlinetext submission\['event'\]\.\['generated'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

And(/^Onlinetext submission\['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end