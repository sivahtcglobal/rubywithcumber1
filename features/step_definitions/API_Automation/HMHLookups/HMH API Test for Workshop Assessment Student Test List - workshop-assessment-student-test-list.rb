

Then(/^HMH API Test for Workshop Assessment Student Test List - workshop-assessment-student-test-list$/) do

                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_testId\": \"#{configatron.listWSAtstdid}\",
	\"custom_studentId\": \"#{configatron.listWSAstdid}\",
	\"custom_classId\": \"#{configatron.listWSACidstd}\",
	\"custom_siteId\": \"#{configatron.listWSAsiteIdste}\",
	\"custom_submissionStart\": #{configatron.listWSAsubmissionStartstd},
	\"custom_submissionEnd\": #{configatron.listWSASumsubmissionEndstd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.listWSAStreamIdstd}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@bucketcount = @responce['aggregations']['students']['buckets'].length
	@bucketcount.should	== 2
	puts "&#10004;Got Bucket Count as 2"
end

