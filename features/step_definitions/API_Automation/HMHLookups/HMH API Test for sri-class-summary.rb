
Then(/^HMH API Test for sri-class-summary$/) do
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_classId\": \"#{configatron.sriClassSumCid}\",
	\"custom_siteId\": \"#{configatron.sriClassSumsiteId}\",
	\"custom_submissionStart\": #{configatron.sriClassSumsubmissionStart},
	\"custom_submissionEnd\": #{configatron.sriClassSumsubmissionEnd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.sriClassSumStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@bucketcount = @responce['aggregations']['students']['buckets'].length
	@bucketcount.should == 3
	puts "&#10004;Got Bucket Count as 3"
end

