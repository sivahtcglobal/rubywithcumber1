
Then(/^HMH API Test for D3 SRI Class Dynamic$/) do

	@hostname = configatron.workbench
	@username= configatron.designerUsername
	@password= configatron.designerPassword
	@apitoken =  get_apitoken(@hostname,@username,@password)
	configatron.apitoken = @apitoken


  @query = "{
						\"custom_siteId\": \"#{configatron.sriD3siteId}\",
						\"custom_classId\": \"#{configatron.sriD3classId}\",
						\"custom_submissionStart\": #{configatron.sriD3submissionStart},
						\"custom_submissionEnd\": #{configatron.sriD3submissionEnd}
						}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.sriD3StreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['aggregations']['students']['buckets'][0]['submissionDate']['hits']['total'].should  == 12
	@responce['aggregations']['students']['buckets'][0]['submissionDate']['hits']['hits'][0]['_source']['event']['generated']['endLexileScore'].should  == 1164
end

