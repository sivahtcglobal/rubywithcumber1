Given(/^CSV Record Counts before Sending User Entity$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @beforeEventSend = JSON.parse(@response)
  puts @beforeEventSend.count
end

Given(/^Tableau Record Counts before Sending User Entity$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @beforeSend = post_request(@posturl,@query,@apitoken)
  puts @beforeSend['data'].length
end

Given(/^Create a new student in Moodle$/) do
  @admin_username = configatron.autoAdminUsername
  @admin_password = configatron.autoAdminPassword
  log_in_moodle(@admin_username,@admin_password)
  @currnetTimeStamp = Time.new.to_i * 1000
  @stu_username = 'sname_' + @currnetTimeStamp.to_s
  @stu_password = 'P@ssw0rd'
  @role = 'Student'
  create_user(@stu_username,@stu_password,@role)
  configatron.autoStudentUname = @stu_username
  configatron.autoStudentPwd = @stu_password
end

When(/^Student should be successfully created in Moodle$/) do

  on BrowserListOfUsersPage do |page|

    page.add_new_user.exists?.should be_true

  end

end

Then(/^Create user event should get successfully sent to the Entity Raw Index$/) do
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
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^The event should have \['entity\.@type'\] value as \['http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'\]$/) do
  @response['hits']['hits'][0]['_source']['entity']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
end

And(/^\['entity'\]\.\['extensions'\]\.\['userName'\] = Provided Student Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['userName'].should == @stu_username
end

And(/^\['entity'\]\.\['extensions'\]\.\['email'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['email'].should == @stu_username+'_auto_qa@email.com'
end

And(/^\['entity'\]\.\['extensions'\]\.\['moduleType'\] = 'user'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['moduleType'].should == 'user'
end

And(/^\['entity'\]\.\['extensions'\]\.\['city'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['city'].should == 'Test City'
end

And(/^\['entity'\]\.\['extensions'\]\.\['country'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['country'].should == 'CA'
end

And(/^\['entity'\]\.\['extensions'\]\.\['timeZone'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['timeZone'].should == 'America/Toronto'
end

And(/^\['entity'\]\.\['extensions'\]\.\['description'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['description'].include? 'Test Description'
end

And(/^\['entity'\]\.\['extensions'\]\.\['institution'\] = 'Student'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['institution'].should == 'Student'
end

And(/^\['entity'\]\.\['extensions'\]\.\['department'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['department'].should == 'Test Department'
end

And(/^\['entity'\]\.\['extensions'\]\.\['phone'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['phone'].should == '222-222-2222'
end

And(/^\['entity'\]\.\['extensions'\]\.\['mobilePhone'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['mobilePhone'].should == '333-333-3333'
end

And(/^\['entity'\]\.\['extensions'\]\.\['address'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['address'].should == 'Test Address'
end

Then(/^An Entity for Create Student should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Username']=="#{@stu_username}" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReport}"] }.last
  puts @latest_record
end

And(/^Create Student CSV \['User Display Name'\] Column Value = Provided Student Name$/) do
  @latest_record['User Display Name'].should == "#{@stu_username}_lname,#{@stu_username}_fname"
end

And(/^Create Student CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@stu_username}_fname #{@stu_username}_lname"
end

And(/^Create Student CSV \['Username'\] Column Value = Provided UserName$/) do
  @latest_record['Username'].should == "#{@stu_username}"
end

And(/^Create Student CSV \['User First Name'\] Column Value = Provided User First Name$/) do
  @latest_record['User First Name'].should == "#{@stu_username}_fname"
end

And(/^Create Student CSV \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @latest_record['User Last Name'].should == "#{@stu_username}_lname"
end

And(/^Create Student CSV \['Email Address'\] Column Value = Provided User Email Address$/) do
  @latest_record['Email Address'].should == "#{@stu_username}_auto_qa@email.com"
end

And(/^Create Student CSV \['City'\] Column Value = Provided City$/) do
  @latest_record['City'].should == "Test City"
end

And(/^Create Student CSV \['Country'\] Column Value = Provided Country$/) do
  @latest_record['Country'].should == "CA"
end

And(/^Create Student CSV \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @latest_record['Time Zone'].should == "America/Toronto"
end

And(/^Create Student CSV \['Description'\] Column Value = Provided Description$/) do
  @latest_record['Description'].include? "Test Description"
end

And(/^Create Student CSV \['Institution'\] Column Value = Provided Institution$/) do
  @latest_record['Institution'].should == "Student"
end

And(/^Create Student CSV \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @latest_record['Phone Number'].should == "222-222-2222"
end

And(/^Create Student CSV \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @latest_record['Mobile Phone Number'].should == "333-333-3333"
end

And(/^Create Student CSV \['Address'\] Column Value = Provided Address$/) do
  @latest_record['Address'].should == "Test Address"
end

And(/^Create Student CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == "Moodle"
end

Then(/^An Entity for Create Student should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Username']=="#{@stu_username}" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReportTableau}"] }.last
  puts @newest_record
end

And(/^Create Student Tableau \['User Display Name'\] Column Value = Provided Student Name$/) do
  @newest_record['UserDisplayName'].should == "#{@stu_username}_lname,#{@stu_username}_fname"
end

And(/^Create Student Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@stu_username}_fname #{@stu_username}_lname"
end

And(/^Create Student Tableau \['Username'\] Column Value = Provided UserName$/) do
  @newest_record['Username'].should == "#{@stu_username}"
end

And(/^Create Student Tableau \['User First Name'\] Column Value = Provided User First Name$/) do
  @newest_record['UserFirstName'].should == "#{@stu_username}_fname"
end

And(/^Create Student Tableau \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @newest_record['UserLastName'].should == "#{@stu_username}_lname"
end

And(/^Create Student Tableau \['Email Address'\] Column Value = Provided User Email Address$/) do
  @newest_record['EmailAddress'].should == "#{@stu_username}_auto_qa@email.com"
end

And(/^Create Student Tableau \['City'\] Column Value = Provided City$/) do
  @newest_record['City'].should == "Test City"
end

And(/^Create Student Tableau \['Country'\] Column Value = Provided Country$/) do
  @newest_record['Country'].should == "CA"
end

And(/^Create Student Tableau \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @newest_record['TimeZone'].should == "America/Toronto"
end

And(/^Create Student Tableau \['Description'\] Column Value = Provided Description$/) do
  @newest_record['Description'].include? "Test Description"
end

And(/^Create Student Tableau \['Institution'\] Column Value = Provided Institution$/) do
  @newest_record['Institution'].should == "Student"
end

And(/^Create Student Tableau \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @newest_record['PhoneNumber'].should == "222-222-2222"
end

And(/^Create Student Tableau \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @newest_record['MobilePhoneNumber'].should == "333-333-3333"
end

And(/^Create Student Tableau \['Address'\] Column Value = Provided Address$/) do
  @newest_record['Address'].should == "Test Address"
end

And(/^Create Student Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == "Moodle"
end

Given(/^Update an existing student in Moodle$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @stu_username = 'sname_' + @currnetTimeStamp.to_s
  @stu_password = 'P@ssw0rd'
  @role = 'Student'
  create_user(@stu_username,@stu_password,@role)
  sleep(10)
  @currnetTimeStamp = Time.new.to_i * 1000
  update_user(@stu_username)
end

When(/^Student should be successfully updated in Moodle$/) do

  on BrowserListOfUsersPage do |page|

    page.add_new_user.exists?.should be_true

  end

end

Then(/^Update user event should get successfully sent to the Entity Raw Index$/) do
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
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  @hits.should == 1
end

And(/^Update \['entity'\]\.\['extensions'\]\.\['email'\] = Provided Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['email'].should == @stu_username+'_auto_qa_updated@email.com'
end

Then(/^An Entity for Update Student should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 2

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Username']=="#{@stu_username}" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReport}"] }.last
  puts @latest_record
end

And(/^Update Student CSV \['User Display Name'\] Column Value = Provided Student Name$/) do
  @latest_record['User Display Name'].should == "#{@stu_username}_lname,#{@stu_username}_fname"
end

And(/^Update Student CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@stu_username}_fname #{@stu_username}_lname"
end

And(/^Update Student CSV \['Username'\] Column Value = Provided UserName$/) do
  @latest_record['Username'].should == "#{@stu_username}"
end

And(/^Update Student CSV \['User First Name'\] Column Value = Provided User First Name$/) do
  @latest_record['User First Name'].should == "#{@stu_username}_fname"
end

And(/^Update Student CSV \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @latest_record['User Last Name'].should == "#{@stu_username}_lname"
end

And(/^Update Student CSV \['Email Address'\] Column Value = Updated User Email Address$/) do
  Given CSV Record Counts before Sending User Entity
end

And(/^Update Student CSV \['City'\] Column Value = Provided City$/) do
  @latest_record['City'].should == "Test City"
end

And(/^Update Student CSV \['Country'\] Column Value = Provided Country$/) do
  @latest_record['Country'].should == "CA"
end

And(/^Update Student CSV \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @latest_record['Time Zone'].should == "America/Toronto"
end

And(/^Update Student CSV \['Description'\] Column Value = Provided Description$/) do
  @latest_record['Description'].include? "Test Description"
end

And(/^Update Student CSV \['Institution'\] Column Value = Provided Institution$/) do
  @latest_record['Institution'].should == "Student"
end

And(/^Update Student CSV \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @latest_record['Phone Number'].should == "222-222-2222"
end

And(/^Update Student CSV \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @latest_record['Mobile Phone Number'].should == "333-333-3333"
end

And(/^Update Student CSV \['Address'\] Column Value = Provided Address$/) do
  @latest_record['Address'].should == "Test Address"
end

And(/^Update Student CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == "Moodle"
end

Then(/^An Entity for Update Student should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 2

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Username']=="#{@stu_username}" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReportTableau}"] }.last
  puts @newest_record
end

And(/^Update Student Tableau \['User Display Name'\] Column Value = Provided Student Name$/) do
  @newest_record['UserDisplayName'].should == "#{@stu_username}_lname,#{@stu_username}_fname"
end

And(/^Update Student Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@stu_username}_fname #{@stu_username}_lname"
end

And(/^Update Student Tableau \['Username'\] Column Value = Provided UserName$/) do
  @newest_record['Username'].should == "#{@stu_username}"
end

And(/^Update Student Tableau \['User First Name'\] Column Value = Provided User First Name$/) do
  @newest_record['UserFirstName'].should == "#{@stu_username}_fname"
end

And(/^Update Student Tableau \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @newest_record['UserLastName'].should == "#{@stu_username}_lname"
end

And(/^Update Student Tableau \['Email Address'\] Column Value = Updated User Email Address$/) do
  @newest_record['EmailAddress'].should == "#{@stu_username}_auto_qa_updated@email.com"
end

And(/^Update Student Tableau \['City'\] Column Value = Provided City$/) do
  @newest_record['City'].should == "Test City"
end

And(/^Update Student Tableau \['Country'\] Column Value = Provided Country$/) do
  @newest_record['Country'].should == "CA"
end

And(/^Update Student Tableau \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @newest_record['TimeZone'].should == "America/Toronto"
end

And(/^Update Student Tableau \['Description'\] Column Value = Provided Description$/) do
  @newest_record['Description'].include? "Test Description"
end

And(/^Update Student Tableau \['Institution'\] Column Value = Provided Institution$/) do
  @newest_record['Institution'].should == "Student"
end

And(/^Update Student Tableau \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @newest_record['PhoneNumber'].should == "222-222-2222"
end

And(/^Update Student Tableau \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @newest_record['MobilePhoneNumber'].should == "333-333-3333"
end

And(/^Update Student Tableau \['Address'\] Column Value = Provided Address$/) do
  @newest_record['Address'].should == "Test Address"
end

And(/^Update Student Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == "Moodle"
end

Given(/^Create a new instructor in Moodle$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @inst_username = 'iname_' + @currnetTimeStamp.to_s
  @inst_password = 'P@ssw0rd'
  @role = 'Instructor'
  create_user(@inst_username,@inst_password,@role)
end

When(/^Instructor should be successfully created in Moodle$/) do

  on BrowserListOfUsersPage do |page|

    page.add_new_user.exists?.should be_true

  end

end

And(/^\['entity'\]\.\['extensions'\]\.\['userName'\] = Provided Instructor Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['userName'].should == @inst_username
end

And(/^\['entity'\]\.\['extensions'\]\.\['email'\] = Provided Instructor Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['email'].should == @inst_username+'_auto_qa@email.com'
end

And(/^\['entity'\]\.\['extensions'\]\.\['institution'\] = 'Instructor'$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['institution'].should == 'Instructor'
end

Then(/^An Entity for Create Instructor should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 1

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Username']=="#{@inst_username}" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReport}"] }.last
  puts @latest_record
end

And(/^Create Instructor CSV \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @latest_record['User Display Name'].should == "#{@inst_username}_lname,#{@inst_username}_fname"
end

And(/^Create Instructor CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@inst_username}_fname #{@inst_username}_lname"
end

And(/^Create Instructor CSV \['Username'\] Column Value = Provided UserName$/) do
  @latest_record['Username'].should == "#{@inst_username}"
end

And(/^Create Instructor CSV \['User First Name'\] Column Value = Provided User First Name$/) do
  @latest_record['User First Name'].should == "#{@inst_username}_fname"
end

And(/^Create Instructor CSV \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @latest_record['User Last Name'].should == "#{@inst_username}_lname"
end

And(/^Create Instructor CSV \['Email Address'\] Column Value = Provided User Email Address$/) do
  @latest_record['Email Address'].should == "#{@inst_username}_auto_qa@email.com"
end

And(/^Create Instructor CSV \['City'\] Column Value = Provided City$/) do
  @latest_record['City'].should == "Test City"
end

And(/^Create Instructor CSV \['Country'\] Column Value = Provided Country$/) do
  @latest_record['Country'].should == "CA"
end

And(/^Create Instructor CSV \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @latest_record['Time Zone'].should == "America/Toronto"
end

And(/^Create Instructor CSV \['Description'\] Column Value = Provided Description$/) do
  @latest_record['Description'].include? "Test Description"
end

And(/^Create Instructor CSV \['Institution'\] Column Value = Provided Institution$/) do
  @latest_record['Institution'].should == "Instructor"
end

And(/^Create Instructor CSV \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @latest_record['Phone Number'].should == "222-222-2222"
end

And(/^Create Instructor CSV \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @latest_record['Mobile Phone Number'].should == "333-333-3333"
end

And(/^Create Instructor CSV \['Address'\] Column Value = Provided Address$/) do
  @latest_record['Address'].should == "Test Address"
end

And(/^Create Instructor CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == "Moodle"
end

Then(/^An Entity for Create Instructor should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 1

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Username']=="#{@inst_username}" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReportTableau}"] }.last
  puts @newest_record
end

And(/^Create Instructor Tableau \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @newest_record['UserDisplayName'].should == "#{@inst_username}_lname,#{@inst_username}_fname"
end

And(/^Create Instructor Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@inst_username}_fname #{@inst_username}_lname"
end

And(/^Create Instructor Tableau \['Username'\] Column Value = Provided UserName$/) do
  @newest_record['Username'].should == "#{@inst_username}"
end

And(/^Create Instructor Tableau \['User First Name'\] Column Value = Provided User First Name$/) do
  @newest_record['UserFirstName'].should == "#{@inst_username}_fname"
end

And(/^Create Instructor Tableau \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @newest_record['UserLastName'].should == "#{@inst_username}_lname"
end

And(/^Create Instructor Tableau \['Email Address'\] Column Value = Provided User Email Address$/) do
  @newest_record['EmailAddress'].should == "#{@inst_username}_auto_qa@email.com"
end

And(/^Create Instructor Tableau \['City'\] Column Value = Provided City$/) do
  @newest_record['City'].should == "Test City"
end

And(/^Create Instructor Tableau \['Country'\] Column Value = Provided Country$/) do
  @newest_record['Country'].should == "CA"
end

And(/^Create Instructor Tableau \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @newest_record['TimeZone'].should == "America/Toronto"
end

And(/^Create Instructor Tableau \['Description'\] Column Value = Provided Description$/) do
  @newest_record['Description'].include? "Test Description"
end

And(/^Create Instructor Tableau \['Institution'\] Column Value = Provided Institution$/) do
  @newest_record['Institution'].should == "Instructor"
end

And(/^Create Instructor Tableau \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @newest_record['PhoneNumber'].should == "222-222-2222"
end

And(/^Create Instructor Tableau \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @newest_record['MobilePhoneNumber'].should == "333-333-3333"
end

And(/^Create Instructor Tableau \['Address'\] Column Value = Provided Address$/) do
  @newest_record['Address'].should == "Test Address"
end

And(/^Create Instructor Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == "Moodle"
end

Given(/^Update an existing instructor in Moodle$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @inst_username = 'iname_' + @currnetTimeStamp.to_s
  @inst_password = 'P@ssw0rd'
  @role = 'Instructor'
  create_user(@inst_username,@inst_password,@role)
  sleep(10)
  @currnetTimeStamp = Time.new.to_i * 1000
  update_user(@inst_username)
end

When(/^Instructor should be successfully updated in Moodle$/) do

  on BrowserListOfUsersPage do |page|

    page.add_new_user.exists?.should be_true

  end
  moodle_logout
end

And(/^Update \['entity'\]\.\['extensions'\]\.\['email'\] = Provided Instructor Value$/) do
  @response['hits']['hits'][0]['_source']['entity']['extensions']['email'].should == @inst_username+'_auto_qa_updated@email.com'
end

Then(/^An Entity for Update Instructor should get generated and sent to CSV\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/csv")

  @query = "{\"filters\":{}}"
  @response = post_csv_request(@posturl,@query,@apitoken)

  @afterEventSend = JSON.parse(@response)
  puts @afterEventSend.count

  @afterEventSend.count.should == @beforeEventSend.count + 2

  @all_csv_records = @afterEventSend.to_a.find_all { |value| value['Username']=="#{@inst_username}" }

  @latest_record = @all_csv_records.to_a.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReport}"] }.last
  puts @latest_record
end

And(/^Update Instructor CSV \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @latest_record['User Display Name'].should == "#{@inst_username}_lname,#{@inst_username}_fname"
end

And(/^Update Instructor CSV \['User Name'\] Column Value = Provided User Name$/) do
  @latest_record['User Name'].should == "#{@inst_username}_fname #{@inst_username}_lname"
end

And(/^Update Instructor CSV \['Username'\] Column Value = Provided UserName$/) do
  @latest_record['Username'].should == "#{@inst_username}"
end

And(/^Update Instructor CSV \['User First Name'\] Column Value = Provided User First Name$/) do
  @latest_record['User First Name'].should == "#{@inst_username}_fname"
end

And(/^Update Instructor CSV \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @latest_record['User Last Name'].should == "#{@inst_username}_lname"
end

And(/^Update Instructor CSV \['Email Address'\] Column Value = Updated User Email Address$/) do
  @latest_record['Email Address'].should == "#{@inst_username}_auto_qa_updated@email.com"
end

And(/^Update Instructor CSV \['City'\] Column Value = Provided City$/) do
  @latest_record['City'].should == "Test City"
end

And(/^Update Instructor CSV \['Country'\] Column Value = Provided Country$/) do
  @latest_record['Country'].should == "CA"
end

And(/^Update Instructor CSV \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @latest_record['Time Zone'].should == "America/Toronto"
end

And(/^Update Instructor CSV \['Description'\] Column Value = Provided Description$/) do
  @latest_record['Description'].include? "Test Description"
end

And(/^Update Instructor CSV \['Institution'\] Column Value = Provided Institution$/) do
  @latest_record['Institution'].should == "Instructor"
end

And(/^Update Instructor CSV \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @latest_record['Phone Number'].should == "222-222-2222"
end

And(/^Update Instructor CSV \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @latest_record['Mobile Phone Number'].should == "333-333-3333"
end

And(/^Update Instructor CSV \['Address'\] Column Value = Provided Address$/) do
  @latest_record['Address'].should == "Test Address"
end

And(/^Update Instructor CSV \['Data Source'\] Column Value = 'Moodle'$/) do
  @latest_record['Data Source'].should == "Moodle"
end

Then(/^An Entity for Update Instructor should get generated and sent to Tableau\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join("https://",@tokenhost,"/api/essentials/reports/v0/#{configatron.moodleUserProfileReport}/data/tableau")

  @query = "{\"filters\":{}}"
  @afterSend = post_request(@posturl,@query,@apitoken)
  puts @afterSend['data'].length

  @afterSend['data'].length.should == @beforeSend['data'].length + 2

  @all_tableau_records = @afterSend['data'].find_all { |value| value['Username']=="#{@inst_username}" }

  @newest_record = @all_tableau_records.sort_by { |record| record["#{configatron.dateModifiedFieldUserProfileReportTableau}"] }.last
  puts @newest_record
end

And(/^Update Instructor Tableau \['User Display Name'\] Column Value = Provided Instructor Name$/) do
  @newest_record['UserDisplayName'].should == "#{@inst_username}_lname,#{@inst_username}_fname"
end

And(/^Update Instructor Tableau \['User Name'\] Column Value = Provided User Name$/) do
  @newest_record['UserName'].should == "#{@inst_username}_fname #{@inst_username}_lname"
end

And(/^Update Instructor Tableau \['Username'\] Column Value = Provided UserName$/) do
  @newest_record['Username'].should == "#{@inst_username}"
end

And(/^Update Instructor Tableau \['User First Name'\] Column Value = Provided User First Name$/) do
  @newest_record['UserFirstName'].should == "#{@inst_username}_fname"
end

And(/^Update Instructor Tableau \['User Last Name'\] Column Value = Provided User Last Name$/) do
  @newest_record['UserLastName'].should == "#{@inst_username}_lname"
end

And(/^Update Instructor Tableau \['Email Address'\] Column Value = Updated User Email Address$/) do
  @newest_record['EmailAddress'].should == "#{@inst_username}_auto_qa_updated@email.com"
end

And(/^Update Instructor Tableau \['City'\] Column Value = Provided City$/) do
  @newest_record['City'].should == "Test City"
end

And(/^Update Instructor Tableau \['Country'\] Column Value = Provided Country$/) do
  @newest_record['Country'].should == "CA"
end

And(/^Update Instructor Tableau \['Time Zone'\] Column Value = Provided Time Zone$/) do
  @newest_record['TimeZone'].should == "America/Toronto"
end

And(/^Update Instructor Tableau \['Description'\] Column Value = Provided Description$/) do
  @newest_record['Description'].include? "Test Description"
end

And(/^Update Instructor Tableau \['Institution'\] Column Value = Provided Institution$/) do
  @newest_record['Institution'].should == "Instructor"
end

And(/^Update Instructor Tableau \['Phone Number'\] Column Value = Provided Phone Number$/) do
  @newest_record['PhoneNumber'].should == "222-222-2222"
end

And(/^Update Instructor Tableau \['Mobile Phone Number'\] Column Value = Provided Mobile Number$/) do
  @newest_record['MobilePhoneNumber'].should == "333-333-3333"
end

And(/^Update Instructor Tableau \['Address'\] Column Value = Provided Address$/) do
  @newest_record['Address'].should == "Test Address"
end

And(/^Update Instructor Tableau \['Data Source'\] Column Value = 'Moodle'$/) do
  @newest_record['DataSource'].should == "Moodle"
end
