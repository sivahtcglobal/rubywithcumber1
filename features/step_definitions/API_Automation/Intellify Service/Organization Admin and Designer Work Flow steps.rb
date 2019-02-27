
Then(/^Login to obtain Auth Token for "([^"]*)" to use in End to End Work Flow Test$/) do |role|
	@currnetTimeStamp = Time.new.to_i * 1000

	@hostname = configatron.workbench
	if role == "Admin" then
		configatron.localUsername = configatron.adminUsername
		configatron.localPassword = configatron.adminPassword
	else
		configatron.localUsername = configatron.designerUsername
		configatron.localPassword = configatron.designerPassword
	end

	@apitoken =  get_apitoken(@hostname,configatron.localUsername,configatron.localPassword)
	configatron.apitoken = @apitoken

	#Initiate Local Variables need for the End to End Flow
	configatron.bdf_datacollectionname = "Selenium Basic #{role} Flow Data Collection-#{@currnetTimeStamp}"
	configatron.bdf_datasourcename = "Selenium Basic #{role} Flow Data Source-#{@currnetTimeStamp}"
	configatron.bdf_datasourcename2 = "Selenium Basic #{role} Flow Second Data Source-#{@currnetTimeStamp}"
	configatron.bdf_entityname = "data-selenium-entity-#{@currnetTimeStamp}"
	configatron.bdf_eventname = "data-selenium-event-#{@currnetTimeStamp}"
	configatron.bdf_intelliname = "Selenium #{role} created intellistream-#{@currnetTimeStamp}"
	configatron.bdf_intelliname2 = "Selenium #{role} created second intellistream-#{@currnetTimeStamp}"
	configatron.bdf_intelliview = "Selenium #{role} intelliview DF-#{@currnetTimeStamp}"
	configatron.bdf_intelliview2 = "Selenium #{role} intelliview2 DF-#{@currnetTimeStamp}"
	configatron.bdf_newusername = "APIUserCreation-_#{@currnetTimeStamp}"
	configatron.bdf_outputcollection = "data-test-selenium-df-#{@currnetTimeStamp}"
	configatron.bdf_sensorid = "com.selenium.sensor.#{@currnetTimeStamp}"
	configatron.bdf_newuserpassword = "iAmAValidPassword1@ab"

end

Then(/^Verify that the Org exist.$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/org/#{configatron.orgId}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should  == "#{configatron.orgId}"
	puts "&#10004;uuid -- #{configatron.orgId} was equal to #{configatron.orgId}"
	@responce['name'].should  == "#{configatron.orgname}"
	puts "&#10004;orgname -- #{configatron.orgname} was equal to #{configatron.orgname}"
	@responce['type'].should  == "SCHOOL"
	puts "&#10004;type -- SCHOOL was equal to SCHOOL"
	@responce['parentOrgId'].should  == nil
	puts "&#10004;parentOrgId -- was null"
	puts "&#10004;active -- was false"

end

Then(/^Create New User with valid Password. Assert response code is 200$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
  \"orgId\": \"#{configatron.orgId}\",
  \"active\": true,
  \"firstName\": \"GI\",
  \"lastName\": \"UserCreation\",
  \"username\": \"#{configatron.bdf_newusername}\",
  \"password\": \"#{configatron.bdf_newuserpassword}\",
  \"city\": \"Boston\",
  \"country\": \"USA\",
  \"eMail\": \"testuserdelete@foo.edu\",
  \"roles\": []
}"
	@posturl = File.join('https://',@hostname,'/user')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	configatron.createdUserUUID = @responce['uuid']
	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	puts "&#10004;active -- was false"
	@responce['firstName'].should  == "GI"
	puts "&#10004;firstName -- was GI"
	@responce['lastName'].should  == "UserCreation"
	puts "&#10004;lastName -- was UserCreation"
	@responce['eMail'].should  == "testuserdelete@foo.edu"
	puts "&#10004;eMail -- was testuserdelete@foo.edu"
	@responce['middleName'].should  == nil
	puts "&#10004;middleName -- was null"
	@responce['city'].should  == "Boston"
	puts "&#10004;city -- was Boston"
	@responce['country'].should  == "USA"
	puts "&#10004;country -- was USA"
	##@responce['password'].should  == "{bcrypt}"
  #puts "&#10004;password -- was false"
end

Then(/^Verify New User login$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{\"username\":\"#{configatron.bdf_newusername}\",\"password\":\"#{configatron.bdf_newuserpassword}\"}"
	@posturl = File.join('https://',@hostname,'/user/login')
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
end

Then(/^Verify Created User Information. Assert response code is 204$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	@responce['firstName'].should  == "GI"
	@responce['lastName'].should  == "UserCreation"
	@responce['eMail'].should  == "testuserdelete@foo.edu"
	@responce['middleName'].should  == nil
	@responce['city'].should  == "Boston"
	@responce['country'].should  == "USA"
	##@responce['password'].should  == "{bcrypt}"
end

Then(/^Edit Password of New User by a different User$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
	\"uuid\": \"#{configatron.createdUserUUID}\",
	\"name\": \"#{configatron.bdf_newusername}\",
	\"orgId\": \"#{configatron.orgId}\",
	\"username\": \"#{configatron.bdf_newusername}\",
	\"password\": \"EditedPassword@2\",
	\"firstName\": \"GI\",
	\"lastName\": \"UserCreation\",
	\"middleName\": null,
	\"eMail\": \"testuserdelete@foo.edu\",
	\"city\": \"Boston\",
	\"country\": \"USA\",
	\"timeZone\": null,
	\"language\": null,
	\"description\": null,
	\"picture\": null,
	\"personalLearningSpaceUUID\": null,
	\"active\": true,
	\"roles\": [],
	\"groups\": [],
	\"userPreferences\": null
}"
	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  if configatron.collectorVersion == 'OLD' then

		@status.should == 401
		puts "&#10004;Status -- 401 was a number equal to 401"
		@responce['message'].should  == "Request user has different ID than target user"

    else
	puts "<b>ASSERTIONS</b>"
	@status.should == 403
	puts "&#10004;Status -- 403 was a number equal to 403"
	@responce['message'].should  == "INT-1: Request user has different ID than target user"
  end
end

Then(/^Verify New User login with edidted Password$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{\"username\":\"#{configatron.bdf_newusername}\",\"password\":\"EditedPassword@2\"}"
	@posturl = File.join('https://',@hostname,'/user/login')
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	if configatron.collectorVersion == 'OLD' then

		@status.should == 401
		puts "&#10004;Status -- 401 was a number equal to 401"
		@responce['message'].should  == "HTTP 401 Unauthorized"

		else

		puts "<b>ASSERTIONS</b>"
		@status.should == 401
		puts "&#10004;Status -- 401 was a number equal to 401"
		@responce['message'].should  == "INT-1: HTTP 401 Unauthorized"
  end
end

Then(/^Update Other fields of the User as a different User$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
	\"uuid\": \"#{configatron.createdUserUUID}\",
	\"name\": \"#{configatron.bdf_newusername}\",
	\"orgId\": \"#{configatron.orgId}\",
	\"username\": \"#{configatron.bdf_newusername}\",
	\"password\": \"EditedPassword@2\",
	\"firstName\": \"EditGI\",
	\"lastName\": \"EditUserCreation\",
	\"middleName\": null,
	\"eMail\": \"Edittestuserdelete@foo.edu\",
	\"city\": \"EditBoston\",
	\"country\": \"EditUSA\",
	\"timeZone\": null,
	\"language\": null,
	\"description\": null,
	\"picture\": null,
	\"personalLearningSpaceUUID\": null,
	\"active\": true,
	\"roles\": [],
	\"groups\": [],
	\"userPreferences\": null
}"
	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	if configatron.collectorVersion == 'OLD' then

		@status.should == 401
		puts "&#10004;Status -- 401 was a number equal to 401"
		@responce['message'].should  == "Request user has different ID than target user"

	else
	puts "<b>ASSERTIONS</b>"
	@status.should == 403
	puts "&#10004;Status -- 403 was a number equal to 403"
	@responce['message'].should  == "INT-1: Request user has different ID than target user"
	end
end

Then(/^Verify Updated User Information$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	@responce['firstName'].should  == "GI"
	@responce['lastName'].should  == "UserCreation"
	@responce['eMail'].should  == "testuserdelete@foo.edu"
	@responce['middleName'].should  == nil
	@responce['city'].should  == "Boston"
	@responce['country'].should  == "USA"
	##@responce['password'].should  == "{bcrypt}"
	@responce['orgId'].should  == "#{configatron.orgId}"
end

Then(/^Get Auth Tocken for the new User$/) do

	@hostname = configatron.workbench
	@apitoken =  get_apitoken(@hostname,configatron.bdf_newusername,configatron.bdf_newuserpassword)
	configatron.apitoken = @apitoken

end

Then(/^Edit Password of New User with valid Password. Assert response code is 200$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
	\"uuid\": \"#{configatron.createdUserUUID}\",
	\"name\": \"#{configatron.bdf_newusername}\",
	\"orgId\": \"#{configatron.orgId}\",
	\"username\": \"#{configatron.bdf_newusername}\",
	\"password\": \"EditedPassword@2\",
	\"firstName\": \"GI\",
	\"lastName\": \"UserCreation\",
	\"middleName\": null,
	\"eMail\": \"testuserdelete@foo.edu\",
	\"city\": \"Boston\",
	\"country\": \"USA\",
	\"timeZone\": null,
	\"language\": null,
	\"description\": null,
	\"picture\": null,
	\"personalLearningSpaceUUID\": null,
	\"active\": true,
	\"roles\": [],
	\"groups\": [],
	\"userPreferences\": null
}"
	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)


	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	@responce['firstName'].should  == "GI"
	@responce['lastName'].should  == "UserCreation"
	@responce['eMail'].should  == "testuserdelete@foo.edu"
	@responce['middleName'].should  == nil
	@responce['city'].should  == "Boston"
	@responce['country'].should  == "USA"
	##@responce['password'].should  == "{bcrypt}"
end

Then(/^Verify New User login. Assert response code is 200$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{\"username\":\"#{configatron.bdf_newusername}\",\"password\":\"EditedPassword@2\"}"
	@posturl = File.join('https://',@hostname,'/user/login')
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	@responce['firstName'].should  == "GI"
	@responce['lastName'].should  == "UserCreation"
	@responce['eMail'].should  == "testuserdelete@foo.edu"
	@responce['middleName'].should  == nil
	@responce['city'].should  == "Boston"
	@responce['country'].should  == "USA"
	@responce['orgId'].should  == "#{configatron.orgId}"
end

Then(/^Update Other fields of the User by a different User$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
	\"uuid\": \"#{configatron.createdUserUUID}\",
	\"name\": \"#{configatron.bdf_newusername}\",
	\"orgId\": \"#{configatron.orgId}\",
	\"username\": \"#{configatron.bdf_newusername}\",
	\"password\": \"EditedPassword@2\",
	\"firstName\": \"EditGI\",
	\"lastName\": \"EditUserCreation\",
	\"middleName\": null,
	\"eMail\": \"Edittestuserdelete@foo.edu\",
	\"city\": \"EditBoston\",
	\"country\": \"EditUSA\",
	\"timeZone\": null,
	\"language\": null,
	\"description\": null,
	\"picture\": null,
	\"personalLearningSpaceUUID\": null,
	\"active\": true,
	\"roles\": [],
	\"groups\": [],
	\"userPreferences\": null
}"
	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	@responce['orgId'].should  == "#{configatron.orgId}"
	@responce['username'].should  == "#{configatron.bdf_newusername}"
	@responce['firstName'].should  == "EditGI"
	@responce['lastName'].should  == "EditUserCreation"
	@responce['eMail'].should  == "Edittestuserdelete@foo.edu"
	@responce['city'].should  == "EditBoston"
	@responce['country'].should  == "EditUSA"
end

Then(/^Verify login with Updated Fields. Assert response code is 200$/) do

	@hostname = configatron.workbench

	@apitoken = configatron.apitoken

	@query = "{\"username\":\"#{configatron.bdf_newusername}\",\"password\":\"EditedPassword@2\"}"
	@posturl = File.join('https://',@hostname,'/user/login')
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)


	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	@responce['firstName'].should  == "EditGI"
	@responce['lastName'].should  == "EditUserCreation"
	@responce['eMail'].should  == "Edittestuserdelete@foo.edu"
	@responce['middleName'].should  == nil
	@responce['city'].should  == "EditBoston"
	@responce['country'].should  == "EditUSA"
	@responce['orgId'].should  == "#{configatron.orgId}"
end

Then(/^Verify Updated User Information. Assert response code is 204$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['name'].should  == "#{configatron.bdf_newusername}"
	@responce['firstName'].should  == "EditGI"
	@responce['lastName'].should  == "EditUserCreation"
	@responce['eMail'].should  == "Edittestuserdelete@foo.edu"
	@responce['middleName'].should  == nil
	@responce['city'].should  == "EditBoston"
	@responce['country'].should  == "EditUSA"
	##@responce['password'].should  == "{bcrypt}"
	@responce['orgId'].should  == "#{configatron.orgId}"
end

Then(/^Get Auth Token again with a Admin User.$/) do

	@hostname = configatron.workbench
	@username= configatron.localUsername
	@password= configatron.localPassword
	@apitoken =  get_apitoken(@hostname,@username,@password)
	configatron.apitoken = @apitoken

end

Then(/^Delete and Verify the User was successfully deleted$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/user/#{configatron.createdUserUUID}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify that the User was NOT created because of invalid password. Assert response code is 200$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
  \"orgId\": \"#{configatron.orgId}\",
  \"active\": true,
  \"firstName\": \"Test\",
  \"lastName\": \"User Delete\",
  \"username\": \"testuserdelete\",
  \"password\": \"invalidpassword\",
  \"city\": \"Boston\",
  \"country\": \"USA\",
  \"eMail\": \"testuserdelete@foo.edu\",
  \"roles\": []
}"
	@posturl = File.join('https://',@hostname,'/user')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)


	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 400"
end

Then(/^Create a DataCollection using the Org as its parent$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
    \"apiKeys\": [],
    \"dataSources\": [],
    \"intelliStreams\": [],
    \"intelliViews\": [],
    \"parentOrgId\": \"#{configatron.orgId}\",
    \"name\": \"#{configatron.bdf_datacollectionname}\"
}"
	@posturl = File.join('https://',@hostname,'/datacollection')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	configatron.bdf_datacollectionuuid = @responce['uuid']

	configatron.bdf_apiKey = @responce['apiKeys'][0]['uuid']
	configatron.bdf_apiKeyUrlSafeString = @responce['apiKeys'][0]['apiKeyUrlSafeString']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['parentOrgId'].should  == "#{configatron.orgId}"
	@responce['active'].should  == true
	@responce['apiKeys'][0]['uuid'].should_not  == nil
end

Then(/^Verify that the DataCollection was successfully created. Assert response code is 200$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/datacollection/#{configatron.bdf_datacollectionuuid}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['apiKeys'][0]['uuid'].should  == "#{configatron.bdf_apiKey}"
	@responce['parentOrgId'].should  == "#{configatron.orgId}"
	@responce['active'].should  == true
end

Then(/^Create a Data Source using the Data collection Created$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
    \"parentDataCollectionId\": \"#{configatron.bdf_datacollectionuuid}\",
    \"allowNullSensorId\": false,
    \"active\": true,
    \"name\": \"#{configatron.bdf_datasourcename}\",
    \"sensorId\": \"#{configatron.bdf_sensorid}\",
    \"rawEventStreamName\": \"#{configatron.bdf_eventname}\",
    \"rawDescribeStreamName\": \"#{configatron.bdf_entityname}\",
    \"streamIsSearchable\": true,
    \"trustLevel\": \"OWN_SENSOR_ONLY\",
    \"sensorType\": \"CUSTOM_JAVASCRIPT_SENSOR\",
    \"type\": \"INTELLIFY_DATASOURCE\"
}"
	@posturl = File.join('https://',@hostname,'/datasource/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	configatron.bdf_datasourceUUID = @responce['uuid']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['active'].should  == true
end

Then(/^Verify that the DataSource in the DataCollection was successfully created$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/datasource/#{configatron.bdf_datasourceUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should  == "#{configatron.bdf_datasourceUUID}"
	@responce['active'].should  == true
	@responce['sensorId'].should  == "#{configatron.bdf_sensorid}"
	@responce['sensorType'].should  == "CUSTOM_JAVASCRIPT_SENSOR"
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['cronExpression'].should  == nil
	@responce['trustLevel'].should  == "OWN_SENSOR_ONLY"
	@responce['rawEventStreamName'].should  == "#{configatron.bdf_eventname}"
	@responce['rawDescribeStreamName'].should  == "#{configatron.bdf_entityname}"
end

Then(/^Create a intellistream under the Data collection$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
	\"name\": \"#{configatron.bdf_intelliname}\",
	\"active\": true,
	\"jobRequired\": false,
	\"type\": \"computed\",
	\"parentDataCollectionId\": \"#{configatron.bdf_datacollectionuuid}\",
	\"contextUpdateStrategy\": \"ALWAYS_REBUILD_WHEN_NEEDED\",
	\"intellistreamJobSpec\": {
		\"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
		\"outputCollection\": \"#{configatron.bdf_outputcollection}\",
		\"executionType\": \"ONGOING\",
		\"timestampField\": \"timestamp\",
		\"startTimestamp\": \"\",
		\"endTimestamp\": \"\",
		\"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
		\"pipelineSpec\": {
			\"primaryStream\": \"#{configatron.bdf_eventname}\",
			\"processingSpecs\": [{
				\"type\": \"FilterSpec\",
				\"stringFilters\": [{
					\"key\": \"apiKey\",
					\"values\": []
				}],
				\"numberFilters\": [],
				\"boolFilters\": [],
				\"rangeFilters\": []
			}]
		},
		\"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.PipelineComputeLogic\"
	},
	\"streamTaskRequired\": false,
	\"searchJSON\": null,
	\"applyFilterMapper\": false,
	\"filterMapper\": null,
	\"cronExpression\": \"0 0/2 * * * ?\",
	\"url\": \"http://testapp.intellifylearning.com\",
	\"hasChainedStreams\": false,
	\"chainedStreamUuids\": []
}"
	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	configatron.bdf_intelliStreamUUID = @responce['uuid']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['active'].should  == true
end

Then(/^Verify that the IntelliSream in the DataCollection was successfully created$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.bdf_intelliStreamUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should  == "#{configatron.bdf_intelliStreamUUID}"
	@responce['active'].should  == true
	@responce['jobRequired'].should  == false
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['cronExpression'].should  == "0 0/2 * * * ?"
end

Then(/^Create new Dynamic Intellistream$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
\"name\": \"RS Basic Dynamic Creation Test #{configatron.bdf_datacollectionuuid}\",
\"type\": \"dynamic\",
\"active\": true,
\"parentDataCollectionId\": \"#{configatron.bdf_datacollectionuuid}\",
\"contextUpdateStrategy\": \"ALWAYS_REBUILD_WHEN_NEEDED\",
\"jobRequired\": false,
\"intellistreamJobSpec\": null,
\"streamTaskRequired\": false,
\"streamTaskSpec\": null,
\"searchJSON\": \"{\\\"chosenFields\\\":[],\\\"aggs\\\":{},\\\"indices\\\":[{\\\"name\\\":\\\"#{configatron.bdf_entityname}\\\",\\\"id\\\":\\\"#{configatron.bdf_entityname}\\\",\\\"state\\\":false},{\\\"name\\\":\\\"#{configatron.bdf_eventname}\\\",\\\"id\\\":\\\"#{configatron.bdf_eventname}\\\",\\\"state\\\":false}],\\\"types\\\":{\\\"event\\\":{\\\"name\\\":\\\"event\\\",\\\"state\\\":false},\\\"entityData\\\":{\\\"name\\\":\\\"entityData\\\",\\\"state\\\":false},\\\"Fact\\\":{\\\"name\\\":\\\"Fact\\\",\\\"state\\\":false},\\\"eventData\\\":{\\\"name\\\":\\\"eventData\\\",\\\"state\\\":false},\\\"DescribeData\\\":{\\\"name\\\":\\\"DescribeData\\\",\\\"state\\\":false},\\\"eventdata\\\":{\\\"name\\\":\\\"eventdata\\\",\\\"state\\\":false},\\\"SubmissionsPerStudent\\\":{\\\"name\\\":\\\"SubmissionsPerStudent\\\",\\\"state\\\":false},\\\"ViewsPerStudent\\\":{\\\"name\\\":\\\"ViewsPerStudent\\\",\\\"state\\\":false},\\\"CourseCompletionPercentagePerStudent\\\":{\\\"name\\\":\\\"CourseCompletionPercentagePerStudent\\\",\\\"state\\\":false},\\\"User\\\":{\\\"name\\\":\\\"User\\\",\\\"state\\\":false},\\\"LearningEventData\\\":{\\\"name\\\":\\\"LearningEventData\\\",\\\"state\\\":false},\\\"eventDataTemp\\\":{\\\"name\\\":\\\"eventDataTemp\\\",\\\"state\\\":false},\\\"entityDataTemp\\\":{\\\"name\\\":\\\"entityDataTemp\\\",\\\"state\\\":false},\\\"QuizScorePerStudent\\\":{\\\"name\\\":\\\"QuizScorePerStudent\\\",\\\"state\\\":false},\\\"temp\\\":{\\\"name\\\":\\\"temp\\\",\\\"state\\\":false},\\\"dashboard\\\":{\\\"name\\\":\\\"dashboard\\\",\\\"state\\\":false}},\\\"filters\\\":{\\\"defined\\\":[{\\\"field\\\":\\\"apiKey\\\",\\\"clause\\\":\\\"term\\\",\\\"value\\\":\\\"qiSc1cZ3RDWr-FsGCerXbQ\\\",\\\"boolOperator\\\":\\\"must\\\"}],\\\"clauseType\\\":\\\"term\\\",\\\"fromOperator\\\":\\\"eq\\\",\\\"toOperator\\\":\\\"eq\\\",\\\"boolOperator\\\":\\\"must\\\",\\\"newField\\\":\\\"apiKey\\\",\\\"newValue\\\":\\\"qiSc1cZ3RDWr-FsGCerXbQ\\\"},\\\"advanced\\\":{\\\"searchFields\\\":[],\\\"newType\\\":\\\"or\\\",\\\"newText\\\":null,\\\"newField\\\":null,\\\"clauseType\\\":\\\"match\\\"},\\\"multiSearch\\\":true,\\\"currentPage\\\":23,\\\"pageSize\\\":10,\\\"term\\\":\\\"\\\",\\\"chosenIndices\\\":[],\\\"chosenTypes\\\":[],\\\"type\\\":\\\"or\\\",\\\"queryJSON\\\":{\\\"query\\\":{\\\"constant_score\\\":{\\\"filter\\\":{\\\"term\\\":{\\\"apiKey\\\":\\\"qiSc1cZ3RDWr-FsGCerXbQ\\\"}},\\\"boost\\\":1}},\\\"aggs\\\":{},\\\"size\\\":10,\\\"from\\\":220},\\\"aggsInQuery\\\":[]}\",
\"cronExpression\": null,
\"courseIds\": [],
\"sharedSecret\": null,
\"url\": null
}"

	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	configatron.bdf_dynamicUUID = @responce['uuid']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['name'].should  == "RS Basic Dynamic Creation Test #{configatron.bdf_datacollectionuuid}"
end

Then(/^Modify Dynamic Intellistream$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
						\"uuid\": \"#{configatron.bdf_dynamicUUID}\",
						\"name\": \"RS Basic Dynamic Creation Test #{configatron.bdf_datacollectionuuid}\",
						\"version\": null,
						\"type\": \"dynamic\",
						\"active\": true,
						\"parentDataCollectionId\": \"#{configatron.bdf_datacollectionuuid}\",
						\"contextUpdateStrategy\": \"ALWAYS_REBUILD_WHEN_NEEDED\",
						\"jobRequired\": false,
						\"intellistreamJobSpec\": null,
						\"streamTaskRequired\": false,
						\"streamTaskSpec\": null,
						\"searchJSON\": \"{\\\"chosenFields\\\":[],\\\"aggs\\\":{},\\\"indices\\\":[{\\\"name\\\":\\\"#{configatron.bdf_entityname}\\\",\\\"id\\\":\\\"#{configatron.bdf_entityname}\\\",\\\"uuid\\\":\\\"#{configatron.bdf_dynamicUUID}\\\",\\\"state\\\":false},{\\\"name\\\":\\\"#{configatron.bdf_eventname}\\\",\\\"id\\\":\\\"#{configatron.bdf_eventname}\\\",\\\"uuid\\\":\\\"#{configatron.bdf_dynamicUUID}\\\",\\\"state\\\":false}],\\\"types\\\":{\\\"event\\\":{\\\"name\\\":\\\"event\\\",\\\"state\\\":false},\\\"entityData\\\":{\\\"name\\\":\\\"entityData\\\",\\\"state\\\":false},\\\"Fact\\\":{\\\"name\\\":\\\"Fact\\\",\\\"state\\\":false},\\\"eventData\\\":{\\\"name\\\":\\\"eventData\\\",\\\"state\\\":false},\\\"DescribeData\\\":{\\\"name\\\":\\\"DescribeData\\\",\\\"state\\\":false},\\\"eventdata\\\":{\\\"name\\\":\\\"eventdata\\\",\\\"state\\\":false},\\\"SubmissionsPerStudent\\\":{\\\"name\\\":\\\"SubmissionsPerStudent\\\",\\\"state\\\":false},\\\"ViewsPerStudent\\\":{\\\"name\\\":\\\"ViewsPerStudent\\\",\\\"state\\\":false},\\\"CourseCompletionPercentagePerStudent\\\":{\\\"name\\\":\\\"CourseCompletionPercentagePerStudent\\\",\\\"state\\\":false},\\\"User\\\":{\\\"name\\\":\\\"User\\\",\\\"state\\\":false},\\\"LearningEventData\\\":{\\\"name\\\":\\\"LearningEventData\\\",\\\"state\\\":false},\\\"eventDataTemp\\\":{\\\"name\\\":\\\"eventDataTemp\\\",\\\"state\\\":false},\\\"entityDataTemp\\\":{\\\"name\\\":\\\"entityDataTemp\\\",\\\"state\\\":false},\\\"QuizScorePerStudent\\\":{\\\"name\\\":\\\"QuizScorePerStudent\\\",\\\"state\\\":false},\\\"temp\\\":{\\\"name\\\":\\\"temp\\\",\\\"state\\\":false},\\\"dashboard\\\":{\\\"name\\\":\\\"dashboard\\\",\\\"state\\\":false}},\\\"filters\\\":{\\\"defined\\\":[{\\\"field\\\":\\\"apiKey\\\",\\\"clause\\\":\\\"term\\\",\\\"value\\\":\\\"IamUpdated-FsGCerXbQ\\\",\\\"boolOperator\\\":\\\"must\\\"}],\\\"clauseType\\\":\\\"term\\\",\\\"fromOperator\\\":\\\"eq\\\",\\\"toOperator\\\":\\\"eq\\\",\\\"boolOperator\\\":\\\"must\\\",\\\"newField\\\":\\\"apiKey\\\",\\\"newValue\\\":\\\"qiSc1cZ3RDWr-FsGCerXbQ\\\"},\\\"advanced\\\":{\\\"searchFields\\\":[],\\\"newType\\\":\\\"or\\\",\\\"newText\\\":null,\\\"newField\\\":null,\\\"clauseType\\\":\\\"match\\\"},\\\"multiSearch\\\":true,\\\"currentPage\\\":23,\\\"pageSize\\\":10,\\\"term\\\":\\\"\\\",\\\"chosenIndices\\\":[],\\\"chosenTypes\\\":[],\\\"type\\\":\\\"or\\\",\\\"queryJSON\\\":{\\\"query\\\":{\\\"constant_score\\\":{\\\"filter\\\":{\\\"term\\\":{\\\"apiKey\\\":\\\"qiSc1cZ3RDWr-FsGCerXbQ\\\"}},\\\"boost\\\":1}},\\\"aggs\\\":{},\\\"size\\\":10,\\\"from\\\":220},\\\"aggsInQuery\\\":[]}\",
						\"cronExpression\": null,
						\"courseIds\": [],
						\"sharedSecret\": null,
						\"url\": null
						}"
	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.bdf_dynamicUUID}")
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['name'].should  == "RS Basic Dynamic Creation Test #{configatron.bdf_datacollectionuuid}"
end

Then(/^Verify Dynamic Intellistream$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.bdf_dynamicUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should  == "#{configatron.bdf_dynamicUUID}"
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['name'].should  == "RS Basic Dynamic Creation Test #{configatron.bdf_datacollectionuuid}"
end

Then(/^Create a intelliview under the Data collection$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@query = "{
	\"name\": \"#{configatron.bdf_intelliview}\",
	\"parentDataCollectionId\": \"#{configatron.bdf_datacollectionuuid}\",
	\"active\": true,
	\"url\": \"http://testapp.intellifylearning.com\",
	\"filterItems\": [{
		\"type\": \"querystring\",
		\"query\": \"contextId: $$contextId$$\",
		\"mandate\": \"must\",
		\"active\": true,
		\"alias\": \"\",
		\"id\": 0
	}]
}"
	@posturl = File.join('https://',@hostname,'/intelliview')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	configatron.bdf_intelliViewUUID = @responce['uuid']
	configatron.bdf_intelliViewName = @responce['name']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  == nil
end

Then(/^Verify that the IntelliView in the DataCollection was successfully created$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intelliview/#{configatron.bdf_intelliViewUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should  == "#{configatron.bdf_intelliViewUUID}"
	@responce['active'].should  == true
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['name'].should  == "#{configatron.bdf_intelliViewName}"
end

Then(/^Verify that the API key in the DataCollection was successfully created$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken


	@posturl = File.join('https://',@hostname,"/apikey/#{configatron.bdf_apiKey}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)


	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['uuid'].should  == "#{configatron.bdf_apiKey}"
	@responce['parentOrgId'].should  == "#{configatron.orgId}"
	@responce['parentDataCollectionId'].should  == "#{configatron.bdf_datacollectionuuid}"
	@responce['apiKeyUrlSafeString'].should  == "#{configatron.bdf_apiKeyUrlSafeString}"
	@responce['active'].should  == true
end

Then(/^Delete the IntelliStream. Assert response code is 204$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.bdf_intelliStreamUUID}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)


	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify that IntelliStream was deleted. Assert response code is 404$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.bdf_intelliStreamUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

Then(/^Delete the Dynamic Stream$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.bdf_dynamicUUID}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify that Dynamic Stream was deleted$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.bdf_dynamicUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

Then(/^Delete the IntelliView. Assert response code is 204$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intelliview/#{configatron.bdf_intelliViewUUID}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify IntelliView was deleted. Assert response code is 404$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/intelliview/#{configatron.bdf_intelliViewUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

Then(/^Delete the DataSource. Assert response code is 204$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/datasource/#{configatron.bdf_datasourceUUID}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify DataSource was deleted. Assert response code is 404$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/datasource/#{configatron.bdf_datasourceUUID}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

Then(/^Delete the API key. Assert response code is 204$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/apikey/#{configatron.bdf_apiKey}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify the API key was deleted. Assert response code is 404$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/apikey/#{configatron.bdf_apiKey}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

Then(/^Delete the DataCollection. Assert response code is 204$/) do

	@hostname = configatron.workbench
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/datacollection/#{configatron.bdf_datacollectionuuid}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)


	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify the DataCollection was deleted. Assert response code is 404$/) do

	@hostname = configatron.workbench	
	@apitoken = configatron.apitoken

	@posturl = File.join('https://',@hostname,"/datacollection/#{configatron.bdf_datacollectionuuid}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end