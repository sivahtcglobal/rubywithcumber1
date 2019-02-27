Then(/^Obtain authToken and userUUID for User Preference API$/) do
  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword

  @query = "{
            \"username\": \"#{configatron.designerUsername}\",
            \"password\": \"#{configatron.designerPassword}\"
             }"
  @posturl = File.join('https://',@hostname,'/user/login')

  @status,@responce, @header = post_request_api(@posturl,@query,"")
  configatron.apitoken = @responce['password']
  configatron.userUUID = @responce['uuid']

end
  Then(/^Verify the user preference and the status code is 201$/) do

                    @hostname = configatron.workbench
	@query = "{
   \"userUUID\": \"#{configatron.userUUID}\",
   \"name\": \"Runscope User Preference\",	
    \"intelliViewFilterItem\": {
        \"dummyIntelliviewId\": [
            {
                \"type\": \"querystring\",
                \"query\": \"contextId:$contextId$\",
                \"mandate\": \"must\",
                \"active\": true,
                \"alias\": \"\",
                \"id\": 0
            }
        ]
    },
    \"intelliViewTimestampFilterItem\": {
        \"dummyIntelliviewId\": [
            {
                \"type\": \"time\",
                \"field\": \"timestamp\",
                \"from\": \"2016-04-14T04:00:00.000Z\",
                \"to\": \"2018-05-12T04:00:00.000Z\",
                \"mandate\": \"must\",
                \"active\": true,
                \"alias\": \"\",
                \"id\": 0
            }
        ]
    }
}"
	@posturl = File.join('https://',@hostname,'/userpreference')
	@status,@responce, @header = put_request_api(@posturl,@query,configatron.apitoken)
  configatron.userpreferenceUUID = @responce['uuid']

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
end

Then(/^Verify the user UUID and the status code is 200$/) do

                    @hostname = configatron.workbench

	@posturl = File.join('https://',@hostname,"/userpreference/#{configatron.userpreferenceUUID}")
	@status,@responce, @header = get_request_api(@posturl,configatron.apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['userUUID'].should  == "#{configatron.userUUID}"
end

