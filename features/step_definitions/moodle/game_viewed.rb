Given(/^Student View the Game$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @gameId = configatron.game_id
  @username = configatron.autoStudentUsername
  @password = configatron.autoStudentPassword
  log_in_moodle(@username,@password)
  sleep(10)
  @browser.goto(configatron.moodleURL+'/mod/game/view.php?id='+@gameId)

  on CourseGamePage do |page|
    sleep(5)
    @studentGameViewedStartTimeStamp = Time.new.to_i * 1000
    page.attempt_game_now_btn_clk
    sleep(5)
    @studentGameViewedEndTimeStamp = Time.new.to_i * 1000
    sleep(5)
  end
end

When(/^The Game got successfully viewed by the Student$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == configatron.gamename+'updated'
  end
  moodle_logout
end

Then(/^An Event for Student Game Viewed should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @studentGameViewedStartTimeStamp
  @endTimeStamp = @studentGameViewedEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'game_game'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'game_game'
end
