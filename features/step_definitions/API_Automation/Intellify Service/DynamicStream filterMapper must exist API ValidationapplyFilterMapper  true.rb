
Then(/^"filterMapper" : null Validation$/) do
                    @currnetTimeStamp = Time.new.to_i * 1000
                    configatron.currnetTimeStamp = @currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
                    
	@query = "{
    \"_class\" : \"com.intellify.api.admin.IntelliStream\",
    \"type\" : \"dynamic\",
    \"active\" : true,
    \"parentDataCollectionId\" : \"#{configatron.dataCollectionUUID}\",
    \"contextUpdateStrategy\" : \"ALWAYS_REBUILD_WHEN_NEEDED\",
    \"jobRequired\" : false,
    \"streamTaskRequired\" : false,
    \"searchJSON\" : \"{}\",
    \"applyFilterMapper\" : true,
    \"filterMapper\" : null,
    \"courseIds\" : [],
    \"hasChainedStreams\" : false,
    \"chainedStreamUuids\" : [],
    \"name\" : \"IntellifyQtest-stream-validation\",
    \"version\" : 0
}"
	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 400"
	@responce[0]['field'].should  == "filterMapper"
	@responce[0]['message'].should  == "filterMapper must exists if 'applyFilterMapper' is true"
end

Then(/^Without "filterMapper"  Property$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                    
	@query = "{
    \"_class\" : \"com.intellify.api.admin.IntelliStream\",
    \"type\" : \"dynamic\",
    \"active\" : true,
    \"parentDataCollectionId\" : \"#{configatron.dataCollectionUUID}\",
    \"contextUpdateStrategy\" : \"ALWAYS_REBUILD_WHEN_NEEDED\",
    \"jobRequired\" : false,
    \"streamTaskRequired\" : false,
    \"searchJSON\" : \"{}\",
    \"applyFilterMapper\" : true,
    \"courseIds\" : [],
    \"hasChainedStreams\" : false,
    \"chainedStreamUuids\" : [],
    \"name\" : \"IntellifyQtest-stream-validation\",
    \"version\" : 0
}"
	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 4000"
	@responce[0]['field'].should  == "filterMapper"
	@responce[0]['message'].should  == "filterMapper must exists if 'applyFilterMapper' is true"
end

Then(/^With Valid "filterMapper"  Property$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                    
	@query = "{
    \"_class\" : \"com.intellify.api.admin.IntelliStream\",
    \"type\" : \"dynamic\",
    \"active\" : true,
    \"parentDataCollectionId\" : \"#{configatron.dataCollectionUUID}\",
    \"contextUpdateStrategy\" : \"ALWAYS_REBUILD_WHEN_NEEDED\",
    \"jobRequired\" : false,
    \"streamTaskRequired\" : false,
    \"searchJSON\" : \"{}\",
    \"applyFilterMapper\" : true,
    \"filterMapper\" : {
        \"lookupIntellistreamId\" : \"DummyId_a06ab9f96c7\",
        \"inputParameterName\" : \"custom_classId\",
        \"outputParameterName\" : \"custom_studentIds\",
        \"type\" : \"ENROLLMENT\"
    },
    \"courseIds\" : [],
    \"hasChainedStreams\" : false,
    \"chainedStreamUuids\" : [],
    \"name\" : \"IntellifyQtest-stream-validation\",
    \"version\" : 0
}"
	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

   configatron.validFieldMaaperuuid = @responce['uuid']
	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['uuid'].should_not  ==  nil
	@responce['type'].should  == "dynamic"
	@responce['active'].should  == true
	@responce['applyFilterMapper'].should  == true
	@responce['filterMapper']['lookupIntellistreamId'].should  == "DummyId_a06ab9f96c7"
	@responce['filterMapper']['inputParameterName'].should  == "custom_classId"
	@responce['filterMapper']['type'].should  == "ENROLLMENT"
end

Then(/^Delect the Created Dynamic Stream$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                    
	
	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.validFieldMaaperuuid}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify if its Deleted Successfully$/) do

                    @currnetTimeStamp = configatron.currnetTimeStamp
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken = configatron.apitoken
                    
	
	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.validFieldMaaperuuid}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

