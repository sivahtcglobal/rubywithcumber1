

Then(/^HMH API Test for r180u-class-zones$/) do
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
	@query = "{
	\"custom_classId\": \"#{configatron.r180ClassZoneCid}\",
	\"custom_siteId\": \"#{configatron.r180ClassZonesiteId}\",
	\"custom_submissionStart\": #{configatron.r180ClassZonesubmissionStart},
	\"custom_submissionEnd\": #{configatron.r180ClassZonesubmissionEnd}
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/dynamic/#{configatron.r180ClassZoneStreamId}")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
  @bucketcount = @responce['aggregations']['zones']['buckets'].length
	@bucketcount.should	== 3
  puts "&#10004;Got Bucket Count as 3"
end

