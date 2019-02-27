Given(/^CSV Record Counts before Sending Enrollment Entity$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @beforeEventSend = JSON.parse(@response)
  puts @beforeEventSend.count
end

Given(/^Tableau Record Counts before Sending Enrollment Entity$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @beforeSend = post_request(@posturl,@query,@apitoken)
  puts @beforeSend['data'].length
end

Given(/^Enroll a student to a course in Moodle$/) do
  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @admin_username = configatron.autoAdminUsername
      @admin_password = configatron.autoAdminPassword
      log_in_moodle(@admin_username,@admin_password)
    end unless page.automation_site_admin.exists?
  end

  #Initializing the Values to Create A Student
  @currnetTimeStamp = Time.new.to_i * 1000
  @stu_username = 'sname_' + @currnetTimeStamp.to_s
  @stu_password = 'P@ssw0rd'
  @role = 'Student'
  create_user(@stu_username,@stu_password,@role)
  @user_Id = get_user_id(@stu_username)

  #Initializing the Values to Enroll a Student
  @baseurl = configatron.moodleURL
  @course_Id = configatron.courseId
  @enrollUserLink = @baseurl + '/enrol/users.php?id=' + @course_Id
  @browser.goto @enrollUserLink

  sleep(20)
  @enrolStudentStartTimeStamp = Time.new.to_i * 1000
  enroll_user(@stu_username, @role)
  sleep(20)
  @enrolStudentEndTimeStamp = Time.new.to_i * 1000
  configatron.autoStudentUsername = @stu_username
  configatron.autoStudentPassword = @stu_password
end

When(/^Student should be successfully enrolled in Moodle$/) do

  on EnrollUserPage do |page|

    page.enrol_users_button.exists?.should be_true

  end

end

Then(/^Enroll student user event should get successfully sent to the Entity Raw Index$/) do
  ENV['TZ'] = 'UTC'

  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @enrolStudentStartTimeStamp
  @endTimeStamp = @enrolStudentEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"entity.@type\":\"http://purl.imsglobal.org/caliper/v1/lis/Membership\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  sleep(5)
  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^The event should have \['entity\.@type'\] values as \['http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Membership'\]$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Membership'
end

And(/^The \['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'enrolment'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'enrolment'
end

And(/^The event should have \['entity\.roles'\] values as \['http:\/\/purl\.imsglobal\.org\/vocab\/lis\/v2\/membership\#Learner'\]$/) do
  @response['hits']['hits'][0]['_source']['entity']['roles'][0].should == 'http://purl.imsglobal.org/vocab/lis/v2/membership#Learner'
end

And(/^The event should have \['entity\.status'\] values as \['http:\/\/purl\.imsglobal\.org\/vocab\/lis\/v2\/status\#Active'\]$/) do
  @response['hits']['hits'][0]['_source']['entity']['status'].should == 'http://purl.imsglobal.org/vocab/lis/v2/status#Active'
end

And(/^The event should have \['entity\.@id'\] value includes the course id in which user is enrolled$/) do
  @response['hits']['hits'][0]['_source']['entity']['@id'].include?("id=" + @course_Id)
end

And(/^The event should have \['entity\.member'\] value includes the user id who is enrolled$/) do
  @response['hits']['hits'][0]['_source']['entity']['member'].include?("id=" + @user_Id)
end

Then(/^An Entity for Enrol Student should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['User Name']== "#{@stu_username}_fname #{@stu_username}_lname" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReport}"] }.last
  puts @latest_record
end

And(/^Enrol Student CSV \['User Display Name'\] Column Value = Provided Student Name$/) do
  @latest_record['User Display Name'].should == "#{@stu_username}_lname,#{@stu_username}_fname"
end

And(/^Enrol Student CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@stu_username}_fname #{@stu_username}_lname"
end

And(/^Enrol Student CSV \['Course ID'\] Column Value = Generated Course ID$/) do
  @latest_record['Course ID'].include? "#{configatron.courseId}"
end

And(/^Enrol Student CSV \['Course Name'\] Column Value = Provided Course Name$/) do
  @latest_record['Course Name'].should == "#{configatron.fullname}"
end

And(/^Enrol Student CSV \['Course Category ID'\] Column Value = Course Category ID$/) do
  @latest_record['Course Category ID'].include? "#{configatron.category_id}"
end

And(/^Enrol Student CSV \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @latest_record['Course Category Name'].should == "#{configatron.categoryname}"
end

And(/^Enrol Student CSV \['Role'\] Column Value = Provided Role$/) do
  @latest_record['Role'].should == "Learner"
end

Then(/^An Entity for Enrol Student should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['UserName']=="#{@stu_username}_fname #{@stu_username}_lname" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReportTableau}"] }.last
  puts @newest_record
end

And(/^Enrol Student Tableau \['User Display Name'\] Column Value = Provided Student Name$/) do
  @newest_record['UserDisplayName'].should == "#{@stu_username}_lname,#{@stu_username}_fname"
end

And(/^Enrol Student Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@stu_username}_fname #{@stu_username}_lname"
end

And(/^Enrol Student Tableau \['Course ID'\] Column Value = Generated Course ID$/) do
  @newest_record['CourseID'].include? "#{configatron.courseId}"
end

And(/^Enrol Student Tableau \['Course Name'\] Column Value = Provided Course Name$/) do
  @newest_record['CourseName'].should == "#{configatron.fullname}"
end

And(/^Enrol Student Tableau \['Course Category ID'\] Column Value = Course Category ID$/) do
  @newest_record['CourseCategoryID'].include? "#{configatron.category_id}"
end

And(/^Enrol Student Tableau \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @newest_record['CourseCategoryName'].should == "#{configatron.categoryname}"
end

And(/^Enrol Student Tableau \['Role'\] Column Value = Provided Role$/) do
  @newest_record['Role'].should == "Learner"
end

Given(/^Modify a student enrollment to a course in Moodle$/) do
  #Initializing the Values to Create A Student
  @currnetTimeStamp = Time.new.to_i * 1000
  @student_username = 'sname_' + @currnetTimeStamp.to_s
  @student_password = 'P@ssw0rd'
  @role = 'Student'
  create_user(@student_username,@student_password,@role)
  @user_Id = get_user_id(@student_username)

  #Initializing the Values to Enroll a Student
  @baseurl = configatron.moodleURL
  @course_Id = configatron.courseId
  @enrollUserLink = @baseurl + '/enrol/users.php?id=' + @course_Id
  @browser.goto @enrollUserLink

  @currnetTimeStamp = Time.new.to_i * 1000
  enroll_user(@student_username, @role)

  on EnrollUserPage do |page|
    page.unassigned_role_link_clk
    sleep(2)
    page.confirm_role_change_button_clk
    sleep(2)
  end

  #Initializing the Values to Modify a Student Enrollment
  sleep(20)
  @modifyStudentEnrollmentStartTimeStamp = Time.new.to_i * 1000
  modify_user_enrollment(@role)
  sleep(20)
  @modifyStudentEnrollmentEndTimeStamp = Time.new.to_i * 1000
end

When(/^Student enrollment should be successfully modified in Moodle$/) do

  on EnrollUserPage do |page|

    page.enrol_users_button.exists?.should be_true

  end

end

Then(/^Modify student enrollment event should get successfully sent to the Entity Raw Index$/) do
  ENV['TZ'] = 'UTC'

  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @modifyStudentEnrollmentStartTimeStamp
  @endTimeStamp = @modifyStudentEnrollmentEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"entity.@type\":\"http://purl.imsglobal.org/caliper/v1/lis/Membership\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  sleep(5)
  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^The event should have \['entity\.roles'\] values as \['http:\/\/purl\.imsglobal\.org\/vocab\/lis\/v2\/membership\#Instructor'\]$/) do
  @response['hits']['hits'][0]['_source']['entity']['roles'][0].should == 'http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor'
end

And(/^The event should have \['entity\.@id'\] value includes the course id in which user enrollment is modified$/) do
  @response['hits']['hits'][0]['_source']['entity']['@id'].include?("id=" + @course_Id)
end

And(/^The event should have \['entity\.member'\] value includes the user id whose enrollment is modified$/) do
  @response['hits']['hits'][0]['_source']['entity']['member'].include?("id=" + @user_Id)
end

Then(/^An Entity for Modify Student Enrollment should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['User Name']== "#{@student_username}_fname #{@student_username}_lname" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReport}"] }.last
  puts @latest_record
end

And(/^Modify Student Enrollment CSV \['User Display Name'\] Column Value = Provided Student Name$/) do
  @latest_record['User Display Name'].should == "#{@student_username}_lname,#{@student_username}_fname"
end

And(/^Modify Student Enrollment CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@student_username}_fname #{@student_username}_lname"
end

And(/^Modify Student Enrollment CSV \['Course ID'\] Column Value = Generated Course ID$/) do
  @latest_record['Course ID'].include? "#{configatron.courseId}"
end

And(/^Modify Student Enrollment CSV \['Course Name'\] Column Value = Provided Course Name$/) do
  @latest_record['Course Name'].should == "#{configatron.fullname}"
end

And(/^Modify Student Enrollment CSV \['Course Category ID'\] Column Value = Course Category ID$/) do
  @latest_record['Course Category ID'].include? "#{configatron.category_id}"
end

And(/^Modify Student Enrollment CSV \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @latest_record['Course Category Name'].should == "#{configatron.categoryname}"
end

And(/^Modify Student Enrollment CSV \['Role'\] Column Value = Updated Role$/) do
  @latest_record['Role'].should == "Instructor"
end

Then(/^An Entity for Modify Student Enrollment should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['UserName']=="#{@student_username}_fname #{@student_username}_lname" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReportTableau}"] }.last
  puts @newest_record
end

And(/^Modify Student Enrollment Tableau \['User Display Name'\] Column Value = Provided Student Name$/) do
  @newest_record['UserDisplayName'].should == "#{@student_username}_lname,#{@student_username}_fname"
end

And(/^Modify Student Enrollment Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@student_username}_fname #{@student_username}_lname"
end

And(/^Modify Student Enrollment Tableau \['Course ID'\] Column Value = Generated Course ID$/) do
  @newest_record['CourseID'].include? "#{configatron.courseId}"
end

And(/^Modify Student Enrollment Tableau \['Course Name'\] Column Value = Provided Course Name$/) do
  @newest_record['CourseName'].should == "#{configatron.fullname}"
end

And(/^Modify Student Enrollment Tableau \['Course Category ID'\] Column Value = Course Category ID$/) do
  @newest_record['CourseCategoryID'].include? "#{configatron.category_id}"
end

And(/^Modify Student Enrollment Tableau \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @newest_record['CourseCategoryName'].should == "#{configatron.categoryname}"
end

And(/^Modify Student Enrollment Tableau \['Role'\] Column Value = Updated Role$/) do
  @newest_record['Role'].should == "Instructor"
end

Given(/^Enroll an instructor to a course in Moodle$/) do
  #Initializing the Values to Create An Instructor
  @currnetTimeStamp = Time.new.to_i * 1000
  @inst_username = 'iname_' + @currnetTimeStamp.to_s
  @inst_password = 'P@ssw0rd'
  @role = 'Instructor'
  create_user(@inst_username,@inst_password,@role)
  @user_Id = get_user_id(@inst_username)

  #Initializing the Values to Enroll an Instructor
  @baseurl = configatron.moodleURL
  @course_Id = configatron.courseId
  @enrollUserLink = @baseurl + '/enrol/users.php?id=' + @course_Id
  @browser.goto @enrollUserLink

  sleep(20)
  @enrolInstructorStartTimeStamp = Time.new.to_i * 1000
  enroll_user(@inst_username, @role)
  sleep(20)
  @enrolInstructorEndTimeStamp = Time.new.to_i * 1000
  configatron.autoTeacherUsername = @inst_username
  configatron.autoTeacherPassword = @inst_password
end

When(/^Instructor should be successfully enrolled in Moodle$/) do

  on EnrollUserPage do |page|

    page.enrol_users_button.exists?.should be_true

  end

end

Then(/^Enroll instructor user event should get successfully sent to the Entity Raw Index$/) do
  ENV['TZ'] = 'UTC'

  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @enrolInstructorStartTimeStamp
  @endTimeStamp = @enrolInstructorEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"entity.@type\":\"http://purl.imsglobal.org/caliper/v1/lis/Membership\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  sleep(5)
  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  @hits.should > 0
end

Then(/^An Entity for Enrol Instructor should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['User Name']== "#{@inst_username}_fname #{@inst_username}_lname" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReport}"] }.last
  puts @latest_record
end

And(/^Enrol Instructor CSV \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @latest_record['User Display Name'].should == "#{@inst_username}_lname,#{@inst_username}_fname"
end

And(/^Enrol Instructor CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@inst_username}_fname #{@inst_username}_lname"
end

And(/^Enrol Instructor CSV \['Course ID'\] Column Value = Generated Course ID$/) do
  @latest_record['Course ID'].include? "#{configatron.courseId}"
end

And(/^Enrol Instructor CSV \['Course Name'\] Column Value = Provided Course Name$/) do
  @latest_record['Course Name'].should == "#{configatron.fullname}"
end

And(/^Enrol Instructor CSV \['Course Category ID'\] Column Value = Course Category ID$/) do
  @latest_record['Course Category ID'].include? "#{configatron.category_id}"
end

And(/^Enrol Instructor CSV \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @latest_record['Course Category Name'].should == "#{configatron.categoryname}"
end

And(/^Enrol Instructor CSV \['Role'\] Column Value = Provided Role$/) do
  @latest_record['Role'].should == "Instructor"
end

Then(/^An Entity for Enrol Instructor should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['UserName']=="#{@inst_username}_fname #{@inst_username}_lname" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReportTableau}"] }.last
  puts @newest_record
end

And(/^Enrol Instructor Tableau \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @newest_record['UserDisplayName'].should == "#{@inst_username}_lname,#{@inst_username}_fname"
end

And(/^Enrol Instructor Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@inst_username}_fname #{@inst_username}_lname"
end

And(/^Enrol Instructor Tableau \['Course ID'\] Column Value = Generated Course ID$/) do
  @newest_record['CourseID'].include? "#{configatron.courseId}"
end

And(/^Enrol Instructor Tableau \['Course Name'\] Column Value = Provided Course Name$/) do
  @newest_record['CourseName'].should == "#{configatron.fullname}"
end

And(/^Enrol Instructor Tableau \['Course Category ID'\] Column Value = Course Category ID$/) do
  @newest_record['CourseCategoryID'].include? "#{configatron.category_id}"
end

And(/^Enrol Instructor Tableau \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @newest_record['CourseCategoryName'].should == "#{configatron.categoryname}"
end

And(/^Enrol Instructor Tableau \['Role'\] Column Value = Provided Role$/) do
  @newest_record['Role'].should == "Instructor"
end

Given(/^Modify an instructor enrollment to a course in Moodle$/) do
  #Initializing the Values to Create An Instructor
  @currnetTimeStamp = Time.new.to_i * 1000
  @instructor_username = 'iname_' + @currnetTimeStamp.to_s
  @instructor_password = 'P@ssw0rd'
  @role = 'Instructor'
  create_user(@instructor_username,@instructor_password,@role)
  @user_Id = get_user_id(@instructor_username)

  #Initializing the Values to Enroll an Instructor
  @baseurl = configatron.moodleURL
  @course_Id = configatron.courseId
  @enrollUserLink = @baseurl + '/enrol/users.php?id=' + @course_Id
  @browser.goto @enrollUserLink

  @currnetTimeStamp = Time.new.to_i * 1000
  enroll_user(@instructor_username, @role)

  on EnrollUserPage do |page|
    page.unassigned_role_link_clk
    sleep(2)
    page.confirm_role_change_button_clk
    sleep(2)
  end

  #Initializing the Values to Modify an Instructor Enrollment
  sleep(20)
  @modifyInstructorEnrollmentStartTimeStamp = Time.new.to_i * 1000
  modify_user_enrollment(@role)
  sleep(20)
  @modifyInstructorEnrollmentEndTimeStamp = Time.new.to_i * 1000
end

When(/^Instructor enrollment should be successfully modified in Moodle$/) do

  on EnrollUserPage do |page|

    page.enrol_users_button.exists?.should be_true
    sleep(5)
  end
  moodle_logout
end

Then(/^Modify instructor enrollment event should get successfully sent to the Entity Raw Index$/) do
  ENV['TZ'] = 'UTC'

  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @modifyInstructorEnrollmentStartTimeStamp
  @endTimeStamp = @modifyInstructorEnrollmentEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"entity.@type\":\"http://purl.imsglobal.org/caliper/v1/lis/Membership\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  sleep(5)
  @response = post_request(@posturl,@query,@apitoken)

  puts @response

  @hits = @response['hits']['total']
  @hits.should == 1
end

Then(/^An Entity for Modify Instructor Enrollment should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['User Name']== "#{@instructor_username}_fname #{@instructor_username}_lname" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReport}"] }.last
  puts @latest_record
end

And(/^Modify Instructor Enrollment CSV \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @latest_record['User Display Name'].should == "#{@instructor_username}_lname,#{@instructor_username}_fname"
end

And(/^Modify Instructor Enrollment CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@instructor_username}_fname #{@instructor_username}_lname"
end

And(/^Modify Instructor Enrollment CSV \['Course ID'\] Column Value = Generated Course ID$/) do
  @latest_record['Course ID'].include? "#{configatron.courseId}"
end

And(/^Modify Instructor Enrollment CSV \['Course Name'\] Column Value = Provided Course Name$/) do
  @latest_record['Course Name'].should == "#{configatron.fullname}"
end

And(/^Modify Instructor Enrollment CSV \['Course Category ID'\] Column Value = Course Category ID$/) do
  @latest_record['Course Category ID'].include? "#{configatron.category_id}"
end

And(/^Modify Instructor Enrollment CSV \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @latest_record['Course Category Name'].should == "#{configatron.categoryname}"
end

And(/^Modify Instructor Enrollment CSV \['Role'\] Column Value = Updated Role$/) do
  @latest_record['Role'].should == "Learner"
end

Then(/^An Entity for Modify Instructor Enrollment should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleEnrollmentReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['UserName']=="#{@instructor_username}_fname #{@instructor_username}_lname" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.userIdFieldEnrollmentReportTableau}"] }.last
  puts @newest_record
end

And(/^Modify Instructor Enrollment Tableau \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @newest_record['UserDisplayName'].should == "#{@instructor_username}_lname,#{@instructor_username}_fname"
end

And(/^Modify Instructor Enrollment Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@instructor_username}_fname #{@instructor_username}_lname"
end

And(/^Modify Instructor Enrollment Tableau \['Course ID'\] Column Value = Generated Course ID$/) do
  @newest_record['CourseID'].include? "#{configatron.courseId}"
end

And(/^Modify Instructor Enrollment Tableau \['Course Name'\] Column Value = Provided Course Name$/) do
  @newest_record['CourseName'].should == "#{configatron.fullname}"
end

And(/^Modify Instructor Enrollment Tableau \['Course Category ID'\] Column Value = Course Category ID$/) do
  @newest_record['CourseCategoryID'].include? "#{configatron.category_id}"
end

And(/^Modify Instructor Enrollment Tableau \['Course Category Name'\] Column Value = Provided Course Category Name$/) do
  @newest_record['CourseCategoryName'].should == "#{configatron.categoryname}"
end

And(/^Modify Instructor Enrollment Tableau \['Role'\] Column Value = Updated Role$/) do
  @newest_record['Role'].should == "Learner"
end
