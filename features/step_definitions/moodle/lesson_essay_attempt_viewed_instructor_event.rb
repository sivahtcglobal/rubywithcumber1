Given(/^Lesson Essay Attempt Viewed for a course$/) do
  #Essay Attempt Viewed by teacher
  @lessonId = configatron.lessonId

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

  @browser.goto(configatron.moodleURL+'/mod/lesson/essay.php?id='+@lessonId)
  sleep(10)

  on GradeReportPage do |page|
    @essayAttemptViewedStartTimeStamp = Time.new.to_i * 1000
    sleep(5)
    page.essay_question_link.click
  end
end

When(/^The Essay Attempt got successfully viewed by instructor$/) do

  on GradeReportPage do |page|
    page.student_response_txt.text.should == configatron.essayanswer
  end
  sleep(10)
  @essayAttemptViewedEndTimeStamp = Time.new.to_i * 1000
  moodle_logout

end

Then(/^An Event for Essay Attempt Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @essayAttemptViewedStartTimeStamp
  @endTimeStamp = @essayAttemptViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.target.extensions.moduleType\":\"lesson_essay_attempt\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['target'\]\.\['name'\] = Provided Essay Name$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['name'].should == configatron.essaytitle
end

And(/^\['event'\]\.\['target'\]\.\['extensions'\]\.\['moduleType'\] = 'lesson_essay_attempt'$/) do
  @response['hits']['hits'][0]['_source']['event']['target']['extensions']['moduleType'].should == 'lesson_essay_attempt'
end
