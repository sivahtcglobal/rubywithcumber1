
When(/^Login and obtain authToken for explicitSessionDuration accumulator$/) do

  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken

end

Then(/^Validate with Invalid Window type GroupRollingSpec$/) do
    
  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  
  @query = "{

  \"name\": \"Selenium Test for explicitSessionDuration Window Type\",
  \"type\": \"computed\",
  \"active\": true,
  \"parentDataCollectionId\": \"#{configatron.dataCollectionUUID}\",
  \"contextUpdateStrategy\": \"ALWAYS_REBUILD_WHEN_NEEDED\",
  \"jobRequired\": true,
  \"intellistreamJobSpec\": {
    \"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
    \"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.SessionizationComputeLogic\",
    \"dataCollection\": null,
    \"sensorIds\": null,
    \"actions\": null,
    \"executionType\": \"ONGOING\",
    \"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
    \"executionOffset\": 0,
    \"timeSlice\": null,
    \"timestampField\": \"timestamp\",
    \"startTimestamp\": 0,
    \"endTimestamp\": 0,
    \"daysToCalculate\": null,
    \"outputCollection\": \"data-selenium-explicitsessionduration-validation-test-output\",
    \"outputCollectionUpsertKey\": null,
    \"outputStored\": true,
    \"outputIndexed\": true,
    \"bulkSaveIndex\": true,
    \"cursorBatchSize\": 500,
    \"usingSharedJoinStreamCache\": false,
    \"runOnceBatchSize\": -1,
    \"runOnceTotalRecordsSize\": -1,
    \"runOnceSortField\": \"timestamp\",
    \"pipelineSpec\": {
      \"primaryStream\": \"data-dummy-stream-selenium-eventdata\",
      \"primaryStreamPartitions\": 5,
      \"processingSpecs\": [
        {
          \"type\": \"GroupSpec\",
          \"groupFields\": {
            \"studentId\": \"event.actor.@id\"
          },
          \"window\": {
            \"type\": \"GroupRollingSpec\",
            \"timeoutSecs\": 2400
          },
          \"groupFunctions\": [
            {
              \"computedField\": \"timeSpent\",
              \"accumulator\": \"explicitSessionDuration\",
              \"expression\": {
                \"_type\": \"field\",
                \"explicitClosePath\": \"event.action\",
                \"explicitCloseValue\": \"SEGMENT_EXITED\",
                \"field\": \"sourceTimestamp\"
              }
            }
          ],
          \"keyFields\": {
            \"studentId\": \"event.actor.@id\"
          }
        }
      ]
    }
  },
  \"streamTaskRequired\": false,
  \"searchJSON\": null,
  \"applyFilterMapper\": false,
  \"filterMapper\": null,
  \"cronExpression\": \"0 0/1 * 1/1 * ? *\",
  \"courseIds\": [],
  \"sharedSecret\": null,
  \"url\": null,
  \"hasChainedStreams\": false,
  \"chainedStreamUuids\": []

}"
  @posturl = File.join('https://',@hostname,'/intellistream/')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
  

  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 400 was a number equal to 400"
  @responce[0]['field'].should  == "explicitSessionDuration"
  @responce[0]['message'].should  == "explicitSessionDuration accumulator not allowed unless group window is GroupSessionWindowSpec"
end

Then(/^Validate with Invalid Window type GroupTimeWindowSpec$/) do
  
  
  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  
  @query = "{

  \"name\": \"Selenium Test for explicitSessionDuration Window Type\",
  \"type\": \"computed\",
  \"active\": true,
  \"parentDataCollectionId\": \"#{configatron.dataCollectionUUID}\",
  \"contextUpdateStrategy\": \"ALWAYS_REBUILD_WHEN_NEEDED\",
  \"jobRequired\": true,
  \"intellistreamJobSpec\": {
    \"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
    \"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.SessionizationComputeLogic\",
    \"dataCollection\": null,
    \"sensorIds\": null,
    \"actions\": null,
    \"executionType\": \"ONGOING\",
    \"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
    \"executionOffset\": 0,
    \"timeSlice\": null,
    \"timestampField\": \"timestamp\",
    \"startTimestamp\": 0,
    \"endTimestamp\": 0,
    \"daysToCalculate\": null,
    \"outputCollection\": \"data-selenium-explicitsessionduration-validation-test-output\",
    \"outputCollectionUpsertKey\": null,
    \"outputStored\": true,
    \"outputIndexed\": true,
    \"bulkSaveIndex\": true,
    \"cursorBatchSize\": 500,
    \"usingSharedJoinStreamCache\": false,
    \"runOnceBatchSize\": -1,
    \"runOnceTotalRecordsSize\": -1,
    \"runOnceSortField\": \"timestamp\",
    \"pipelineSpec\": {
      \"primaryStream\": \"data-dummy-stream-selenium-eventdata\",
      \"primaryStreamPartitions\": 5,
      \"processingSpecs\": [
        {
          \"type\": \"GroupSpec\",
          \"groupFields\": {
            \"studentId\": \"event.actor.@id\"
          },
          \"window\": {
            \"type\": \"GroupTimeWindowSpec\",
            \"timeoutSecs\": 2400
          },
          \"groupFunctions\": [
            {
              \"computedField\": \"timeSpent\",
              \"accumulator\": \"explicitSessionDuration\",
              \"expression\": {
                \"_type\": \"field\",
                \"explicitClosePath\": \"event.action\",
                \"explicitCloseValue\": \"SEGMENT_EXITED\",
                \"field\": \"sourceTimestamp\"
              }
            }
          ],
          \"keyFields\": {
            \"studentId\": \"event.actor.@id\"
          }
        }
      ]
    }
  },
  \"streamTaskRequired\": false,
  \"searchJSON\": null,
  \"applyFilterMapper\": false,
  \"filterMapper\": null,
  \"cronExpression\": \"0 0/1 * 1/1 * ? *\",
  \"courseIds\": [],
  \"sharedSecret\": null,
  \"url\": null,
  \"hasChainedStreams\": false,
  \"chainedStreamUuids\": []

}"
  @posturl = File.join('https://',@hostname,'/intellistream/')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
  

  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 400 was a number equal to 400"
  @responce[0]['field'].should  == "explicitSessionDuration"
  @responce[0]['message'].should  == "explicitSessionDuration accumulator not allowed unless group window is GroupSessionWindowSpec"
end

Then(/^Validate with  Window type GroupExplicitSessionWindowSpec$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  
  @query = "{

  \"name\": \"Delete Me Selenium Test for explicitSessionDuration Window Type\",
  \"type\": \"computed\",
  \"active\": true,
  \"parentDataCollectionId\": \"#{configatron.dataCollectionUUID}\",
  \"contextUpdateStrategy\": \"ALWAYS_REBUILD_WHEN_NEEDED\",
  \"jobRequired\": true,
  \"intellistreamJobSpec\": {
    \"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
    \"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.SessionizationComputeLogic\",
    \"dataCollection\": null,
    \"sensorIds\": null,
    \"actions\": null,
    \"executionType\": \"ONGOING\",
    \"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
    \"executionOffset\": 0,
    \"timeSlice\": null,
    \"timestampField\": \"timestamp\",
    \"startTimestamp\": 0,
    \"endTimestamp\": 0,
    \"daysToCalculate\": null,
    \"outputCollection\": \"data-selenium-explicitsessionduration-validation-test-output\",
    \"outputCollectionUpsertKey\": null,
    \"outputStored\": true,
    \"outputIndexed\": true,
    \"bulkSaveIndex\": true,
    \"cursorBatchSize\": 500,
    \"usingSharedJoinStreamCache\": false,
    \"runOnceBatchSize\": -1,
    \"runOnceTotalRecordsSize\": -1,
    \"runOnceSortField\": \"timestamp\",
    \"pipelineSpec\": {
      \"primaryStream\": \"data-dummy-stream-selenium-eventdata\",
      \"primaryStreamPartitions\": 5,
      \"processingSpecs\": [
        {
          \"type\": \"GroupSpec\",
          \"groupFields\": {
            \"studentId\": \"event.actor.@id\"
          },
          \"window\": {
            \"type\": \"GroupExplicitSessionWindowSpec\",
            \"timeoutSecs\": 2400
          },
          \"groupFunctions\": [
            {
              \"computedField\": \"timeSpent\",
              \"accumulator\": \"explicitSessionDuration\",
              \"expression\": {
                \"_type\": \"field\",
                \"explicitClosePath\": \"event.action\",
                \"explicitCloseValue\": \"SEGMENT_EXITED\",
                \"field\": \"sourceTimestamp\"
              }
            }
          ],
          \"keyFields\": {
            \"studentId\": \"event.actor.@id\"
          }
        }
      ]
    }
  },
  \"streamTaskRequired\": false,
  \"searchJSON\": null,
  \"applyFilterMapper\": false,
  \"filterMapper\": null,
  \"cronExpression\": \"0 0/1 * 1/1 * ? *\",
  \"courseIds\": [],
  \"sharedSecret\": null,
  \"url\": null,
  \"hasChainedStreams\": false,
  \"chainedStreamUuids\": []

}"
  @posturl = File.join('https://',@hostname,'/intellistream/')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  configatron.explicitWindowUUID = @responce['uuid']

  puts "<b>ASSERTIONS</b>"
  @status.should == 201
  puts "&#10004;Status -- 201 was a number equal to 201"
  @responce['uuid'].should_not  == nil
end

Then(/^Validate with Valid Window type GroupSessionWindowSpec$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  
  @query = "{

  \"name\": \"Selenium Test for explicitSessionDuration Window Type\",
  \"type\": \"computed\",
  \"active\": true,
  \"parentDataCollectionId\": \"#{configatron.dataCollectionUUID}\",
  \"contextUpdateStrategy\": \"ALWAYS_REBUILD_WHEN_NEEDED\",
  \"jobRequired\": true,
  \"intellistreamJobSpec\": {
    \"jobClass\": \"com.intellify.jobs.datacollection.AggregationJob\",
    \"computeLogicClass\": \"com.intellify.jobs.tasks.aggregation.SessionizationComputeLogic\",
    \"dataCollection\": null,
    \"sensorIds\": null,
    \"actions\": null,
    \"executionType\": \"ONGOING\",
    \"executionFrequency\": \"0 0/1 * 1/1 * ? *\",
    \"executionOffset\": 0,
    \"timeSlice\": null,
    \"timestampField\": \"timestamp\",
    \"startTimestamp\": 0,
    \"endTimestamp\": 0,
    \"daysToCalculate\": null,
    \"outputCollection\": \"data-selenium-explicitsessionduration-validation-test-output\",
    \"outputCollectionUpsertKey\": null,
    \"outputStored\": true,
    \"outputIndexed\": true,
    \"bulkSaveIndex\": true,
    \"cursorBatchSize\": 500,
    \"usingSharedJoinStreamCache\": false,
    \"runOnceBatchSize\": -1,
    \"runOnceTotalRecordsSize\": -1,
    \"runOnceSortField\": \"timestamp\",
    \"pipelineSpec\": {
      \"primaryStream\": \"data-dummy-stream-selenium-eventdata\",
      \"primaryStreamPartitions\": 5,
      \"processingSpecs\": [
        {
          \"type\": \"GroupSpec\",
          \"groupFields\": {
            \"studentId\": \"event.actor.@id\"
          },
          \"window\": {
            \"type\": \"GroupSessionWindowSpec\",
            \"timeoutSecs\": 2400
          },
          \"groupFunctions\": [
            {
              \"computedField\": \"timeSpent\",
              \"accumulator\": \"explicitSessionDuration\",
              \"expression\": {
                \"_type\": \"field\",
                \"explicitClosePath\": \"event.action\",
                \"explicitCloseValue\": \"SEGMENT_EXITED\",
                \"field\": \"sourceTimestamp\"
              }
            }
          ],
          \"keyFields\": {
            \"studentId\": \"event.actor.@id\"
          }
        }
      ]
    }
  },
  \"streamTaskRequired\": false,
  \"searchJSON\": null,
  \"applyFilterMapper\": false,
  \"filterMapper\": null,
  \"cronExpression\": \"0 0/1 * 1/1 * ? *\",
  \"courseIds\": [],
  \"sharedSecret\": null,
  \"url\": null,
  \"hasChainedStreams\": false,
  \"chainedStreamUuids\": []

}"
  @posturl = File.join('https://',@hostname,'/intellistream/')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
  configatron.groupWindowUUID = @responce['uuid']

  puts "<b>ASSERTIONS</b>"
  @status.should == 201
  puts "&#10004;Status -- 201 was a number equal to 201"
  @responce['uuid'].should_not  == nil
      @responce['type'].should  == "computed"
  @responce['active'].should  == true
  @responce['intellistreamJobSpec']['pipelineSpec']['processingSpecs'][0]['window']['type'].should  == "GroupSessionWindowSpec"
  @responce['intellistreamJobSpec']['pipelineSpec']['processingSpecs'][0]['groupFunctions'][0]['accumulator'].should  == "explicitSessionDuration"
end

Then(/^Delete the Compute stream created using the Valid Window Type$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken

  @posturl = File.join('https://',@hostname,"/intellistream/#{configatron.explicitWindowUUID}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)
  

  puts "<b>ASSERTIONS</b>"
  @status.should == 204
  puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Delete the Compute stream  Window Type GroupExplicitSessionWindowSpec$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken

  @posturl = File.join('https://',@hostname,"/intellistream/#{configatron.groupWindowUUID}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)
  

  puts "<b>ASSERTIONS</b>"
  @status.should == 204
  puts "&#10004;Status -- 204 was a number equal to 204"
end

Then(/^Verify compute stream created with GroupExplicitSessionWindowSpec deleted successfully$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken


  @posturl = File.join('https://',@hostname,"/intellistream/#{configatron.explicitWindowUUID}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)


  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 400 was a number equal to 400"
  @responce['code'].should  == 400
  @responce['message'].should  include "Entity to delete did not exist"
end

Then(/^Verify compute stream created with GroupSessionWindowSpec deleted successfully$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken


  @posturl = File.join('https://',@hostname,"/intellistream/#{configatron.groupWindowUUID}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)


  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 400 was a number equal to 400"
  @responce['code'].should  == 400
  @responce['message'].should  include"Entity to delete did not exist"
end