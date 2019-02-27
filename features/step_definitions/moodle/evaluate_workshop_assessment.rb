Given(/^Recalculate Workshop Assessment Evaluated Page for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @workshop_id = configatron.workshop_id unless configatron.workshop_id == nil

  on MoodleHomePage do |page|
    @username = configatron.autoTeacherUsername
    @password = configatron.autoTeacherPassword
    log_in_moodle(@username,@password)
  end
  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  on CourseWorkshopGradingPage do |page|
    page.switch_to_the_next_phase_link.click if page.switch_to_the_next_phase_link.exists?
    page.grading_switch_to_the_next_phase_image.click if page.grading_switch_to_the_next_phase_image.exists?
    page.continue_assessment_phase_btn_clk if page.continue_assessment_phase_btn.exists?
    page.continue_assessment_phase_button_clk if page.continue_assessment_phase_button.exists?
    @browser.execute_script('arguments[0].scrollIntoView();', page.grading_evaluation_method_select)
    page.comparison_of_assessments_select.select 'lax'
    page.recalculate_grades_btn.click
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Workshop Assessment Evaluated should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"workshop_assessment_evaluated\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'workshop_aggregation'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'workshop_aggregation'
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'workshop_assessment_evaluated'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'workshop_assessment_evaluated'
end

Given(/^Workshop Assessment Evaluations Reset for a Course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @workshop_id = configatron.workshop_id unless configatron.workshop_id == nil
  on MoodleHomePage do |page|
    @username = configatron.autoTeacherUsername
    @password = configatron.autoTeacherPassword
    log_in_moodle(@username,@password)
  end

  @browser.goto(configatron.moodleURL+'/mod/workshop/view.php?id=' + @workshop_id.to_s)
  on CourseWorkshopGradingPage do |page|
    page.workshop_grades_link.click
    sleep(2)
    page.clear_all_aggregated_grades1_btn.click if page.clear_all_aggregated_grades1_btn.exists?
    page.clear_all_aggregated_grades2_btn.click if page.clear_all_aggregated_grades2_btn.exists?
    sleep(2)
    page.yes_btn.click
  end
  sleep(10)
  moodle_logout
end

Then(/^An Event for Workshop Assessment Evaluations Reset should get generated and sent to our Raw Event Index\.$/) do
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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.extensions.action\":\"workshop_assessment_evaluations_reset\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should ==  'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^\['event'\]\.\['extensions'\]\.\['action'\] = 'workshop_assessment_evaluations_reset'$/) do
  @response['hits']['hits'][0]['_source']['event']['extensions']['action'].should == 'workshop_assessment_evaluations_reset'
end
