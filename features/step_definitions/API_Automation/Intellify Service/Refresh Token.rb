
Then(/^Refresh token to set expiry in 5 minutes. Assert response code is 200$/) do

                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
										@apitoken =  get_apitoken(@hostname,@username,@password)
										configatron.apitoken = @apitoken
	@query = ""
	@posturl = File.join('https://',@hostname,'/user/refreshApiToken?expiryInSeconds=300')
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  configatron.refreshToken5m = @responce['apiToken']

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
end

Then(/^Verify that refresh token works. Assert response code is 200$/) do

                    @hostname = configatron.workbench

	@posturl = File.join('https://',@hostname,"/org/#{configatron.orgId}")
	@status,@responce, @header = get_request_api(@posturl,configatron.refreshToken5m)

puts "<b>ASSERTIONS</b>"
@status.should == 200
puts "&#10004;Status -- 200 was a number equal to 200"
@responce['uuid'].should  == "#{configatron.orgId}"
@responce['name'].should  == "#{configatron.orgname}"
@responce['type'].should  == "SCHOOL"

end

Then(/^Refresh token to set expiry in 1second. Assert response code is 200$/) do

                    @hostname = configatron.workbench
                    @apitoken = configatron.apitoken
                    
	@query = ""
	@posturl = File.join('https://',@hostname,'/user/refreshApiToken?expiryInSeconds=1')
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
	 configatron.refreshToken1s = @responce['apiToken']

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
end

Then(/^Verify that refresh token has expired. Assert response code is 401$/) do
sleep 1.5
                    @hostname = configatron.workbench
                    @apitoken = configatron.apitoken
                    
	@posturl = File.join('https://',@hostname,"/org/#{configatron.orgId}")
	@status,@responce, @header = get_request_api(@posturl,configatron.refreshToken1s)


	puts "<b>ASSERTIONS</b>"
	@status.should == 401
	puts "&#10004;Status -- 200 was a number equal to 401"
end

Then(/^Refresh token to set expiry in 10minute. Assert response code is 200$/) do

                    
                    @hostname = configatron.workbench
                    @apitoken = configatron.apitoken
                    
	@query = ""
	@posturl = File.join('https://',@hostname,'/user/refreshApiToken?expiryInSeconds=600')
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
	 configatron.refreshToken10m = @responce['apiToken']
	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
end

Then(/^Again Verify that refresh token works. Assert response code is 200$/) do

                    @hostname = configatron.workbench
                    @apitoken = configatron.apitoken

  @posturl = File.join('https://',@hostname,"/org/#{configatron.orgId}")
	@status,@responce, @header = get_request_api(@posturl,configatron.refreshToken10m)


	puts "<b>ASSERTIONS</b>"
	@responce['uuid'].should  == "#{configatron.orgId}"
	@responce['name'].should  == "#{configatron.orgname}"
	@responce['type'].should  == "SCHOOL"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
end

Then(/^Verify with bogus token. Assert response code is 400$/) do

                    @hostname = configatron.workbench
                    @apitoken = configatron.apitoken
                    
	@posturl = File.join('https://',@hostname,"/org/#{configatron.orgId}")
	@status,@responce, @header = get_request_api(@posturl,"bogusAPIToken")


	puts "<b>ASSERTIONS</b>"
	@status.should == 401
	puts "&#10004;Status -- 200 was a number equal to 401"
end

