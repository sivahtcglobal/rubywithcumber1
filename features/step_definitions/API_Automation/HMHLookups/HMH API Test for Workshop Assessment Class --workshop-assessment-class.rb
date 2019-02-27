

Then(/^HMH API Test for Workshop Assessment Class --workshop-assessment-class$/) do
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_testId\": \"#{configatron.classWSATestidCls}\",
       \"custom_classId\":\"#{configatron.classWSACidCls}\",
	\"custom_siteId\": \"#{configatron.classWSAsiteIdCls}\",
	\"custom_submissionStart\": #{configatron.classWSAsubmissionStartCls},
	\"custom_submissionEnd\": #{configatron.classWSASumsubmissionEndCls}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.classWSAStreamIdCls}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@bucketcount = @responce['aggregations']['students']['buckets'].length
	@bucketcount.should	== 6
	puts "&#10004;Got Bucket Count as 6"
end

