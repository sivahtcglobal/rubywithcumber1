
Then(/^HMH API Test for lookup-class-roster$/) do
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{\"custom_classId\":\"#{configatron.allClassRoster}\"}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.allClassRosterStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
	@hitcount = @responce['hits']['total']

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
end

