

Then(/^HMH API Test for spi-class-summary$/) do
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_classId\": \"#{configatron.spiClassSumCid}\",
	\"custom_siteId\": \"#{configatron.spiClassSumsiteId}\",
	\"custom_submissionStart\": #{configatron.spiClassSumsubmissionStart},
	\"custom_submissionEnd\": #{configatron.spiClassSumsubmissionEnd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.spiClassSumStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@bucketcount = @responce['aggregations']['students']['buckets'].length
	@bucketcount.should == 10
	puts "&#10004;Got Bucket Count as 10"
end

