Given(/^Started a Quiz Attempt for a instructor course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @quizId = configatron.quizId
  @quizName = configatron.updatedquizname

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

  @browser.goto(configatron.moodleURL+'/mod/quiz/view.php?id='+@quizId)
  sleep(10)
  @startQuizAttemptStartTimeStamp = Time.new.to_i * 1000

  on QuizAttemptPage do |page|
    page.preview_quiz if page.preview_quiz.exists?
    page.attempt_quiz_btn_clk if page.attempt_quiz_btn.exists?
    page.attempt_quiz_button_clk if page.attempt_quiz_button.exists?
    sleep(3)
    page.start_attempt_btn_clk if page.start_attempt_btn.exists?
  end
end

When(/^The Quiz Attempt got successfully started by instructor$/) do

  on QuizAttemptPage do |page|
   page.preview_quiz.click
  @startQuizAttemptEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end
end
Then(/^An Event for Quiz Attempt Started should get generated for instructor and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @startQuizAttemptStartTimeStamp
  @endTimeStamp = @startQuizAttemptEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Started\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)
  puts @response.to_json
  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssessmentEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
end

And(/^\['event'\]\['action'\] == 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Started'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Started'
end

And(/^\['event'\]\['actor'\]\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\['actor'\]\['@id'\] == 'http:\/\/moodleserver\.dev\.master\.us\-west\-2\.prod\.aws\.intellify\.io\/entities\/user\/10'$/) do |arg|
  @response['hits']['hits'][0]['_source']['event']['actor']['@id'].should == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io/entities/user/10'
end

And(/^\['event'\]\['actor'\]\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^\['event'\]\['edApp'\]\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\['edApp'\]\['@id'\] == 'http:\/\/moodleserver\.dev\.master\.us\-west\-2\.prod\.aws\.intellify\.io'$/) do |arg|
  @response['hits']['hits'][0]['_source']['event']['edApp']['@id'].should == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
end

And(/^\['event'\]\['edApp'\]\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^\['event'\]\['edApp'\]\['name'\] == 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end

And(/^\['event'\]\['generated'\]\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\['generated'\]\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/Attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Attempt'
end

And(/^\['event'\]\['generated'\]\['assignable'\]\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\['generated'\]\['assignable'\]\['@id'\] == 'http:\/\/moodleserver\.dev\.master\.us\-west\-2\.prod\.aws\.intellify\.io\/entities\/quiz\/52'$/) do |arg|
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@id'].should == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io/entities/quiz/52'
end

And(/^\['event'\]\['generated'\]\['assignable'\]\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['event'\]\['generated'\]\['assignable'\]\['extensions'\]\['moduleType'\] == 'quiz'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['assignable']['extensions']['moduleType'].should == 'quiz'
end

And(/^\['event'\]\['generated'\]\['count'\] == '1'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['count'].should == 1
end

And(/^\['event'\]\['generated'\]\['extensions'\]\['moduleType'\] == 'quiz_attempt_preview'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'quiz_attempt_preview'
end

And(/^\['event'\]\['object'\]\['@context'\] == 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\['object'\]\['@id'\] == 'http:\/\/moodleserver\.dev\.master\.us\-west\-2\.prod\.aws\.intellify\.io\/entities\/quiz\/52'$/) do |arg|
  @response['hits']['hits'][0]['_source']['event']['object']['@id'].should == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io/entities/quiz/52'
end

And(/^\['event'\]\['object'\]\['@type'\] == 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/AssignableDigitalResource'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
end

And(/^\['event'\]\['object'\]\['extensions'\]\['moduleType'\] == 'quiz'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'quiz'
end