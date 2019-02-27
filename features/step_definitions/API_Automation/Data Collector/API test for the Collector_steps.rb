
When(/^Send Entity data to the raw stream$/) do

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
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
        \"@type\": \"USER\",
        \"name\": \"Selenium APITest\",
        \"dateModified\": #{@currnetTimeStamp},
        \"applicationId\": \"APICollectorTest\",
        \"siteId\": \"h900000031\",
        \"jvmId\": \"sam-app013\",
        \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"firstName\": \"Selenium\",
        \"lastName\": \"APITest\",
        \"gradeLevel\": \"3\",
        \"classId\": null,
        \"roles\": [
            \"Student\"],
        \"userType\": \"Student\",
        \"userState\": \"CREATED\",
        \"userStatus\": null,
        \"description\": null,
        \"properties\": null,
        \"dateCreated\": 0    }}"

    puts "<b>Sent an Entity Data</b>"
    @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

    puts "<b>ASSERTIONS</b>"
    if ['K12PROD1','K12QA'].include? configatron.environment then
        @status.should == 201
        puts "&#10004;Status -- '201' was a number equal to 201"

        @responce.should include"All records were successfully processed. Received = 1 Successful = 1 Failed = 0. Reference Id ="
        puts "#{@responce}"

    else

    #Assertion for the Entity Sent
    @status.should == 202
    puts "&#10004;Status -- '202' was a number equal to 202"
    @responce['successful'].should  == 1
    puts "&#10004;body.successful -- '1' contained '1'"
    @responce['failed'].should  == 0
    puts "&#10004;body.failed -- '0' was equal to '0'"
    end

end

When(/^Send Entity data with Bad SensorId - expect fail$/) do


    @hostname = configatron.workbench
    @apitoken = configatron.apitoken

    #Sending a Single Entity Json
    @posturl = File.join('https://',@hostname,'/v1custom/entitydata')
    @query = "{

    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"BAD_SENSOR_ID\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
        \"@type\": \"USER\",
        \"name\": \"Selenium APITest\",
        \"dateModified\": #{configatron.currnetTimeStamp},
        \"applicationId\": \"APICollectorTest\",
        \"siteId\": \"h900000031\",
        \"jvmId\": \"sam-app013\",
        \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"firstName\": \"Selenium\",
        \"lastName\": \"APITest\",
        \"gradeLevel\": \"3\",
        \"classId\": null,
        \"roles\": [
            \"Student\"
        ],
        \"userType\": \"Student\",
        \"userState\": \"CREATED\",
        \"userStatus\": null,
        \"description\": null,
        \"properties\": null,
        \"dateCreated\": 0    }}"

    puts "<b>Sent an Entity Data</b>"
    @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

    puts "<b>ASSERTIONS</b>"
    #Assertion for the Entity Sent
    @status.should == 400
    puts "&#10004;Status -- '400' was a number equal to 400"

   case configatron.collectorVersion

      when 'OLD'

          @responce['requestId'].should_not  == nil
          puts "&#10004;body.requestId -- was not null"

          @responce['successful'].should  == 0
          puts "&#10004;body.successful -- '0' contained '0'"

          @responce['failed'].should  == 1
          puts "&#10004;body.failed -- '1' was equal to '1'"

          @responce['error'].should  == "Invalid sensorId: BAD_SENSOR_ID"
          puts "&#10004;Invalid sensorId: BAD_SENSOR_ID' was equal to 'Invalid sensorId: BAD_SENSOR_ID"

      else
            @responce['error'].should  == "Invalid sensorIds: [BAD_SENSOR_ID]"
            puts "&#10004;Invalid sensorIds: [BAD_SENSOR_ID]' was equal to 'Invalid sensorIds: [BAD_SENSOR_ID]"
    end
end


When(/^Send Entity data with Bad API Key$/) do

    @hostname = configatron.workbench
    @apitoken = configatron.apitoken

    #Sending a Single Entity Json
    @posturl = File.join('https://',@hostname,'/v1custom/entitydata')
    @query = "{
    \"name\": null,
    \"apiKey\": \"INVALID-API-KEY-FOR-ENTITY\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
        \"@type\": \"USER\",
        \"name\": \"Selenium APITest\",
        \"dateModified\": #{configatron.currnetTimeStamp},
        \"applicationId\": \"APICollectorTest\",
        \"siteId\": \"h900000031\",
        \"jvmId\": \"sam-app013\",
        \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"firstName\": \"Selenium\",
        \"lastName\": \"APITest\",
        \"gradeLevel\": \"3\",
        \"classId\": null,
        \"roles\": [
            \"Student\"
        ],
        \"userType\": \"Student\",
        \"userState\": \"CREATED\",
        \"userStatus\": null,
        \"description\": null,
        \"properties\": null,
        \"dateCreated\": 0    }

}"

    puts "<b>Sent an Entity Data</b>"
    @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

    puts "<b>ASSERTIONS</b>"

    #Assertion for the Entity Sent
    @status.should == 400
    puts "&#10004;Status -- '400' was a number equal to 400"

   case configatron.collectorVersion

    when 'OLD'

    @responce['requestId'].should_not  == nil
    puts "&#10004;body.requestId -- was not null"

    @responce['successful'].should  == 0
    puts "&#10004;body.successful -- '0' contained '0'"

    @responce['failed'].should  == 1
    puts "&#10004;body.failed -- '1' was equal to '1'"

    @responce['error'].should  == "Invalid api key: INVALID-API-KEY-FOR-ENTITY"
    puts "&#10004;error was equal to 'Invalid api key: INVALID-API-KEY-FOR-ENTITY"

    else
    @responce['error'].should  == "Invalid api keys: [INVALID-API-KEY-FOR-ENTITY]"
    puts "&#10004;error was equal to 'Invalid api keys: [INVALID-API-KEY-FOR-ENTITY]"
end


end
When(/^Sent Entity with entity.dateModified type changed from long to String$/) do


    @hostname = configatron.workbench
    @apitoken = configatron.apitoken

    #Generate Past ISO Date Within 5 Years
    currentDate = Time.new
    currentYear = Date.today.year
    currentDate_string = currentDate.to_s
    removeMS = currentDate_string.split('+')
    removeMS[0].strip!
    dateString = removeMS[0]+'.'+removeMS[1]
    addT = dateString.tr(" ","T") + "Z"

    yearWithin5Years = currentYear - 1
    configatron.pastISODateTimeWithinFiveYears = addT.tr(currentYear.to_s,yearWithin5Years.to_s)

    #Sending a Single Entity Json
    @posturl = File.join('https://',@hostname,'/v1custom/entitydata')
    @query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
        \"@type\": \"USER\",
        \"name\": \"Selenium APICollectorTest\",
        \"dateModified\": \"#{configatron.pastISODateTimeWithinFiveYears}\",
        \"applicationId\": \"Intellify\",
        \"siteId\": \"h900000031\",
        \"jvmId\": \"sam-app013\",
        \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\",
        \"firstName\": \"Selenium\",
        \"lastName\": \"APITest\",
        \"gradeLevel\": \"3\",
        \"classId\": null,
        \"roles\": [
            \"Student\"
        ],
        \"userType\": \"Student\",
        \"userState\": \"CREATED\",
        \"userStatus\": null,
        \"description\": null,
        \"properties\": null,
        \"dateCreated\": 0
    }
}"

    puts "<b>Sent an Entity Data</b>"
    @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

    puts "<b>ASSERTIONS</b>"

    if ['K12PROD1','K12QA'].include? configatron.environment then
        @status.should == 400
        puts "&#10004;Status -- '400' was a number equal to 400"

        @responce.should include "Not all records were successfully processed. Received = 1 Successful = 0 Failed = 1. Error Reference Id ="
        puts "#{@responce}"

    else

    #Assertion for the Entity Sent
    @status.should == 202
    puts "&#10004;Status -- '202' was a number equal to 202"

    @responce['successful'].should  == 1
    puts "&#10004;body.successful -- '1' contained '1'"

    @responce['failed'].should  == 0
    puts "&#10004;body.failed -- '0' was equal to '0'"
   end
end


When(/^Sent Event Data to the raw stream$/) do

    @hostname = configatron.workbench
    @apitoken = configatron.apitoken

    #Sending a Single Event Json
    @posturl = File.join('https://',@hostname,'/v1custom/eventdata')

    @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SegmentEvent\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
        \"action\": \"SEGMENT_STARTED\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector15\",
            \"@type\": null,
            \"name\": null,
            \"dateModified\": 0,
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\"
        },
        \"object\": {
            \"@id\": \"3\",
            \"@type\": \"http://scholastic.com/common/v1/SegmentEntity\",
            \"name\": \"API SegmentName\",
            \"dateModified\": 0,
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\",
            \"stageId\": \"B\",
            \"classId\": null,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0
        },

        \"startedAtTime\": #{configatron.currnetTimeStamp},
        \"edApp\": {
            \"iType\": \"SoftwareApplication\",
            \"@id\": \"http://scholastic.com/apps/r180u/v1\",
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
            \"name\": null,
            \"dateModified\": 0,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0  } }}"

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
    
    @responce['successful'].should  == 1
    puts "&#10004;body.successful -- '1' contained '1'"

    @responce['failed'].should  == 0
    puts "&#10004;body.failed -- '0' was equal to '0'"
    end
end



When(/^Sent Event Data with Bad SensorId - expect fail$/) do

    @hostname = configatron.workbench
    @apitoken = configatron.apitoken

    #Sending a Single Event Json
    @posturl = File.join('https://',@hostname,'/v1custom/eventdata')

    @query = "{
    \"sensorId\": \"BAD_SENSOR_ID\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SegmentEvent\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
        \"action\": \"SEGMENT_STARTED\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector14\",
            \"@type\": null,
            \"name\": null,
            \"dateModified\": 0,
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\"
        },
        \"object\": {
            \"@id\": \"3\",
            \"@type\": \"http://scholastic.com/common/v1/SegmentEntity\",
            \"name\": \"API SegmentName\",
            \"dateModified\": 0,
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\",
            \"stageId\": \"B\",
            \"classId\": null,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0
        },

        \"startedAtTime\": #{configatron.currnetTimeStamp},
        \"edApp\": {
            \"iType\": \"SoftwareApplication\",
            \"@id\": \"http://scholastic.com/apps/r180u/v1\",
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
            \"name\": null,
            \"dateModified\": 0,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0  } }}"

    puts "<b>Sent an Event Data</b>"
    @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)


    puts "<b>ASSERTIONS</b>"
    #Assertion for the Event Sent
    @status.should == 400
    puts "&#10004;Status -- '400' was a number equal to 400"

   case configatron.collectorVersion

        when 'OLD'

            @responce['requestId'].should_not  == nil
            puts "&#10004;body.requestId -- was not null"

            @responce['successful'].should  == 0
            puts "&#10004;body.successful -- '0' contained '0'"

            @responce['failed'].should  == 1
            puts "&#10004;body.failed -- '1' was equal to '1'"

            @responce['error'].should  == "Invalid sensorId: BAD_SENSOR_ID"
            puts "&#10004;Invalid sensorId: BAD_SENSOR_ID' was equal to 'Invalid sensorId: BAD_SENSOR_ID"

        else
            @responce['error'].should  == "Invalid sensorIds: [BAD_SENSOR_ID]"
            puts "&#10004;Invalid sensorIds: [BAD_SENSOR_ID]' was equal to 'Invalid sensorIds: [BAD_SENSOR_ID]"
    end
end



When(/^Sent Event Data with Bad API Key$/) do


    @hostname = configatron.workbench
    @apitoken = configatron.apitoken

    #Sending a Single Event Json
    @posturl = File.join('https://',@hostname,'/v1custom/eventdata')

    @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"INVALID-API-KEY-FOR-EVENT\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SegmentEvent\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
        \"action\": \"SEGMENT_STARTED\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector13\",
            \"@type\": null,
            \"name\": null,
            \"dateModified\": 0,
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\"        },
        \"object\": {
            \"@id\": \"3\",
            \"@type\": \"http://scholastic.com/common/v1/SegmentEntity\",
            \"name\": \"API SegmentName\",
            \"dateModified\": 0,
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\",
            \"stageId\": \"B\",
            \"classId\": null,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0
        },
        \"startedAtTime\": #{configatron.currnetTimeStamp},
        \"edApp\": {
            \"iType\": \"SoftwareApplication\",
            \"@id\": \"http://scholastic.com/apps/r180u/v1\",
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
            \"name\": null,
            \"dateModified\": 0,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0
        }    }}"

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

    @status.should == 400
    puts "&#10004;Status -- '400' was a number equal to 400"

           case configatron.collectorVersion

                when 'OLD'

                    @responce['requestId'].should_not  == nil
                    puts "&#10004;body.requestId -- was not null"

                    @responce['successful'].should  == 0
                    puts "&#10004;body.successful -- '0' contained '0'"

                    @responce['failed'].should  == 1
                    puts "&#10004;body.failed -- '1' was equal to '1'"

                    @responce['error'].should  == "Invalid api key: INVALID-API-KEY-FOR-EVENT"
                    puts "&#10004;error was equal to 'Invalid api key: INVALID-API-KEY-FOR-EVENT"

                else
                    @responce['error'].should  == "Invalid api keys: [INVALID-API-KEY-FOR-EVENT]"
                    puts "&#10004;error was equal to 'Invalid api keys: [INVALID-API-KEY-FOR-EVENT]"
           end
      end
end



When(/^Sent Event with event.actor.dateModified type changed from long to String$/) do

    @hostname = configatron.workbench
    @apitoken = configatron.apitoken

    #Sending a Single Event Json
    @posturl = File.join('https://',@hostname,'/v1custom/eventdata')

    @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SegmentEvent\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
        \"action\": \"SEGMENT_STARTED\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector12\",
            \"@type\": null,
            \"name\": null,
            \"dateModified\": \"#{configatron.pastISODateTimeWithinFiveYears}\",
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\"
        },
        \"object\": {
            \"@id\": \"3\",
            \"@type\": \"http://scholastic.com/common/v1/SegmentEntity\",
            \"name\": \"API SegmentName\",
            \"dateModified\": 0,
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\",
            \"stageId\": \"B\",
            \"classId\": null,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0
        },
        \"startedAtTime\": #{configatron.currnetTimeStamp},
        \"eventTime\":null,
        \"edApp\": {
            \"iType\": \"SoftwareApplication\",
            \"@id\": \"http://scholastic.com/apps/r180u/v1\",
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
            \"name\": null,
            \"dateModified\": 0,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 0  } }}"

    puts "<b>Sent an Event Data</b>"
    @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)


    puts "<b>ASSERTIONS</b>"

    if ['K12PROD1','K12QA'].include? configatron.environment then
        @status.should == 400
        puts "&#10004;Status -- '400' was a number equal to 400"

        @responce.should include "Not all records were successfully processed. Received = 1 Successful = 0 Failed = 1. Error Reference Id ="
        puts "#{@responce}"

    else

    #Assertion for the Event Sent
    @status.should == 202
    puts "&#10004;Status -- '202' was a number equal to 202"
    
    @responce['successful'].should  == 1
    puts "&#10004;body.successful -- '1' contained '1'"

    @responce['failed'].should  == 0
    puts "&#10004;body.failed -- '0' was equal to '0'"
      end


end


When(/^Verify that the Sent Events in the Raw the stream$/) do

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
            \"sourceTimestamp\": #{configatron.currnetTimeStamp}
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
    puts "&#10004;body.hits.total -- '1' was equal to 1"

end

When(/^Verify that the Sent Entities in the Raw the stream$/) do

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
            \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0#{configatron.currnetTimeStamp}\"
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

    puts "<b>ASSERTIONS</b>"
    @status.should == 200
    puts "&#10004;Status -- 200 was a number equal to 200"

    @responce['hits']['total'].should == 1
    puts "&#10004;hits.total -- '1' was equal to 1"

end
