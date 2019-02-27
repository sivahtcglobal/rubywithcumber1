

Then(/^HMH API Test for Workshop Assessment Class -  workshop-assessment-class-test-list$/) do
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	
       \"custom_classId\":\"#{configatron.classWSACid}\",
	\"custom_siteId\": \"#{configatron.classWSAsiteId}\"
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.classWSAStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@bucketcount = @responce['aggregations']['tests']['buckets'].length
	@bucketcount.should	== 2
	puts "&#10004;Got Bucket Count as 2"
end

