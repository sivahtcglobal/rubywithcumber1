
Then(/^Create Computed Intellistream with executionType as 'ONGOING'$/) do

                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  get_apitoken(@hostname,@username,@password)
                    configatron.apitoken = @apitoken
                    
	@query = "{
    \"name\": \"RS Computed Intellistream - ONGOING\",
    \"active\": true,
    \"cronExpression\": \"0 0/1 * 1/1 * ? *\",
    \"pipelineOperationType\": \"compute\",
    \"intellistreamJobSpec\": {
        \"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
        \"outputCollection\": \"xxx-test-runscope-executiontype-ongoing-api\",
        \"executionType\": \"ONGOING\",
        \"timestampField\": \"timestamp\",
        \"startTimestamp\": \"\",
        \"endTimestamp\": \"\",
        \"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
        \"pipelineSpec\": {
            \"primaryStream\": \"#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}\",
            \"processingSpecs\": [
                {
                    \"type\": \"FilterSpec\",
                    \"stringFilters\": [
                        {
                            \"key\": \"apiKey\",
                            \"values\": [
                                \"#{configatron.apiKey}\"
                            ]
                        }
                    ],
                    \"numberFilters\": [],
                    \"boolFilters\": [],
                    \"rangeFilters\": []
                }
            ]
        },
        \"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.PipelineComputeLogic\"
    },
    \"parentDataCollectionId\": \"#{configatron.dataCollectionUUID}\"
}"
	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['name'].should  == "RS Computed Intellistream - ONGOING"
  configatron.computedUUID = @responce['uuid']
end

Then(/^Create Computed Intellistream with executionType as 'BOUNDED'$/) do

                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  configatron.apitoken
                    
	@query = "{
    \"name\": \"RS Computed Intellistream - BOUNDED\",
    \"jobRequired\": true,
    \"active\": true,
    \"cronExpression\": \"0 0/1 * 1/1 * ? *\",
    \"pipelineOperationType\": \"compute\",
    \"intellistreamJobSpec\": {
        \"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
        \"outputCollection\": \"xxx-test-runscope-executiontype-bounded-api\",
        \"executionType\": \"BOUNDED\",
        \"timestampField\": \"timestamp\",
        \"startTimestamp\": \"\",
        \"endTimestamp\": \"\",
        \"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
        \"pipelineSpec\": {
            \"primaryStream\": \"#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}\",
            \"processingSpecs\": [
                {
                    \"type\": \"FilterSpec\",
                    \"stringFilters\": [
                        {
                            \"key\": \"apiKey\",
                            \"values\": [
                                \"#{configatron.apiKey}\"
                            ]
                        }
                    ],
                    \"numberFilters\": [],
                    \"boolFilters\": [],
                    \"rangeFilters\": []
                }
            ]
        },
        \"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.PipelineComputeLogic\"
    },
    \"parentDataCollectionId\": \"#{configatron.dataCollectionUUID}\"
}"
	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 201
	puts "&#10004;Status -- 201 was a number equal to 201"
	@responce['name'].should  == "RS Computed Intellistream - BOUNDED"
  configatron.computedUUID2 = @responce['uuid']
end

Then(/^Create Computed Intellistream with Invalid executionType - expect fail$/) do

                    
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  configatron.apitoken
                    
	@query = "{
    \"name\": \"RS Computed Intellistream With Invalid Execution Type\",
    \"jobRequired\": true,
    \"active\": true,
    \"cronExpression\": \"0 0/1 * 1/1 * ? *\",
    \"pipelineOperationType\": \"compute\",
    \"intellistreamJobSpec\": {
        \"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
        \"outputCollection\": \"xxx-test-runscope-invalid-executiontype-api\",
        \"executionType\": \"DIRECT\",
        \"timestampField\": \"timestamp\",
        \"startTimestamp\": \"\",
        \"endTimestamp\": \"\",
        \"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
        \"pipelineSpec\": {
            \"primaryStream\": \"#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}\",
            \"processingSpecs\": [
                {
                    \"type\": \"FilterSpec\",
                    \"stringFilters\": [
                        {
                            \"key\": \"apiKey\",
                            \"values\": [
                                \"#{configatron.apiKey}\"
                            ]
                        }
                    ],
                    \"numberFilters\": [],
                    \"boolFilters\": [],
                    \"rangeFilters\": []
                }
            ]
        },
        \"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.PipelineComputeLogic\"
    },
    \"parentDataCollectionId\": \"#{configatron.dataCollectionUUID}\"
}"
	@posturl = File.join('https://',@hostname,'/intellistream/')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  if @status == 201 then
    @failuuid = @responce['uuid']
    @posturl = File.join('https://',@hostname,"/intellistream/#{@failuuid}")
    @status,@responce, @header = delete_request_api(@posturl,@query,@apitoken)
  end

	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 400"
	@responce[0]['field'].should  == "executionType"
	@responce[0]['message'].should  == "intelliStreamJobSpec executionType must be one of these values [ONGOING, BOUNDED]"
end

Then(/^Delete Computed Intellistream for executionType as 'BOUNDED'$/) do

                    
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  configatron.apitoken
                    
	
	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.computedUUID2}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify that IntelliStream for executionType as 'BOUNDED' was deleted. Assert response code is 404$/) do

                    
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  configatron.apitoken
                    
	
	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.computedUUID2}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end

Then(/^Delete Computed Intellistream for executionType as 'ONGOING'$/) do

                    
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  configatron.apitoken
                    
	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.computedUUID}")
	@status,@responce, @header = delete_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 204
	puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify that IntelliStream for executionType as 'ONGOING' was deleted. Assert response code is 404$/) do

                    
                    @hostname = configatron.workbench
                    @username= configatron.designerUsername
                    @password= configatron.designerPassword
                    @apitoken =  configatron.apitoken
                    
	@posturl = File.join('https://',@hostname,"/intellistream/#{configatron.computedUUID2}")
	@status,@responce, @header = get_request_api(@posturl,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 404
	puts "&#10004;Status -- 404 was a number equal to 404"
end


