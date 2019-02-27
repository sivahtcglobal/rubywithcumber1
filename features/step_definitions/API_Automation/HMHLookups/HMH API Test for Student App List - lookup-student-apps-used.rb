
Then(/^HMH API Test for Student App List - lookup-student-apps-used$/) do

                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_studentId\": \"#{configatron.lkStuAppsCid}\",
	\"custom_siteId\": \"#{configatron.lkStuAppssiteId}\",
	\"custom_submissionStart\": #{configatron.lkStuAppssubmissionStart},
	\"custom_submissionEnd\": #{configatron.lkStuAppsSumsubmissionEnd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.lkStuAppsStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
	@hitcount = @responce['hits']['total']

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@bucketcount = @responce['aggregations']['students']['buckets'].length
	@bucketcount.should	== 1
	puts "&#10004;Got Bucket Count as 1"
end

