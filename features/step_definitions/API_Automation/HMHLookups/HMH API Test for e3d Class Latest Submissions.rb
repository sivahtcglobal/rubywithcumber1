

Then(/^HMH API Test for e3d Class Latest Submissions$/) do
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_siteId\": \"#{configatron.e3dsiteId}\",
	\"custom_classId\": \"#{configatron.e3dclassId}\",
	\"custom_submissionStart\": #{configatron.e3dsubmissionStart},
	\"custom_submissionEnd\": #{configatron.e3dsubmissionEnd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.e3dStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['aggregations']['students']['buckets'][0]['testsByStudent']['buckets'][0]['latestSubmission']['hits']['total'].should == 2
	@responce['aggregations']['students']['buckets'][0]['testsByStudent']['buckets'][0]['latestSubmission']['hits']['hits'][0]['_source']['assessment']['siteId'].should == 'h502000001'
  @responce['aggregations']['students']['buckets'][0]['testsByStudent']['buckets'][0]['latestSubmission']['hits']['hits'][0]['_source']['student']['@id'].should == 'eja9b52g1morl1dt9krsc4lp_1cqnue0'
end

