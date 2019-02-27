

Then(/^HMH API Test for Workshop Assessment Student - workshop-assessment-student$/) do
@currnetTimeStamp = Time.new.to_i * 1000
                    configatron.currnetTimeStamp = @currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_testId\": \"#{configatron.testWSAtstdid}\",
	\"custom_studentId\": \"#{configatron.testWSAstdid}\",
	\"custom_classId\": \"#{configatron.testWSACidstd}\",
	\"custom_siteId\": \"#{configatron.testWSAsiteIdste}\",
	\"custom_submissionStart\": #{configatron.testWSAsubmissionStartstd},
	\"custom_submissionEnd\": #{configatron.testWSASumsubmissionEndstd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.testWSAStreamIdstd}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
@bucketcount = @responce['aggregations']['students']['buckets'].length
@bucketcount.should	== 1
puts "&#10004;Got Bucket Count as 1"
end

