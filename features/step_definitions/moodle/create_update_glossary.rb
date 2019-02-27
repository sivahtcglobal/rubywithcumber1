Given(/^Created a New Glossary for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = configatron.courseId

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

  @glossaryName =  'at_glossary_'+@currnetTimeStamp.to_s
  @glossaryDescription = 'Automated Glossary Description'+@currnetTimeStamp.to_s
  configatron.glossaryname = @glossaryName
  configatron.glossarydescription = @glossaryDescription
  @browser.goto(configatron.moodleURL+'/course/modedit.php?add=glossary&type=&course='+@courseId+'&section=1&return=0&sr=0')

  on CourseGlossaryPage do |page|
    page.glossary_name_txt.set @glossaryName

    page.glossary_description_txt.click
    page.glossary_description_txt.send_keys [:control, 'a']
    page.glossary_description_txt.send_keys @glossaryDescription
    page.display_description_chkbox.click

    #Provide Rating Parameters
    page.ratings_link.click
    page.ratings_assessed_select.select 'Average of ratings'
    page.ratings_scale_grade_type_select.select 'Point'
    page.ratings_scale_grade_point_txt.set '80'
    page.ratings_rating_time_chkbox.click
    page.ratings_from_day_select.select '1'
    page.ratings_from_month_select.select 'January'
    page.ratings_from_year_select.select '2017'
    page.ratings_from_hour_select.select '08'
    page.ratings_from_minute_select.select '05'
    page.ratings_to_day_select.select '31'
    page.ratings_to_month_select.select 'December'
    page.ratings_to_year_select.select '2018'
    page.ratings_to_hour_select.select '18'
    page.ratings_to_minute_select.select '05'
    @startTimeStamp = Time.new.to_i * 1000
    page.glossary_saveanddisplay_btn_clk

  end
end

When(/^The New Glossary got successfully created$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @glossaryName
  end
  configatron.glossary_id = get_item_id()
end

Then(/^A Course Entity for New Glossary should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')


  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^\['entity'\]\.\['name'\] = Glossary name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @glossaryName
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'glossary'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'glossary'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Grade$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 0
end

Given(/^Updated the existing Glossary for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @glossaryId = configatron.glossary_id
  @browser.goto(configatron.moodleURL+"/course/modedit.php?update="+@glossaryId+"&return=0&sr=0")
  @glossaryName = configatron.glossaryname+'updated'
  @glossaryDescription = configatron.glossarydescription+'updated'

  on CourseGlossaryPage do |page|

    page.glossary_name_txt.clear
    page.glossary_name_txt.set @glossaryName

    page.glossary_description_txt.click
    page.glossary_description_txt.send_keys [:control, 'a']
    page.glossary_description_txt.send_keys @glossaryDescription

    page.ratings_link.click
    page.ratings_assessed_select.select 'Count of ratings'

    page.grade_link.click
    page.grade_to_pass_txt.set '72'
    @startTimeStamp = Time.new.to_i * 1000
    page.glossary_saveanddisplay_btn_clk

  end
end

When(/^The existing Glossary got successfully updated$/) do

  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == @glossaryName
  end
  moodle_logout
end

Then(/^A Course Entity for Update Glossary should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)
  puts @response
  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^Updated \['entity'\]\.\['name'\] = Glossary name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @glossaryName
end

And(/^Updated The \['entity'\]\.\['extensions'\]\.\['gradeToPass'\] = Provided Grade$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['gradeToPass'].should == 72
end
