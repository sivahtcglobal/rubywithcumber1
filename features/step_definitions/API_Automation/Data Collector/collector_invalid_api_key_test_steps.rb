
Then(/^Send Single Entity data with Bad API Key$/) do
    @currnetTimeStamp = Time.new.to_i * 1000
    configatron.currnetTimeStamp = @currnetTimeStamp
    configatron.currnetTimeStamp0 =   @currnetTimeStamp

    @hostname = configatron.workbench
    @username= configatron.designerUsername
    @password= configatron.designerPassword
    @apitoken =  get_apitoken(@hostname,@username,@password)
    configatron.apitoken = @apitoken
                    
	@query = "{
    \"name\": null,
    \"apiKey\": \"INVALID_API_KEY_FOR_ENTITY\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja\",
        \"dateModified\": #{configatron.currnetTimeStamp},
        \"applicationId\": \"SLMS\",
        \"siteId\": \"h900000031\",
        \"jvmId\": \"sam-app013\",
        \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"firstName\": \"pri\",
        \"lastName\": \"vinja\",
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
	@posturl = File.join('https://',@hostname,'/v1custom/entitydata')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 400"

    case configatron.collectorVersion

      when 'OLD'

        @responce['requestId'].should_not  == nil
        puts "&#10004;body.requestId -- was not null"

        @responce['successful'].should  == 0
        puts "&#10004;body.successful -- '0' contained '0'"

        @responce['failed'].should  == 1
        puts "&#10004;body.failed -- '1' was equal to '1'"

        @responce['error'].should  == "Invalid api key: INVALID_API_KEY_FOR_ENTITY"
        puts "&#10004;error was equal to 'Invalid api key: INVALID_API_KEY_FOR_ENTITY"

      else
        @responce['error'].should  == "Invalid api keys: [INVALID_API_KEY_FOR_ENTITY]"
        puts "&#10004;error was equal to 'Invalid api keys: [INVALID_API_KEY_FOR_ENTITY]"

    end
end

Then(/^Verify that the Entity Raw stream Should not have data 404$/) do
  sleep(20)
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"sourceTimestamp\": #{configatron.currnetTimeStamp}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.entityIndex}-entitydata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
	
	puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['hits']['total'].should == 0
  puts "&#10004;hits.total -- '0' was equal to 0"
end

Then(/^Send an Single Event Data with Bad API Key$/) do

                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"INVALID_API_KEY_FOR_EVENT\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SegmentEvent\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
        \"action\": \"SEGMENT_STARTED\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
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
            \"dateCreated\": 0
        }
    }
}"
	@posturl = File.join('https://',@hostname,'/v1custom/eventdata')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 400"	
	
  case configatron.collectorVersion

    when 'OLD'

      @responce['requestId'].should_not  == nil
      puts "&#10004;body.requestId -- was not null"

      @responce['successful'].should  == 0
      puts "&#10004;body.successful -- '0' contained '0'"

      @responce['failed'].should  == 1
      puts "&#10004;body.failed -- '1' was equal to '1'"

      @responce['error'].should  == "Invalid api key: INVALID_API_KEY_FOR_EVENT"
      puts "&#10004;error was equal to 'Invalid api key: INVALID_API_KEY_FOR_EVENT"

    else
      @responce['error'].should  == "Invalid api keys: [INVALID_API_KEY_FOR_EVENT]"
      puts "&#10004;error was equal to 'Invalid api keys: [INVALID_API_KEY_FOR_EVENT]"

  end

end

Then(/^Verify that the Event Raw stream Should not have data 404$/) do
  sleep(20)
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"startedAtTime\": #{configatron.currnetTimeStamp}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['hits']['total'].should == 0
  puts "&#10004;hits.total -- '0' was equal to 0"
end

Then(/^Send an Single Entity data with Valid API Key$/) do

                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja\",
        \"dateModified\": #{configatron.currnetTimeStamp},
        \"applicationId\": \"SLMS\",
        \"siteId\": \"h900000031\",
        \"jvmId\": \"sam-app013\",
        \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"firstName\": \"pri\",
        \"lastName\": \"vinja\",
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
	@posturl = File.join('https://',@hostname,'/v1custom/entitydata')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 202
	puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['successful'].should  == 1
  puts "&#10004;body.successful -- '1' contained '1'"

  @responce['failed'].should  == 0
  puts "&#10004;body.failed -- '0' was equal to '0'"
end


Then(/^Verify that the Entity Raw stream Attribute data$/) do
sleep 15
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"sourceTimestamp\": #{configatron.currnetTimeStamp}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.entityIndex}-entitydata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"

	@responce['hits']['total'].should  == 1
puts "&#10004;body.hits.total -- '1' was equal to 1"
end

Then(/^Sent Single Event Data with Valid API Key$/) do

                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
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
            \"@id\": \"API_Collector1\",
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
            \"dateCreated\": 0
        }
    }
}"
	@posturl = File.join('https://',@hostname,'/v1custom/eventdata')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
	

	puts "<b>ASSERTIONS</b>"
	@status.should == 202
	puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['successful'].should  == 1
  puts "&#10004;body.successful -- '1' contained '1'"

  @responce['failed'].should  == 0
  puts "&#10004;body.failed -- '0' was equal to '0'"
end

Then(/^Verify that the Event Raw stream Attribute data$/) do
  sleep(20)
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"sourceTimestamp\": #{configatron.currnetTimeStamp}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['hits']['total'].should  == 1
  puts "&#10004;body.hits.total -- '1' was equal to 1"
end

Then(/^Send Multiple Entity data one of them with Bad API Key$/) do

  @currnetTimeStamp = Time.new.to_i * 1000
  configatron.currnetTimeStamp = @currnetTimeStamp

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

                    
	@query = "{
    \"entityData\": [
        {
            \"name\": null,
            \"apiKey\": \"INVALID_API_KEY_FOR_ENTITY\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
            \"type\": \"USER\",
            \"entity\": {
                \"iType\": \"ScholasticPerson\",
                \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"@type\": \"USER\",
                \"name\": \"pri vinja\",
                \"dateModified\": #{configatron.currnetTimeStamp},
                \"applicationId\": \"SLMS\",
                \"siteId\": \"h900000031\",
                \"jvmId\": \"sam-app013\",
                \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"firstName\": \"pri\",
                \"lastName\": \"vinja\",
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
        },
{
            \"name\": null,
            \"apiKey\": \"#{configatron.apiKey}\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
            \"type\": \"USER\",
            \"entity\": {
                \"iType\": \"ScholasticPerson\",
                \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"@type\": \"USER\",
                \"name\": \"pri vinja\",
                \"dateModified\": #{configatron.currnetTimeStamp},
                \"applicationId\": \"SLMS\",
                \"siteId\": \"h900000031\",
                \"jvmId\": \"sam-app013\",
                \"personId\": \"3taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"firstName\": \"Kan\",
                \"lastName\": \"biskt\",
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
        },
{
            \"name\": null,
            \"apiKey\": \"#{configatron.apiKey}\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
            \"type\": \"USER\",
            \"entity\": {
                \"iType\": \"ScholasticPerson\",
                \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"@type\": \"USER\",
                \"name\": \"pri vinja\",
                \"dateModified\": #{configatron.currnetTimeStamp},
                \"applicationId\": \"SLMS\",
                \"siteId\": \"h900000031\",
                \"jvmId\": \"sam-app013\",
                \"personId\": \"6taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"firstName\": \"Ope\",
                \"lastName\": \"Manga\",
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
        }
    ]
}"
	@posturl = File.join('https://',@hostname,'/v1custom/entitydata/batch')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 400"

  case configatron.collectorVersion

    when 'OLD'

      @responce['requestId'].should_not  == nil
      puts "&#10004;body.requestId -- was not null"

      @responce['successful'].should  == 0
      puts "&#10004;body.successful -- '0' contained '0'"

      @responce['failed'].should  == 3
      puts "&#10004;body.failed -- '3' was equal to '3'"

      @responce['error'].should  == "Invalid api key: INVALID_API_KEY_FOR_ENTITY"
      puts "&#10004;error was equal to 'Invalid api key: INVALID_API_KEY_FOR_ENTITY"

    else
      @responce['error'].should  == "Invalid api keys: [INVALID_API_KEY_FOR_ENTITY]"
      puts "&#10004;error was equal to 'Invalid api keys: [INVALID_API_KEY_FOR_ENTITY]"

  end
end

Then(/^Verify that the Multi Entity one with Bad API Key$/) do
  sleep(20)
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"sourceTimestamp\": #{configatron.currnetTimeStamp}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.entityIndex}-entitydata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['hits']['total'].should  == 0
  puts "&#10004;body.hits.total -- '0' was equal to 0"
end

Then(/^Sent Multiple Event Data one of them with Bad API Key$/) do
                    configatron.currnetTimeStamp = Time.new.to_i * 1000
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
    \"eventData\": [
        {
            \"sensorId\": \"#{configatron.sensorId}\",
            \"apiKey\": \"INVALID_API_KEY_FOR_EVENT\",
            \"event\": {
                \"iType\": \"LrsSegmentEvent\",
                \"@context\": \"http://scholastic.com/ctx/v1/SegmentEvent\",
                \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
                \"applicationId\": \"R180U\",
                \"siteId\": \"h900000031\",
                \"action\": \"SEGMENT_STARTED\",
                \"actor\": {
                    \"iType\": \"ScholasticPerson\",
                    \"@id\": \"API_Collector1\",
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
                    \"dateCreated\": 0
                }
            }
        },
        {
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
                    \"@id\": \"API_Collector1\",
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
                    \"dateCreated\": 0
                }
            }
        },
        {
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
                    \"@id\": \"API_Collector1\",
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
                    \"dateCreated\": 0
                }
            }
        }
    ]
}"
	@posturl = File.join('https://',@hostname,'/v1custom/eventdata/batch')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 400
	puts "&#10004;Status -- 400 was a number equal to 400"

  case configatron.collectorVersion

    when 'OLD'

      @responce['requestId'].should_not  == nil
      puts "&#10004;body.requestId -- was not null"

      @responce['successful'].should  == 0
      puts "&#10004;body.successful -- '0' contained '0'"

      @responce['failed'].should  == 3
      puts "&#10004;body.failed -- '3' was equal to '3'"

      @responce['error'].should  == "Invalid api key: INVALID-API-KEY-FOR-EVENT"
      puts "&#10004;error was equal to 'Invalid api key: INVALID-API-KEY-FOR-EVENT"

    else
      @responce['error'].should  == "Invalid api keys: [INVALID_API_KEY_FOR_EVENT]"
      puts "&#10004;error was equal to 'Invalid api keys: [INVALID_API_KEY_FOR_EVENT]"
  end
end

Then(/^Verify that the Mutli Event one with Bad API Key$/) do
  sleep(20)
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"startedAtTime\": #{configatron.currnetTimeStamp}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

	@responce['hits']['total'].should  == 0
  puts "&#10004;body.hits.total -- '1' was equal to 1"
end

Then(/^Send Multiple Entity data all with valid API Key$/) do

                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
    \"entityData\": [
        {
            \"name\": null,
            \"apiKey\": \"#{configatron.apiKey}\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
            \"type\": \"USER\",
            \"entity\": {
                \"iType\": \"ScholasticPerson\",
                \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"@type\": \"USER\",
                \"name\": \"pri vinja\",
                \"dateModified\": #{configatron.currnetTimeStamp},
                \"applicationId\": \"SLMS\",
                \"siteId\": \"h900000031\",
                \"jvmId\": \"sam-app013\",
                \"personId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"firstName\": \"pri\",
                \"lastName\": \"vinja\",
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
        },
{
            \"name\": null,
            \"apiKey\": \"#{configatron.apiKey}\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
            \"type\": \"USER\",
            \"entity\": {
                \"iType\": \"ScholasticPerson\",
                \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"@type\": \"USER\",
                \"name\": \"pri vinja\",
                \"dateModified\": #{configatron.currnetTimeStamp},
                \"applicationId\": \"SLMS\",
                \"siteId\": \"h900000031\",
                \"jvmId\": \"sam-app013\",
                \"personId\": \"3taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"firstName\": \"Kan\",
                \"lastName\": \"biskt\",
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
        },
{
            \"name\": null,
            \"apiKey\": \"#{configatron.apiKey}\",
            \"sensorId\": \"#{configatron.sensorId}\",
            \"entityId\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
            \"type\": \"USER\",
            \"entity\": {
                \"iType\": \"ScholasticPerson\",
                \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"@type\": \"USER\",
                \"name\": \"pri vinja\",
                \"dateModified\": #{configatron.currnetTimeStamp},
                \"applicationId\": \"SLMS\",
                \"siteId\": \"h900000031\",
                \"jvmId\": \"sam-app013\",
                \"personId\": \"6taqom5tttrigss8a6ls8eb9_v8q9qq0\",
                \"firstName\": \"Ope\",
                \"lastName\": \"Manga\",
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
        }
    ]
}"
	@posturl = File.join('https://',@hostname,'/v1custom/entitydata/batch')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 202
	puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 3
  puts "&#10004;body.successful -- '3' contained '3'"

  @responce['failed'].should  == 0
  puts "&#10004;body.failed -- '0' was equal to '0'"
end

Then(/^Verify that the Multi Entity all with valid API Key$/) do
  sleep(20)
                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"sourceTimestamp\": #{configatron.currnetTimeStamp}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.entityIndex}-entitydata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"

	@responce['hits']['total'].should  == 3
  puts "&#10004;body.hits.total -- '3' was equal to 3"
end

Then(/^Sent Multiple Event Data all with valid API Key$/) do

                    @hostname = configatron.workbench
                    @apitoken =  configatron.apitoken
                    
	@query = "{
    \"eventData\": [
        {
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
                    \"@id\": \"API_Collector1\",
                    \"@type\": null,
                    \"name\": \"actor1\",
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
                \"startedAtTime\": #{configatron.currnetTimeStamp0},
                \"edApp\": {
                    \"iType\": \"SoftwareApplication\",
                    \"@id\": \"http://scholastic.com/apps/r180u/v1\",
                    \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
                    \"name\": null,
                    \"dateModified\": 0,
                    \"description\": null,
                    \"properties\": null,
                    \"dateCreated\": 0
                }
            }
        },
        {
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
                    \"@id\": \"API_Collector1\",
                    \"@type\": null,
                    \"name\": \"actor2\",
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
                \"startedAtTime\": #{configatron.currnetTimeStamp0},
                \"edApp\": {
                    \"iType\": \"SoftwareApplication\",
                    \"@id\": \"http://scholastic.com/apps/r180u/v1\",
                    \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
                    \"name\": null,
                    \"dateModified\": 0,
                    \"description\": null,
                    \"properties\": null,
                    \"dateCreated\": 0
                }
            }
        },
        {
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
                    \"@id\": \"API_Collector1\",
                    \"@type\": null,
                    \"name\": \"actor3\",
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
                \"startedAtTime\": #{configatron.currnetTimeStamp0},
                \"edApp\": {
                    \"iType\": \"SoftwareApplication\",
                    \"@id\": \"http://scholastic.com/apps/r180u/v1\",
                    \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
                    \"name\": null,
                    \"dateModified\": 0,
                    \"description\": null,
                    \"properties\": null,
                    \"dateCreated\": 0
                }
            }
        }
    ]
}"
	@posturl = File.join('https://',@hostname,'/v1custom/eventdata/batch')
	@status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 202
	puts "&#10004;Status -- 200 was a number equal to 200"

	@responce['successful'].should  == 3
  puts "&#10004;body.successful -- '3' contained '3'"

  @responce['failed'].should  == 0
  puts "&#10004;body.failed -- '0' was equal to '0'"
end

Then(/^Verify that the Mutli Event all with valid API Key$/) do
  sleep(20)
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
                    
	@query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
             \"event.startedAtTime\": #{configatron.currnetTimeStamp0}
            }
          }]
        }
      }
    }
  }
}"
	@posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}/_search")
	@status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

	puts "<b>ASSERTIONS</b>"
	@status.should == 200
	puts "&#10004;Status -- 200 was a number equal to 200"

	@responce['hits']['total'].should  == 4
  puts "&#10004;body.hits.total -- '4' was equal to 4"
end