Given(/^CSV Record Counts before Sending Course Entity$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleCourseReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @beforeEventSend = JSON.parse(@response)
  puts @beforeEventSend.count
end

Given(/^Tableau Record Counts before Sending Course Entity$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleCourseReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @beforeSend = post_request(@posturl,@query,@apitoken)
  puts @beforeSend['data'].length
end

Given(/^Create a Course With Visibility (.*?)$/) do |visible|
  @baseDir = File.absolute_path "./"
  uploadfile_path = File.join(@baseDir,"lib","intellify","support_files","testImage.jpg")
  @currnetTimeStamp = Time.new.to_i * 1000
  #Initiatiing the Values to Create A Course
  @fullname = "CF #{visible}" + @currnetTimeStamp.to_s
  @sortname = "CS #{visible}" + @currnetTimeStamp.to_s
  @tagName1 = 'tag1' + @currnetTimeStamp.to_s
  configatron.fullname = @fullname
  configatron.sortname = @sortname
  configatron.tagname1 = @tagName1
  @categoryName = configatron.categoryname
  @coursenumber = @currnetTimeStamp.to_s
  @visible = visible
  @show = false
  if @visible == "Show" then
    @show = true
  end
  configatron.courseDesc = 'Auto Description' + @currnetTimeStamp.to_s
  configatron.courseNumber = @coursenumber

  @completionTracking = true
  #Should Get Logged in as an Admin to Create a Course

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      #Should Get Logged in as an Admin to Add a Course
      @username =  configatron.autoAdminUsername
      @password = configatron.autoAdminPassword
      log_in_moodle(@username,@password)
    end unless page.automation_site_admin.exists?
  end

  puts "Creating Course with #{@fullname}"
  visit CouseManagmentPage do |page|
    page.intellify_catagory_link.wait_until_present
    page.intellify_catagory_link.click
    page.create_course_link_clk
  end

  on CourseCreationPage do |page|
    page.course_fullname_txt.wait_until_present
    page.course_fullname_txt.set @fullname
    page.course_shortname_txt.set @sortname
    page.course_catagory_select.select @categoryName
    page.course_visibity_select.select "#{@visible}"
    page.course_id_txt.set @coursenumber
    page.course_description_editor.send_keys configatron.courseDesc
    page.course_startdate_day_select.select '3'
    page.course_startdate_month_select.select 'April'
    page.course_startdate_year_select.select '2017'

    #Upload a file to a course
    page.select_files_link.click
    page.upload_files_link.wait_until_present
    page.upload_files_link.click
    sleep(5)
    @browser.file_field(:id,//).set(uploadfile_path)
    page.upload_files_btn.click
    page.course_format_link.wait_until_present
    page.course_format_link_clk
    page.course_format_select.select 'Topics format'
    page.course_layout_select.select 'Show one section per page'

    page.appearance_link.click
    page.show_gradebook_select.select 'No'
    page.show_activity_report_select.select 'Yes'

    page.course_completion_link.click unless page.course_completion_select.visible?
    page.course_completion_select.select 'No'

    page.groups_link.click
    page.group_mode_select.select 'Visible groups'

    page.tags_link.click
    page.enter_tags.send_keys @tagName1
    @browser.send_keys :enter

    page.course_saveanddisplay_btn_clk

  end

end


When(/^The Course Got successfully created$/) do
  visit CouseManagmentPage do |page|

    page.create_course_link.exists?.should be_true
  end
  @courseId = get_item_id()
  track_tags(configatron.tagname1)
  track_course(configatron.fullname)

  moodle_logout
end

Then(/^A Course Entity should get generated and sent to our Raw Entity Index\.$/) do

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

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"entity.extensions.moduleType\":\"course\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":1,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^The \[entity\]\[@context\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^The \[entity\]\[@type\] =  'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseOffering'$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should ==  'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
end

And(/^The \[entity\]\[name\] = Provided Course Full Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @fullname
end

And(/^The \[entity\]\[extensions\]\[shortName\] = Provided Course Short Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['shortName'].should == @sortname
end

And(/^The \[entity\]\[extensions\]\[visible\] = (.*)$/) do |result|
  @response['hits']['hits'][0]['_source']['entity']['extensions']['visible'].should == @show
end

And(/^The \#\[entity\]\[extensions\]\[startDate\] = Should Be Porvided Start Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['startDate'].include? '2017-04-03'
end

And(/^The \#\[entity\]\[extensions\]\[format\] = Provided Format$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['format'].should == 'topics'
end

And(/^The \#\[entity\]\[extensions\]\[layout\] = Provided Course Layout$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['layout'].should == 'oneSectionPerPage'
end

And(/^The \#\[entity\]\[extensions\]\[showGradeBook\] = Provided Gradebook Instruction$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['showGradeBook'].should == false
end

And(/^The \#\[entity\]\[extensions\]\[showActivityReports\] = Provided Activity Reports Instruction$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['showActivityReports'].should == true
end

And(/^The \#\[entity\]\[extensions\]\[groupMode\] = Provided Grouping Mode$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'visible'
end

And(/^\['entity'\]\.\['extensions'\]\.\['tags'\]\.\[0\] = Provided Course Tag$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['tags'][0].should == configatron.tagname1
end

And(/^The \[entity\]\[extensions\]\[completionTracking\] = false$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'].should == false
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'course'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'course'
end

And(/^The \[entity\]\[courseNumber\] = Provided Course Number$/) do
  @response['hits']['hits'][0]['_source']['entity']['courseNumber'].should == configatron.courseNumber
end

And(/^The \[entity\]\[subOrganizationOf\]\[@context\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['entity']['subOrganizationOf']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^The \[entity\]\[subOrganizationOf\]\["@type\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Group'$/) do
  @response['hits']['hits'][0]['_source']['entity']['subOrganizationOf']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Group'
end

Then(/^An Entity for Create Course should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleCourseReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Course Name']=="#{@fullname}" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateModifiedFieldCourseReport}"] }.last
  puts @latest_record
end

And(/^Create Course CSV \['Course Name'\] Column Value = Provided Course Name$/) do
  @latest_record['Course Name'].should == "#{@fullname}"
end

And(/^Create Course CSV \['Course Short Name'\] Column Value = Provided Course Short Name$/) do
  @latest_record['Course Short Name'].should == "#{@sortname}"
end

And(/^Create Course CSV \['Course ID'\] Column Value = Generated Course ID$/) do
  @latest_record['Course ID'].include? "#{@courseId}"
end

And(/^Create Course CSV \['Course Number'\] Column Value = Provided Course Number$/) do
  @latest_record['Course Number'].should == "#{@coursenumber}"
end

And(/^Create Course CSV \['Course Category ID'\] Column Value = Course Category ID$/) do
  @latest_record['Course Category ID'].include? "#{configatron.category_id}"
end

And(/^Create Course CSV \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @latest_record['Course Category Name'].should == "#{configatron.categoryname}"
end

And(/^Create Course CSV \['Course Format'\] Column Value = Provided Course Format$/) do
  @latest_record['Course Format'].should == "topics"
end

And(/^Create Course CSV \['Course Layout'\] Column Value = Provided Course Layout$/) do
  @latest_record['Course Layout'].should == "oneSectionPerPage"
end

And(/^Create Course CSV \['Course Visible'\] Column Value = Provided Course Visible (.*)$/) do |result|
  @latest_record['Course Visible'].downcase.should == "#{@show}"
end

And(/^Create Course CSV \['Course Start Date'\] Column Value = Provided Course Start Date$/) do
  @latest_record['Course Start Date'].include? '2017-04-03'
end

And(/^Create Course CSV \['Course Completion Tracking'\] Column Value = Provided Course Completion Tracking$/) do
  @latest_record['Course Completion Tracking'].downcase.should == "false"
end

And(/^Create Course CSV \['Show Grade Book'\] Column Value = Provided Grade Book$/) do
  @latest_record['Show Grade Book'].downcase.should == "false"
end

And(/^Create Course CSV \['Show Activity Reports'\] Column Value = Provided Activity Reports$/) do
  @latest_record['Show Activity Reports'].downcase.should == "true"
end

And(/^Create Course CSV \['Group Mode'\] Column Value = Provided Group Mode$/) do
  @latest_record['Group Mode'].should == 'visible'
end

And(/^Create Course CSV \['Tags'\] Column Value = Provided Tags$/) do
  @latest_record['Tags'].should == "#{@tagName1}"
end

And(/^Create Course CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == "Moodle"
end

Then(/^An Entity for Create Course should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleCourseReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['CourseName']=="#{@fullname}" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateModifiedFieldCourseReportTableau}"] }.last
  puts @newest_record
end

And(/^Create Course Tableau \['Course Name'\] Column Value = Provided Course Name$/) do
  @newest_record['CourseName'].should == "#{@fullname}"
end

And(/^Create Course Tableau \['Course Short Name'\] Column Value = Provided Course Short Name$/) do
  @newest_record['CourseShortName'].should == "#{@sortname}"
end

And(/^Create Course Tableau \['Course ID'\] Column Value = Generated Course ID$/) do
  @newest_record['CourseID'].include? "#{@courseId}"
end

And(/^Create Course Tableau \['Course Number'\] Column Value = Provided Course Number$/) do
  @newest_record['CourseNumber'].should == "#{@coursenumber}"
end

And(/^Create Course Tableau \['Course Category ID'\] Column Value = Course Category ID$/) do
  @newest_record['CourseCategoryID'].include? "#{configatron.category_id}"
end

And(/^Create Course Tableau \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @newest_record['CourseCategoryName'].should == "#{configatron.categoryname}"
end

And(/^Create Course Tableau \['Course Format'\] Column Value = Provided Course Format$/) do
  @newest_record['CourseFormat'].should == "topics"
end

And(/^Create Course Tableau \['Course Layout'\] Column Value = Provided Course Layout$/) do
  @newest_record['CourseLayout'].should == "oneSectionPerPage"
end

And(/^Create Course Tableau \['Course Visible'\] Column Value = Provided Course Visible (.*)$/) do |result|
  @newest_record['CourseVisible'].to_s.downcase.should == "#{@show}"
end

And(/^Create Course Tableau \['Course Start Date'\] Column Value = Provided Course Start Date$/) do
  @newest_record['CourseStartDate'].include? '2017-04-03'
end

And(/^Create Course Tableau \['Course Completion Tracking'\] Column Value = Provided Course Completion Tracking$/) do
  @newest_record['CourseCompletionTracking'].to_s.downcase.should == "false"
end

And(/^Create Course Tableau \['Show Grade Book'\] Column Value = Provided Grade Book$/) do
  @newest_record['ShowGradeBook'].to_s.downcase.should == "false"
end

And(/^Create Course Tableau \['Show Activity Reports'\] Column Value = Provided Activity Reports$/) do
  @newest_record['ShowActivityReports'].to_s.downcase.should == "true"
end

And(/^Create Course Tableau \['Group Mode'\] Column Value = Provided Group Mode$/) do
  @newest_record['GroupMode'].should == 'visible'
end

And(/^Create Course Tableau \['Tags'\] Column Value = Provided Tags$/) do
  @newest_record['Tags'].should == "#{@tagName1}"
end

And(/^Create Course Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == "Moodle"
end

Given(/^Update the a Created Course$/) do
  @fullname = configatron.fullname
  @sortname = configatron.sortname
  @categoryname = configatron.categoryname

  on MoodleHomePage do |page|
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      #Should Get Logged in as an Admin to Update a Course
      @username =  configatron.autoAdminUsername
      @password = configatron.autoAdminPassword
      log_in_moodle(@username,@password)
    end unless page.automation_site_admin.exists?
  end

  @course_Id = get_course_id(@fullname, @categoryname)
  @currnetTimeStamp = Time.new.to_i * 1000

  @baseurl = configatron.moodleURL

  @courseEditLink = @baseurl + '/course/edit.php?id=' + @course_Id
  @browser.goto @courseEditLink
  @fullname = @fullname + 'updated'
  @sortname = @sortname + 'updated'
  configatron.fullname = @fullname

  on CourseCreationPage do |page|

    page.course_fullname_txt.exists?.should be_true
    page.course_fullname_txt.set @fullname
    page.course_shortname_txt.set @sortname
    page.course_visibity_select.select "Show"
    page.course_description_editor.send_keys 'Updated'
    page.course_startdate_day_select.select '12'
    page.course_startdate_month_select.select 'April'
    page.course_startdate_year_select.select '2017'

    page.course_format_link_clk
    page.course_format_select.select 'Topics format'
    page.course_layout_select.select 'Show all sections on one page'

    page.appearance_link.click
    page.show_gradebook_select.select 'Yes'
    page.show_activity_report_select.select 'No'

    page.course_completion_link.click unless page.course_completion_select.visible?
    page.course_completion_select.select 'Yes'

    page.groups_link.click
    page.group_mode_select.select 'No groups'

    page.course_saveanddisplay_btn_clk

  end

end

When(/^The Course Got successfully Updated/) do
  on CourseDetailPage do |page|

    page.course_heading_txt(@fullname).exists?.should be_true
  end
  # delete_course(configatron.fullname)
  configatron.courseId = @course_Id
  configatron.courseName = @fullname
  moodle_logout
end

And(/^The \[entity\]\[name\] = Provided Updated Course Full Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['name'].should == @fullname
end

And(/^The \[entity\]\[extensions\]\[shortName\] = Provided Updated Course Short Name$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['shortName'].should == @sortname
end

And(/^The \[entity\]\[extensions\]\[visible\] =Updated Visiblelity$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['visible'].should == true
end

And(/^The \#\[entity\]\[extensions\]\[startDate\] =Updated Start Date$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['startDate'].include? '2017-04-12'
end

And(/^Update the \#\[entity\]\[extensions\]\[layout\] = Provided Course Layout$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['layout'].should == 'allSectionsOnePage'
end

And(/^Update the \#\[entity\]\[extensions\]\[showGradeBook\] = Provided Gradebook Instruction$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['showGradeBook'].should == true
end

And(/^Update the \#\[entity\]\[extensions\]\[showActivityReports\] = Provided Activity Reports Instruction$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['showActivityReports'].should == false
end

And(/^Update the \#\[entity\]\[extensions\]\[groupMode\] = Provided Grouping Mode$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['groupMode'].should == 'none'
end

And(/^The \[entity\]\[extensions\]\[completionTracking\] = true$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['completionTracking'].should == true
end

Then(/^An Entity for Update Course should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleCourseReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Course Name']=="#{@fullname}" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateModifiedFieldCourseReport}"] }.last
  puts @latest_record
end

And(/^Update Course CSV \['Course Name'\] Column Value = Updated Course Name$/) do
  @latest_record['Course Name'].should == "#{@fullname}"
end

And(/^Update Course CSV \['Course Short Name'\] Column Value = Updated Course Short Name$/) do
  @latest_record['Course Short Name'].should == "#{@sortname}"
end

And(/^Update Course CSV \['Course ID'\] Column Value = Generated Course ID$/) do
  @latest_record['Course ID'].include? "#{@course_Id}"
end

And(/^Update Course CSV \['Course Number'\] Column Value = Provided Course Number$/) do
  @latest_record['Course Number'].should == "#{configatron.courseNumber}"
end

And(/^Update Course CSV \['Course Category ID'\] Column Value = Course Category ID$/) do
  @latest_record['Course Category ID'].include? "#{configatron.category_id}"
end

And(/^Update Course CSV \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @latest_record['Course Category Name'].should == "#{configatron.categoryname}"
end

And(/^Update Course CSV \['Course Format'\] Column Value = Provided Course Format$/) do
  @latest_record['Course Format'].should == "topics"
end

And(/^Update Course CSV \['Course Layout'\] Column Value = Updated Course Layout$/) do
  @latest_record['Course Layout'].should == "allSectionsOnePage"
end

And(/^Update Course CSV \['Course Visible'\] Column Value = Updated Course Visible$/) do
  @latest_record['Course Visible'].downcase.should == "true"
end

And(/^Update Course CSV \['Course Start Date'\] Column Value = Updated Course Start Date$/) do
  @latest_record['Course Start Date'].include? '2017-04-12'
end

And(/^Update Course CSV \['Course Completion Tracking'\] Column Value = Updated Course Completion Tracking$/) do
  @latest_record['Course Completion Tracking'].downcase.should == "true"
end

And(/^Update Course CSV \['Show Grade Book'\] Column Value = Updated Grade Book$/) do
  @latest_record['Show Grade Book'].downcase.should == "true"
end

And(/^Update Course CSV \['Show Activity Reports'\] Column Value = Updated Activity Reports$/) do
  @latest_record['Show Activity Reports'].downcase.should == "false"
end

And(/^Update Course CSV \['Group Mode'\] Column Value = Updated Group Mode$/) do
  @latest_record['Group Mode'].should == 'none'
end

And(/^Update Course CSV \['Tags'\] Column Value = Provided Tags$/) do
  @latest_record['Tags'].should == "#{configatron.tagname1}"
end

And(/^Update Course CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == "Moodle"
end

Then(/^An Entity for Update Course should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleCourseReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['CourseName']=="#{@fullname}" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateModifiedFieldCourseReportTableau}"] }.last
  puts @newest_record
end

And(/^Update Course Tableau \['Course Name'\] Column Value = Updated Course Name$/) do
  @newest_record['CourseName'].should == "#{@fullname}"
end

And(/^Update Course Tableau \['Course Short Name'\] Column Value = Updated Course Short Name$/) do
  @newest_record['CourseShortName'].should == "#{@sortname}"
end

And(/^Update Course Tableau \['Course ID'\] Column Value = Generated Course ID$/) do
  @newest_record['CourseID'].include? "#{@course_Id}"
end

And(/^Update Course Tableau \['Course Number'\] Column Value = Provided Course Number$/) do
  @newest_record['CourseNumber'].should == "#{configatron.courseNumber}"
end

And(/^Update Course Tableau \['Course Category ID'\] Column Value = Course Category ID$/) do
  @newest_record['CourseCategoryID'].include? "#{configatron.category_id}"
end

And(/^Update Course Tableau \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @newest_record['CourseCategoryName'].should == "#{configatron.categoryname}"
end

And(/^Update Course Tableau \['Course Format'\] Column Value = Provided Course Format$/) do
  @newest_record['CourseFormat'].should == "topics"
end

And(/^Update Course Tableau \['Course Layout'\] Column Value = Updated Course Layout$/) do
  @newest_record['CourseLayout'].should == "allSectionsOnePage"
end

And(/^Update Course Tableau \['Course Visible'\] Column Value = Updated Course Visible$/) do
  @newest_record['CourseVisible'].to_s.downcase.should == "true"
end

And(/^Update Course Tableau \['Course Start Date'\] Column Value = Updated Course Start Date$/) do
  @newest_record['CourseStartDate'].include? '2017-04-12'
end

And(/^Update Course Tableau \['Course Completion Tracking'\] Column Value = Updated Course Completion Tracking$/) do
  @newest_record['CourseCompletionTracking'].to_s.downcase.should == "true"
end

And(/^Update Course Tableau \['Show Grade Book'\] Column Value = Updated Grade Book$/) do
  @newest_record['ShowGradeBook'].to_s.downcase.should == "true"
end

And(/^Update Course Tableau \['Show Activity Reports'\] Column Value = Updated Activity Reports$/) do
  @newest_record['ShowActivityReports'].to_s.downcase.should == "false"
end

And(/^Update Course Tableau \['Group Mode'\] Column Value = Updated Group Mode$/) do
  @newest_record['GroupMode'].should == 'none'
end

And(/^Update Course Tableau \['Tags'\] Column Value = Provided Tags$/) do
  @newest_record['Tags'].should == "#{configatron.tagname1}"
end

And(/^Update Course Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == "Moodle"
end
