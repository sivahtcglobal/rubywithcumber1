

Then(/^HMH API Test for lookup-all-enrollment-data$/) do

                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{\"custom_classId\":\"#{configatron.allEnrollment}\"}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.allEnrollmentStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@bucketcount = @responce['aggregations']['students']['buckets'].length
	@bucketcount.should == 25
	puts "&#10004;Got Bucket Count as 25"
end

