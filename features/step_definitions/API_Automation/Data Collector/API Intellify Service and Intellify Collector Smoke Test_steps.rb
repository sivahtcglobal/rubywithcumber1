
Then(/^Check Intellify Service$/) do

  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken

	@posturl = File.join('https://',@hostname,'/about')
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce['about'].should include"Intellify Learning - Intellify Service."
	puts "&#10004;Response contains `Intellify Learning - Intellify Service.`"
end

Then(/^Check Intellify Collector$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

	@posturl = File.join('https://',@hostname,'/v1custom/about')
	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"
	@responce.should include"Intellify Collector"
	puts "&#10004;Response contains `Intellify Collector`"
end

