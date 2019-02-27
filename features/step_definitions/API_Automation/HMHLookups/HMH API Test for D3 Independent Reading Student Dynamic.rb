
Then(/^HMH API Test for D3 Independent Reading Student Dynamic$/) do

                    
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)

	@query = "{
	\"custom_siteId\": \"#{configatron.siteId}\",
	\"custom_studentId\": \"#{configatron.studentId}\",
	\"custom_submissionStart\": #{configatron.startDate},
	\"custom_submissionEnd\": #{configatron.endDate}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.hmhLookupDynamicStream}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['hits']['total'].should  == 7
	@responce['hits']['hits'][0]['_source']['student']['@id'].should  == "#{configatron.studentId}"
	@responce['hits']['hits'][0]['_source']['siteId'].should  == "#{configatron.siteId}"
	@responce['hits']['hits'][0]['_source']['submissionDate'].should  >= configatron.startDate
	@responce['hits']['hits'][0]['_source']['submissionDate'].should <= configatron.endDate
end

