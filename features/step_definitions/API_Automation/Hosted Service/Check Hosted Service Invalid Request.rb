Then(/^Check hosted-services id 0000$/) do

                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
@posturl = File.join('https://',@hostname,'/hosted-services/0000')

	@status,@responce, @header = get_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- '404' was a number equal to 404"
end

