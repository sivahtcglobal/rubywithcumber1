When(/^Setting a new Timezone (.*) for an account$/) do |timezone|
  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken
  @timezoneSplit = timezone.split("(")
  @timezone = @timezoneSplit[0].strip
  @query = "{
          \"timezone\" : \"#{@timezone}\"
            }"
  @posturl = File.join('https://',@hostname,'/api/concierge/v1/account/timezone')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
  configatron.refreshToken5m = @responce['apiToken']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "Got 200"
  @responce['timezone'].should == @timezone
  puts "Got timezone as #{@responce['timezone']}"

end
Then(/^The Account should get updated with the new (.*) Timezone$/) do |timezone|
  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @timezoneSplit = timezone.split("(")
  @timezone = @timezoneSplit[0].strip

  @posturl = File.join('https://',@hostname,'/api/concierge/v1/account/timezone')
  @status,@responce, @header = get_request_api(@posturl,@apitoken)
  configatron.refreshToken5m = @responce['apiToken']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "Got 200"
  @responce['timezone'].should == @timezone
  puts "Got timezone as #{@responce['timezone']}"
end


#Invalid Scenario

When(/^Setting an invalid Timezone should not get updated to the account$/) do
  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
          \"timezone\" : \"InvalidTimeZone\"
            }"
  @posturl = File.join('https://',@hostname,'/api/concierge/v1/account/timezone')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
  configatron.refreshToken5m = @responce['apiToken']

  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "Got Status Code as 400"
  @responce['message'].should == "INT-1: TimeZone is not valid: InvalidTimeZone"
  puts "Got Response as 'INT-1: TimeZone is not valid: InvalidTimeZone'"
end