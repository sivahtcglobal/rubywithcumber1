
Then(/^HMH API Test for Independent Reading Class Level  D3 IR Class Dynamic$/) do
	@hostname = configatron.workbench
	@username= configatron.designerUsername
	@password= configatron.designerPassword
	@apitoken =  get_apitoken(@hostname,@username,@password)
	configatron.apitoken = @apitoken

	@query = "{
	\"custom_siteId\": \"#{configatron.irsiteId}\",
	\"custom_classId\": \"#{configatron.irclassId}\",
	\"custom_submissionStart\": #{configatron.irsubmissionStart},
	\"custom_submissionEnd\": #{configatron.irsubmissionEnd},
	\"custom_topBooks\": #{configatron.irTopBooks}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.irStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['hits']['total'].should  == 11
	@responce['hits']['hits'][0]['_source']['score'].should  == 0.9
	@responce['hits']['hits'][0]['_source']['test']['maxPoints'].should  == 5
	@responce['hits']['hits'][0]['_source']['test']['@id'].should  == "s_526"
	@responce['hits']['hits'][0]['_source']['student']['@id'].should  == "a3loq2qffsln9l9n88opmpdv_1cqnue0"
	@responce['hits']['hits'][0]['_source']['book']['lexileScore'].should  == "210L"
	@responce['hits']['hits'][0]['_source']['book']['entityType'].should  == "book"
	@responce['hits']['hits'][0]['_source']['book']['title'].should  == "All Summer in a Day"
	@responce['hits']['hits'][0]['_source']['book']['bookType'].should  == "Fiction"
	@responce['aggregations']['top_books']['buckets'].length.should == 5
end

