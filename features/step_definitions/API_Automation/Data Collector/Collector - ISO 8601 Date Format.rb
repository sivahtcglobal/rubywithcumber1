
Then(/^Sent Entity with entity\.dateModified mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Future ISO Date Time\)$/) do

  configatron.currnetTimeStamp = Time.new.to_i * 1000
  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken

  #Generate Past ISO Date Within 5 Years
  currentDate = Time.new
  currentYear = Date.today.year
  currentDate_string = currentDate.to_s
  removeMS = currentDate_string.split('+')
  removeMS[0].strip!
  dateString = removeMS[0]+'.'+removeMS[1]
  addT = dateString.tr(" ","T") + "Z"

  yearWithin5Years = currentYear - 1
  yearBefore5Years = currentYear - 16
  yearAfter3Years = currentYear + 3

  configatron.pastISODateTimeBeforeFiveYears= addT.tr(currentYear.to_s,yearBefore5Years.to_s)
  configatron.pastISODateTimeWithinFiveYears= addT.tr(currentYear.to_s,yearWithin5Years.to_s)
  configatron.futureISODateTime = addT.tr(currentYear.to_s,yearAfter3Years.to_s)

  @query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja1#{configatron.currnetTimeStamp}\",
        \"dateModified\":  \"#{configatron.futureISODateTime}\",
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

  @responce['error'].should  include"Provided event or entity timestamp is invalid"
  puts "&#10004; error was equal to 'Provided event or entity timestamp is invalid'"
end

Then(/^Sent Entity with entity\.dateModified mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Past ISO Date Time Within Five Years\)$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja2#{configatron.currnetTimeStamp}\",
        \"dateModified\":  \"#{configatron.pastISODateTimeWithinFiveYears}\",
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
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"

end

Then(/^Sent Entity with entity.lastModified mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Past ISO Date Time Within Five Years\)$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja3#{configatron.currnetTimeStamp}\",
        \"lastModified\":  \"#{configatron.pastISODateTimeWithinFiveYears}\",
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Entity with entity\.dateModified mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Past ISO Date Time Before Five Years\)$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja4#{configatron.currnetTimeStamp}\",
        \"dateModified\":  \"#{configatron.pastISODateTimeBeforeFiveYears}\",
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

  @responce['error'].should  include"Provided event or entity timestamp is invalid"
  puts "&#10004; error was equal to 'Provided event or entity timestamp is invalid'"

end

Then(/^Sent Entity with entity\.dateModified mentioned as null$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja5#{configatron.currnetTimeStamp}\",
        \"dateModified\":  null,
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Entity with entity\.dateModified field missing$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"name\": null,
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja6#{configatron.currnetTimeStamp}\",
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Entity with entity\.dateModified mentioned as epoch time$/) do

  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{

    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
    \"type\": \"USER\",
    \"entity\": {
        \"iType\": \"ScholasticPerson\",
        \"@id\": \"4taqom5tttrigss8a6ls8eb9_v8q9qq0\",
        \"@type\": \"USER\",
        \"name\": \"pri vinja7#{configatron.currnetTimeStamp}\",
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Event with event.startedAtTime mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Future ISO Date Time\)$/) do

  
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
\"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\",
        \"siteId\": \"h900000031\",
        \"action\":   \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
            \"@type\": null,
            \"name\": \"test1#{configatron.currnetTimeStamp}\",
            \"dateModified\": #{configatron.currnetTimeStamp},
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
        \"startedAtTime\": \"#{configatron.futureISODateTime}\",
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

  @responce['error'].should  include"Provided event or entity timestamp is invalid"
  puts "&#10004; error was equal to 'Provided event or entity timestamp is invalid'"
end

Then(/^Sent Event with event.startedAtTime mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Past ISO Date Time Within Five Years\)$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"smokeTest\",
        \"@context\": \"http://smokeTest.com/ctx/v1/SATWithinfiveYears\",
         \"@type\": \"http://smokeTest.com/common/v1/smokeTest\",
        \"applicationId\": \"#{configatron.currnetTimeStamp}\",
        \"siteId\": \"h900000031\",
             \"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\",
        \"action\": \"SEGMENT_STARTED\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
            \"@type\": null,
            \"name\": \"test2#{configatron.currnetTimeStamp}\",
           \"dateModified\": \"11-August-2014\",
            \"applicationId\": null,
            \"siteId\": \"h900000031\",
            \"jvmId\": \"r180u-app01\"
        },
        \"object\": {
            \"@id\": \"3\",
            \"@type\": \"http://smokeTest.com/common/v1/smokeTest\",
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
        \"startedAtTime\": \"#{configatron.pastISODateTimeWithinFiveYears}\",
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Event with event.eventTime mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Past ISO Date Time Within Five Years\)$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/ETWithinfiveYears\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
        \"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\",

         \"action\":   \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
            \"@type\": null,
            \"name\": \"test3#{configatron.currnetTimeStamp}\",
            \"dateModified\": #{configatron.currnetTimeStamp},
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
        \"eventTime\": \"#{configatron.pastISODateTimeWithinFiveYears}\",
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Event with event.startedAtTime mentioned as YYYY\-MM\-DDThh:mm:ss\.SSSZ \(Past ISO Date Time Before Five Years\)$/) do

  
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
\"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\",
         \"action\":   \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
            \"@type\": null,
            \"name\": \"test4#{configatron.currnetTimeStamp}\",
            \"dateModified\": #{configatron.currnetTimeStamp},
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
        \"startedAtTime\": \"#{configatron.pastISODateTimeBeforeFiveYears}\",
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

  @responce['error'].should  include"Provided event or entity timestamp is invalid"
  puts "&#10004; error was equal to 'Provided event or entity timestamp is invalid'"
end

Then(/^Sent Event with event.startedAtTime mentioned as null$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SATNull\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
\"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\",
         \"action\":   \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
            \"@type\": null,
            \"name\": \"test5#{configatron.currnetTimeStamp}\",
            \"dateModified\": #{configatron.currnetTimeStamp},
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
        \"startedAtTime\": null,
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Event with event.startedAtTime field missing$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SATMissing\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
\"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\",
         \"action\":   \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
            \"@type\": null,
            \"name\": \"test6#{configatron.currnetTimeStamp}\",
            \"dateModified\": #{configatron.currnetTimeStamp},
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end

Then(/^Sent Event with event.startedAtTime mentioned as epoch time$/) do

  
  @hostname = configatron.workbench
  @apitoken =  configatron.apitoken
  
  @query = "{
    \"sensorId\": \"#{configatron.sensorId}\",
    \"apiKey\": \"#{configatron.apiKey}\",
    \"event\": {
        \"iType\": \"LrsSegmentEvent\",
        \"@context\": \"http://scholastic.com/ctx/v1/SATEpoc\",
        \"@type\": \"http://scholastic.com/common/v1/SegmentEvent\",
        \"applicationId\": \"R180U\",
        \"siteId\": \"h900000031\",
\"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\",
         \"action\":   \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\",
        \"actor\": {
            \"iType\": \"ScholasticPerson\",
            \"@id\": \"API_Collector1\",
            \"@type\": null,
            \"name\": \"test7#{configatron.currnetTimeStamp}\",
            \"dateModified\": \"11-August-2014\",
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
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;successful was equal to 1"

  @responce['failed'].should  == 0
  puts "&#10004;failed was equal to 0"
end


Then(/^Verify that all the Event Raw stream Attribute data$/) do

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
             \"eventId\": \"iso8601Test#{configatron.currnetTimeStamp}\"
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

  @responce['hits']['total'].should == 3
  puts "&#10004;hits.total -- '3' was equal to 3"

  @responce['hits']['hits'][0]['_source']['eventTimeISO'].should_not  == nil
  puts "&#10004;['hits']['hits'][0]['_source']['eventTimeISO'] -- was not null"

end


Then(/^Verify that the Entity Raw stream Attribute data $/) do

  sleep(20)
  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  configatron.apitoken
  
  @query = "{
  \"query\": {
    \"filtered\": {
      \"filter\": {
        \"bool\": {
          \"must\": [{
            \"term\": {
                 \"entityId\": \"4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}\"
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

  @responce['hits']['total'].should  == 4
  puts "&#10004;hits.total -- '4' was equal to 4"

  @responce['hits']['hits'][0]['_source']['entityId'].should  == "4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}"
  puts "&#10004;['hits']['hits'][0]['_source']['entityId']  was equal to '4taqom5tttrigss8a6ls8eb9_#{configatron.currnetTimeStamp}'"

  @responce['hits']['hits'][0]['_source']['entity']['iType'].should  == "ScholasticPerson"
  puts "&#10004;hits.total was equal to ScholasticPerson"

  @responce['hits']['hits'][0]['_source']['entity']['name'].should  == "pri vinja"
  puts "&#10004;hits.total was equal to 'pri vinja'"

  @responce['hits']['hits'][0]['_source']['entity']['applicationId'].should  == "SLMS"
  puts "&#10004;hits.total was equal to 'SLMS'"

  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h900000031"
  puts "&#10004;hits.total was equal to 'h900000031'"

  @responce['hits']['hits'][0]['_source']['entity']['jvmId'].should  == "sam-app013"
  puts "&#10004;hits.total was equal to 'sam-app013'"

  @responce['hits']['hits'][0]['_source']['entity']['personId'].should  == "4taqom5tttrigss8a6ls8eb9_v8q9qq0"
  puts "&#10004;hits.total was equal to '4taqom5tttrigss8a6ls8eb9_v8q9qq0'"

  @responce['hits']['hits'][0]['_source']['entity']['gradeLevel'].should  == "3"
  puts "&#10004;hits.total was equal to 3"

  @responce['hits']['hits'][0]['_source']['entity']['roles[0]'].should  == "Student"
  puts "&#10004;hits.total was equal to 'Student'"

  @responce['hits']['hits'][0]['_source']['entity']['userType'].should  == "Student"
  puts "&#10004;hits.total was equal to 'Student'"

  @responce['hits']['hits'][0]['_source']['entity']['userState'].should  == "CREATED"
  puts "&#10004;hits.total was equal to 'CREATED'"

  @responce['hits']['hits'][0]['_source']['dateModifiedISO'].should  == nil
  puts "&#10004;hits.total was equal to null"
end
