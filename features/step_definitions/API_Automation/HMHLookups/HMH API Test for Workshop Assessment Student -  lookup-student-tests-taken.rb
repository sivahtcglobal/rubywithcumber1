

Then(/^HMH API Test for Workshop Assessment Student -  lookup-student-tests-taken$/) do

	@hostname = configatron.workbench
	@username= configatron.designerUsername
	@password= configatron.designerPassword
	@apitoken =  get_apitoken(@hostname,@username,@password)
	configatron.apitoken = @apitoken

	@query = "{
	\"custom_studentId\": \"#{configatron.takenWSAstdid}\",
       \"custom_classId\":\"#{configatron.takenWSACidstd}\",
	\"custom_siteId\": \"#{configatron.takenWSAsiteIdste}\",
	\"custom_submissionStart\": #{configatron.takenWSAsubmissionStartstd},
	\"custom_submissionEnd\": #{configatron.takenWSASumsubmissionEndstd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.takenWSAStreamIdstd}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
end

