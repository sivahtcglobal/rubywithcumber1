
Then(/^Send Bulk Event data array of 5 events to the raw stream$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  configatron.currnetTimeStamp = @currnetTimeStamp
  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken

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
                    \"name\": null,
                    \"dateModified\": 0,
                    \"applicationId\": null,
                    \"siteId\": \"h900000031\",
                    \"jvmId\": \"r180u-app01\"
                },
                \"object\": {
                    \"@id\": \"1\",
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
                    \"@id\": \"API_Collector2\",
                    \"@type\": null,
                    \"name\": null,
                    \"dateModified\": 0,
                    \"applicationId\": null,
                    \"siteId\": \"h900000031\",
                    \"jvmId\": \"r180u-app01\"
                },
                \"object\": {
                    \"@id\": \"2\",
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
                    \"@id\": \"API_Collector3\",
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
                    \"@id\": \"API_Collector3\",
                    \"@type\": null,
                    \"name\": null,
                    \"dateModified\": 0,
                    \"applicationId\": null,
                    \"siteId\": \"h900000031\",
                    \"jvmId\": \"r180u-app01\"
                },
                \"object\": {
                    \"@id\": \"4\",
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
                    \"@id\": \"API_Collector3\",
                    \"@type\": null,
                    \"name\": null,
                    \"dateModified\": 0,
                    \"applicationId\": null,
                    \"siteId\": \"h900000031\",
                    \"jvmId\": \"r180u-app01\"
                },
                \"object\": {
                    \"@id\": \"5\",
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
  @status.should == 202
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 5
  puts "&#10004;successful was equal to 5"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end


Then(/^Verify that the Bulk Event Raw stream Attribute data$/) do
  sleep 20
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

  @responce['hits']['total'].should  == 5
  puts "&#10004;hits.total was a number equal to 5"

end

Then(/^Send Bulk Event data array of 3 events  to the raw stream$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "{\"eventData\" : [{
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
      \"@id\": \"6\",
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
}, {
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
      \"@id\": \"API_Collector2\",
      \"@type\": null,
      \"name\": null,
      \"dateModified\": 0,
      \"applicationId\": null,
      \"siteId\": \"h900000031\",
      \"jvmId\": \"r180u-app01\"
    },
    \"object\": {
      \"@id\": \"7\",
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
}, {
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
      \"@id\": \"API_Collector3\",
      \"@type\": null,
      \"name\": null,
      \"dateModified\": 0,
      \"applicationId\": null,
      \"siteId\": \"h900000031\",
      \"jvmId\": \"r180u-app01\"
    },
    \"object\": {
      \"@id\": \"8\",
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
}]
}"
  @posturl = File.join('https://',@hostname,'/v1custom/eventdata/batch')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 202
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 3
  puts "&#10004;successful was equal to 3"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"

end


Then(/^Verify again that the Bulk Event Raw stream Attribute data$/) do
  sleep 20
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

  @responce['hits']['total'].should  == 8
  puts "&#10004;hits.total was a number equal to 8"
end

Then(/^Send Bulk Event data array of 2 events with bad sensorID in all events - expect fail$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "{\"eventData\" : [{
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
    \"eventTime\": #{configatron.currnetTimeStamp},
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
}, {
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
      \"@id\": \"API_Collector2\",
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
    \"eventTime\": #{configatron.currnetTimeStamp},
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
}]
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

      @responce['failed'].should  == 2
      puts "&#10004;body.failed -- '2' was equal to '2'"

      @responce['error'].should  == "Invalid sensorId: BAD_SENSOR_ID"
      puts "&#10004;error was equal to 'Invalid sensorId: BAD_SENSOR_ID"

    else
      @responce['error'].should  == "Invalid sensorIds: [BAD_SENSOR_ID]"
      puts "&#10004;error was equal to 'Invalid sensorIds: [BAD_SENSOR_ID]"
  end

end

Then(/^Send Bulk Event data array of 2 events with bad sensorID in one out of two events - expect fail$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "{\"eventData\" : [{
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
}, {
  \"sensorId\": \"#{configatron.sensorId}\" ,
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
      \"@id\": \"API_Collector2\",
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
}]
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

      @responce['failed'].should  == 2
      puts "&#10004;body.failed -- '2' was equal to '2'"

      @responce['error'].should  == "Invalid sensorId: BAD_SENSOR_ID"
      puts "&#10004;error was equal to 'Invalid sensorId: BAD_SENSOR_ID"

    else
      @responce['error'].should  == "Invalid sensorIds: [BAD_SENSOR_ID]"
      puts "&#10004;error was equal to 'Invalid sensorIds: [BAD_SENSOR_ID]"
  end
end

Then(/^Send raw Bulk Event array instead of object with array in it$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "[{
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
    \"startedAtTime\": \"#{configatron.currnetTimeStamp}\",
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
}, {
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
      \"@id\": \"API_Collector2\",
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
    \"startedAtTime\": \"#{configatron.currnetTimeStamp}\",
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
}]"
  @posturl = File.join('https://',@hostname,'/v1custom/eventdata/batch')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 400 was a number equal to 400"

  @responce['error'].should  == "The array field eventData is required"
  puts "&#10004;error was equal to 'The array field eventData is required'"
end

Then(/^Again Send Bulk Entity data array of 6 entities to the raw stream$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "{\"entityData\" : [
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Tina Mnm\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 1\",
            \"familyName\": \"Lastname 1\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 7,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 79,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 75,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 4,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Sahili Mokme\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 2\",
            \"familyName\": \"Lastname 2\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 8,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 5,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Manota Leslia\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 3\",
            \"familyName\": \"Lastname 3\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 9,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 87,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 89,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 5,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 6,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Sompeth Patan\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 4\",
            \"familyName\": \"Lastname 4\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 0,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 4,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 7,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Kansika Litova\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 5\",
            \"familyName\": \"Lastname 5\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 6,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 79,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 75,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 3,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 6,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Hurpon Tonic\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 6\",
            \"familyName\": \"Lastname 6\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 5,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 7,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 8,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    }
]
}"
  @posturl = File.join('https://',@hostname,'/v1custom/entitydata/batch')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 202
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 6
  puts "&#10004;successful was equal to 6"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end


Then(/^Verify that the Bulk Entity Raw stream Attribute data$/) do
  sleep 20
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
}
"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.entityIndex}-entitydata-#{configatron.datasourceUUID}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['hits']['total'].should  == 6
  puts "&#10004;['hits']['total'] was equal to '6'"

  @responce['hits']['hits'][0]['_source']['entity']['iType'].should  == "ReportEntity"
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['iType'] was equal to 'ReportEntity'"

  @responce['hits']['hits'][0]['_source']['entity']['name'].should_not  == nil
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['name'] was not null"

  @responce['hits']['hits'][0]['_source']['entity']['applicationId'].should  == "S44"
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['applicationId'] was equal to 'S44'"

  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == nil
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['siteId'] was null"

  @responce['hits']['hits'][0]['_source']['entity']['jvmId'].should  == ""
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['jvmId'] was empty"

  @responce['hits']['hits'][0].should_not  == nil
  puts "&#10004;[['hits']['hits'][0] was not null"

  @responce['hits']['hits'][1].should_not  == nil
  puts "&#10004;['hits']['hits'][1]  was not null"


end

Then(/^Send Bulk Entity data array of 6 entities to the raw stream$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "{\"entityData\" : [
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Tina Mnm123\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 1\",
            \"familyName\": \"Lastname 1\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 7,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 79,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 75,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 4,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Sahili Mokme123\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 2\",
            \"familyName\": \"Lastname 2\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 8,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 5,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Manota Leslia123\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 3\",
            \"familyName\": \"Lastname 3\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 9,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 87,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 89,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 5,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 6,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Sompeth Patan123\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 4\",
            \"familyName\": \"Lastname 4\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 0,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 4,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 7,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Kansika Litova123\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 5\",
            \"familyName\": \"Lastname 5\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 6,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 79,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 75,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 3,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 6,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Hurpon Tonic123\",
            \"dateModified\": #{configatron.currnetTimeStamp},
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 6\",
            \"familyName\": \"Lastname 6\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 5,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 7,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 8,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": #{configatron.currnetTimeStamp}
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    }
]
}"
  @posturl = File.join('https://',@hostname,'/v1custom/entitydata/batch')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 202
  puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['successful'].should  == 6
  puts "&#10004;successful was equal to 6"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end


Then(/^Again Verify that the Bulk Entity Raw stream Attribute data$/) do
  sleep 20
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
}
"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.entityIndex}-entitydata-#{configatron.datasourceUUID}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['hits']['total'].should  == 12
  puts "&#10004;['hits']['total'] was equal to '12'"

  @responce['hits']['hits'][0]['_source']['entity']['iType'].should  == "ReportEntity"
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['iType'] was equal to 'ReportEntity'"

  @responce['hits']['hits'][0]['_source']['entity']['name'].should_not  == nil
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['name'] was not null"

  @responce['hits']['hits'][0]['_source']['entity']['applicationId'].should  == "S44"
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['applicationId'] was equal to 'S44'"

  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  ==  nil
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['siteId'] was null"

  @responce['hits']['hits'][0]['_source']['entity']['jvmId'].should  == ""
  puts "&#10004;['hits']['hits'][0]['_source']['entity']['jvmId'] was empty"

  @responce['hits']['hits'][0].should_not  == nil
  puts "&#10004;['hits']['hits'][0] was not null"

  @responce['hits']['hits'][1].should_not  == nil
  puts "&#10004;['hits']['hits'][1] as not null"

end

Then(/^Send Bulk Entity data array of 2 entities with bad sensorID in all entities - expect fail$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "{\"entityData\" : [
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Tina Mnm\",
            \"dateModified\": 1441310287000,
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 1\",
            \"familyName\": \"Lastname 1\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 7,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 79,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 75,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 4,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 1441137487000
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"BAD_SENSOR_ID\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Sahili Mokme\",
            \"dateModified\": 1441310287100,
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 2\",
            \"familyName\": \"Lastname 2\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 8,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 5,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 1441137487100
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"BAD_SENSOR_ID\"
    }
]
}"
  @posturl = File.join('https://',@hostname,'/v1custom/entitydata/batch')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 200 was a number equal to 400"

  case configatron.collectorVersion

    when 'OLD'

      @responce['requestId'].should_not  == nil
      puts "&#10004;body.requestId -- was not null"

      @responce['successful'].should  == 0
      puts "&#10004;body.successful -- '0' contained '0'"

      @responce['failed'].should  == 2
      puts "&#10004;body.failed -- '2' was equal to '2'"

      @responce['error'].should  == "Invalid sensorId: BAD_SENSOR_ID"
      puts "&#10004;Invalid sensorId: BAD_SENSOR_ID' was equal to 'Invalid sensorId: BAD_SENSOR_ID"

    else
      @responce['error'].should  == "Invalid sensorIds: [BAD_SENSOR_ID]"
      puts "&#10004;Invalid sensorIds: [BAD_SENSOR_ID]' was equal to 'Invalid sensorIds: [BAD_SENSOR_ID]"
  end
end

Then(/^Send Bulk Entity data array of 2 entities with bad sensorID in one out of two entities - expect fail$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken

  @query = "{\"entityData\" : [
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Tina Mnm\",
            \"dateModified\": 1441310287000,
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 1\",
            \"familyName\": \"Lastname 1\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 7,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 79,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 75,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 4,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 1441137487000
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"BAD_SENSOR_ID\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Sahili Mokme\",
            \"dateModified\": 1441310287100,
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 2\",
            \"familyName\": \"Lastname 2\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 8,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 5,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 1441137487100
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    }
]
}"
  @posturl = File.join('https://',@hostname,'/v1custom/entitydata/batch')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 200 was a number equal to 400"

  case configatron.collectorVersion

    when 'OLD'

      @responce['requestId'].should_not  == nil
      puts "&#10004;body.requestId -- was not null"

      @responce['successful'].should  == 0
      puts "&#10004;body.successful -- '0' contained '0'"

      @responce['failed'].should  == 2
      puts "&#10004;body.failed -- '2' was equal to '2'"

      @responce['error'].should  == "Invalid sensorId: BAD_SENSOR_ID"
      puts "&#10004;Invalid sensorId: BAD_SENSOR_ID' was equal to 'Invalid sensorId: BAD_SENSOR_ID"

    else
      @responce['error'].should  == "Invalid sensorIds: [BAD_SENSOR_ID]"
      puts "&#10004;Invalid sensorIds: [BAD_SENSOR_ID]' was equal to 'Invalid sensorIds: [BAD_SENSOR_ID]"
  end
end

Then(/^Send raw Bulk Entity array instead of object with array in it$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  @query = "[
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"3c15acf8-3cfd-473a-b491-1c712fe7b11eAjay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Tina Mnm\",
            \"dateModified\": 1441310287000,
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"givenName\": \"Student 1\",
            \"familyName\": \"Lastname 1\",
            \"currentTopic\": \"1.6\",
            \"topicName\": \"1.6\",
            \"sequenceCompletedPercent\": 3,
            \"topicsCompleted\": 7,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 35,
            \"usageTotalTime\": 194,
            \"cumulativePerformanceWordsRead\": 169,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 79,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 75,
            \"cumulativePerformanceSpellingScorePercent\": 100,
            \"cumulativePerformanceComprehensionScorePercent\": 100,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 4,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 1441137487000
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"#{configatron.sensorId}\"
    },
    {
        \"entity\": {
            \"iType\": \"ReportEntity\",
            \"@id\": \"1107174d-d8d3-4c67-9946-d9520b0acfc1Ajay\",
            \"@type\": \"ScholasticPerson\",
            \"name\": \"Sahili Mokme\",
            \"dateModified\": 1441310287100,
            \"applicationId\": \"S44\",
            \"siteId\": null,
            \"jvmId\": \"\",
            \"grade\": \"6,7,8\",
            \"givenName\": \"Student 2\",
            \"familyName\": \"Lastname 2\",
            \"currentTopic\": \"1.1\",
            \"topicName\": \"1.1\",
            \"sequenceCompletedPercent\": 0,
            \"topicsCompleted\": 8,
            \"medianSessionTimeMinutesPerformanceIssue\": false,
            \"medianSessionTimeMinutes\": 11,
            \"usageTotalTime\": 7,
            \"cumulativePerformanceWordsRead\": 0,
            \"cumulativePerformanceDecodingAccuracyScorePercent\": 0,
            \"cumulativePerformanceDecodingFluencyScorePercent\": 0,
            \"cumulativePerformanceSpellingScorePercent\": 0,
            \"cumulativePerformanceComprehensionScorePercent\": 0,
            \"cumulativePerformanceOralReadyFluency\": 0,
            \"totalTopicsNumber\": 160,
            \"maxReadingFluencyScore\": 5,
            \"className\": \"LRS Team\",
            \"schoolName\": \"LRS\",
            \"group\": \"vdsh330sa8vb30posh6pnq2k_v8q9qq0\",
            \"periodStart\": 1438401600000,
            \"periodEnd\": 1470024000000,
            \"description\": null,
            \"properties\": null,
            \"dateCreated\": 1441137487100
        },
        \"apiKey\": \"#{configatron.apiKey}\",
        \"sensorId\": \"BAD_SENSOR_ID\"
    }
]"
  @posturl = File.join('https://',@hostname,'/v1custom/entitydata/batch')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 400
  puts "&#10004;Status -- 400 was a number equal to 400"

  @responce['error'].should  == "The array field entityData is required"
  puts "&#10004; error was equal to 'The array field entityData is required'"
end

