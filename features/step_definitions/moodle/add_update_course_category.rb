Given(/^Add a new course category in Moodle$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  #Initialising the Values to Add A Course Category
  @category_name = 'ACCName_' + @currnetTimeStamp.to_s
  @category_num = '123_' + @currnetTimeStamp.to_s
  configatron.categoryname = @category_name

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      #Should Get Logged in as an Admin to Add a Course Category
      @admin_username = configatron.autoAdminUsername
      @admin_password = configatron.autoAdminPassword
      log_in_moodle(@admin_username,@admin_password)
    end unless page.automation_site_admin.exists?
  end

  #Add a course category
  add_course_category(@category_name, @category_num)

end

When(/^Course category should be successfully created in Moodle$/) do

  on CouseManagmentPage do |page|
    page.create_course_link.wait_until_present
    page.create_course_link.exists?.should be_true
  end
  configatron.category_id = get_item_id()

  track_category(configatron.categoryname)

end

Then(/^Add course category event should get successfully sent to the Entity Raw Index$/) do
  ENV['TZ'] = 'UTC'

  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000
  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":1,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^The event should have \['entity\.@context'\] value as \['http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'\]$/) do
  @response['hits']['hits'][0]['_source']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^The event should have \['entity\.@type'\] values as \['http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Group'\]$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/lis/Group'
end

And(/^The event should have \['entity\.extensions\.categoryNumber'\] category id value as provided$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['categoryNumber'].should == @category_num
end

And(/^The event should have \['entity\.name'\] category name value as provided$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @category_name
end

And(/^\['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'course_category'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'course_category'
end

Given(/^Update an existing course category in Moodle$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  #Initialising the Values to Add A Course Category
  @category_name = 'ACCName_' + @currnetTimeStamp.to_s
  @category_num = '123_' + @currnetTimeStamp.to_s

  #Add a course category
  add_course_category(@category_name, @category_num)

  #Update a course category
  @currnetTimeStamp = Time.new.to_i * 1000
  @updated_category_num = '456_' + @currnetTimeStamp.to_s

  @baseurl = configatron.moodleURL
  @category_id = get_category_id()
  @categoryEditLink = @baseurl + '/course/editcategory.php?id=' + @category_id
  @browser.goto @categoryEditLink

  update_course_category(@updated_category_num)
end

When(/^Course category should be successfully updated in Moodle$/) do
  on CouseManagmentPage do |page|
    page.create_course_link.wait_until_present
    page.create_course_link.exists?.should be_true
  end
  moodle_logout
end

Then(/^Update course category event should get successfully sent to the Entity Raw Index$/) do
  ENV['TZ'] = 'UTC'

  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000
  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":1,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^The event should have \['entity\.extensions\.categoryNumber'\] category id value as updated$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['categoryNumber'].should == @updated_category_num
end
