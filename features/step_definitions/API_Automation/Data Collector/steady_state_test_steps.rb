When(/^Send one Entity data to Data Source Raw Stream$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  configatron.currnetTimeStamp = @currnetTimeStamp
  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken

  #Sending a Single Entity Json
  @posturl = File.join('https://',@hostname,'/v1custom/entitydata')

  @query = "{
            \"apiKey\": \"#{configatron.apiKey}\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"entityId\": \"smokeTest#{@currnetTimeStamp}\",
            \"entity\": {
            \"iType\": \"smokeTest\",
            \"entityId\": \"smokeTest#{@currnetTimeStamp}\",
            \"@id\": \"Dummy2\",
            \"@type\": \"smokeTest\",
            \"name\": \"Smoke Test\",
            \"dateModified\": #{@currnetTimeStamp},
            \"applicationId\": \"smokeTest\"
            }
            }"
  puts "<b>Sent an Entity Data</b>"
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"

  if ['K12PROD1','K12QA'].include? configatron.environment then
    @status.should == 201
    puts "&#10004;Status -- '201' was a number equal to 201"

    @responce.should include "All records were successfully processed. Received = 1 Successful = 1 Failed = 0. Reference Id ="
    puts "#{@responce}"

  else
  #Assertion for the Entity Sent
  @status.should == 202
  puts "&#10004;Status -- '202' was a number equal to 202"

  @responce['requestId'].should_not == nil
  puts "&#10004;requestId was not null"

  @responce['successful'].should  == 1
  puts "&#10004;body.successful -- '1' contained '1'"

  @responce['failed'].should  == 0
  puts "&#10004;body.failed -- '0' was equal to '0'"
  end
end

When(/^Send one Event data to Data Source Raw Stream$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken

  #Sending a Single Event Json
  @posturl = File.join('https://',@hostname,'/v1custom/eventdata')

  @query = "{
            \"apiKey\": \"#{configatron.apiKey}\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"eventId\": \"smokeTest#{configatron.currnetTimeStamp}\",
            \"event\": {
            \"iType\": \"smokeTest\",
            \"eventId\": \"smokeTest#{configatron.currnetTimeStamp}\",
            \"@context\": \"http://smokeTest.com/ctx/v1/smokeTest\",
            \"@type\": \"http://smokeTest.com/common/v1/smokeTest\",
            \"actor\": {
            \"iType\": \"smoke Test\",
            \"@id\": \"smoeeAPItest1\",
            \"@type\": \"Runscope API Test\",
            \"name\": \"Smoke API Test\"
            },
            \"startedAtTime\": #{configatron.currnetTimeStamp}
            }
            }"
  puts "<b>Sent an Event Data</b>"
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)


  puts "<b>ASSERTIONS</b>"
  #Assertion for the Event Sent
  if ['K12PROD1','K12QA'].include? configatron.environment then
    @status.should == 201
    puts "&#10004;Status -- '201' was a number equal to 201"

    @responce.should include "All records were successfully processed. Received = 1 Successful = 1 Failed = 0. Reference Id ="
    puts "#{@responce}"

  else
  @status.should == 202
  puts "&#10004;Status -- '202' was a number equal to 202"

  @responce['requestId'].should_not == nil
  puts "&#10004;requestId was not null"

  @responce['successful'].should  == 1
  puts "&#10004;body.successful -- '1' contained '1'"

  @responce['failed'].should  == 0
  puts "&#10004;body.failed -- '0' was equal to '0'"
  end
end

When(/^Verify if the Event data got received in ES Raw Stream$/) do

  #Wait for 20 Sec for the Data to flow through Kafka and Ingest into ES
  sleep(20)
  index = "/intellisearch/#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}/_search"
  #Verify that the Event data got received in ES Raw Stream
  @posturl = File.join('https://',configatron.workbench,index)

  @query = "{
            \"query\": {
            \"filtered\": {
            \"filter\": {
            \"bool\": {
            \"must\": [
            {
            \"term\": {
            \"eventId\": \"smokeTest#{configatron.currnetTimeStamp}\"
            }
            }
            ]
            }
            }
            }
            }
            }"

  puts "<b>Verify an Event Data in the ES</b>"
  @status,@responce, @header = post_request_api(@posturl,@query,configatron.apitoken)

  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @hitcount.should == 1
  puts "&#10004;body.hits.total -- '1' was equal to '1'"

end

When(/^Verify if the Entity data got received in ES Raw Stream$/) do
  index = "/intellisearch/#{configatron.entityIndex}-entitydata-#{configatron.datasourceUUID}/_search"
#Verify that the Event data got received in ES Raw Stream
  @posturl = File.join('https://',configatron.workbench,index)

  @query = "{
            \"query\": {
            \"filtered\": {
            \"filter\": {
            \"bool\": {
            \"must\": [
            {
            \"term\": {
            \"sourceTimestamp\": #{configatron.currnetTimeStamp}
            }
            }
            ]
            }
            }
            }
            }
            }"
  puts "<b>Verify an Entity Data in the ES</b>"
  @status,@responce, @header = post_request_api(@posturl,@query,configatron.apitoken)


  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @hitcount.should == 1
  puts "&#10004;body.hits.total -- '1' was equal to '1'"

end

When(/^Verify the Existing DS2.0 Compute Stream Job Status is running$/) do

  if ['K12PROD1','K12QA'].include? configatron.environment then

    index = "intellistream/#{configatron.computestreamUUID}"
  else
    index = "intellistream/#{configatron.computestreamUUID}/status"
  end

  @posturl = File.join('https://',configatron.workbench,index)
  puts "<b>Verify the Existing DS2.0 Compute Stream Job Status is RUNNING</b>"
  @status,@responce, @header = get_request_api(@posturl,configatron.apitoken)

  @state = @responce['state']
  @errorcode = @responce['errorCode']
  @errorMessage = @responce['errorMessage']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  if ['K12PROD1','K12QA'].include? configatron.environment then

    @responce['jobRequired'].should == true

   else

  @state.should == 'RUNNING'
  puts "&#10004;body.state -- 'RUNNING' was equal to 'RUNNING'"

  @errorcode.should == nil
  puts "&#10004;body.errorCode -- was null"

  @errorMessage.should == nil
  puts "&#10004;body.errorMessage -- was null"
  end

end

When(/^Verify if Event Data got Processed by the Compute Stream$/) do
  index = "/intellisearch/#{configatron.computestreamIndex}/_search"
  @posturl = File.join('https://',configatron.workbench,index)

  @query = "{
            \"query\": {
            \"filtered\": {
            \"filter\": {
            \"bool\": {
            \"must\": [
            {
            \"term\": {
            \"startedAtTime\": #{configatron.currnetTimeStamp}
            }
            }
            ]
            }
            }
            }
            }
            }"
  puts "<b>Verify the Event Data got Processed by the Compute Stream</b>"
  @status,@responce, @header = post_request_api(@posturl,@query,configatron.apitoken)

  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @hitcount.should == 1
  puts "&#10004;body.hits.total -- '1' was equal to 1"

end


