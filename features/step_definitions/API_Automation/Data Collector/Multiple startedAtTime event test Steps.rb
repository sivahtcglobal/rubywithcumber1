
Then(/^Sent Event Data With Multiple startedAtTime to the raw stream$/) do
  @currnetTimeStamp = Time.new.to_i * 1000

  configatron.currnetTimeStamp = @currnetTimeStamp
  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken

  @query = "{
    \"apiKey\": \"#{configatron.apiKey}\",
    \"sensorId\": \"#{configatron.sensorId}\",
    \"event\": {
        \"iType\": \"IntellifyAssessmentItemEvent\",
        \"@context\": \"http://purl.imsglobal.org/ctx/caliper/v1/AssessmentItemEvent\",
        \"@type\": \"http://scholastic.com/common/v1/IntellifyAssessmentItemEvent\",
        \"actor\": {
            \"iType\": \"Person\",
            \"@id\": \"3ftq2q2phqtd4fs3prdca844_1uamve0RS\",
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/lis/Person\",
            \"name\": null,
            \"dateModified\": 0,
            \"firstName\": \"Runscope\",
            \"lastName\": \"Test\",
            \"email\": null,
            \"roles\": null,
            \"description\": null,
            \"properties\": null,
            \"extensions\": null,
            \"dateCreated\": 0
        },
        \"action\": \"assessment.item.completed\",
        \"object\": {
            \"@id\": null,
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/Attempt\",
            \"name\": null,
            \"dateCreated\":  #{configatron.currnetTimeStamp},
            \"dateModified\": 0,
            \"count\": 1,
            \"startedAtTime\": #{configatron.currnetTimeStamp},
            \"endedAtTime\": 0,
            \"duration\": null,
            \"description\": null,
            \"properties\": null,
            \"extensions\": null,
            \"actorId\": null,
            \"assignableId\": null
        },
        \"target\": null,
        \"generated\": {
            \"iType\": \"attempt\",
            \"@id\": null,
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/Attempt\",
            \"name\": null,
            \"dateCreated\":  #{configatron.currnetTimeStamp},
            \"dateModified\": 0,
            \"count\": 1,
            \"startedAtTime\":  #{configatron.currnetTimeStamp},
            \"endedAtTime\": 0,
            \"duration\": null,
            \"description\": null,
            \"properties\": null,
            \"extensions\": null,
            \"actorId\": null,
            \"assignableId\": null
        },
        \"startedAtTime\": #{configatron.currnetTimeStamp},
        \"endedAtTime\": 0,
        \"duration\": null,
        \"edApp\": {
            \"iType\": \"SoftwareApplication\",
            \"@id\": \"http://scholastic.com/apps/sri/v1\",
            \"@type\": \"http://purl.imsglobal.org/caliper/v1/SoftwareApplication\",
            \"name\": null,
            \"dateModified\": 0,
            \"description\": null,
            \"properties\": null,
            \"extensions\": null,
            \"dateCreated\": 1499171040442
        },
        \"group\": null,
        \"contentId\": null,
        \"isPractice\": false,
        \"skipped\": null,
        \"sequence\": 1,
        \"score\": 0,
        \"siteId\": \"h503100011\",
        \"eventTime\": null
    }
}"
  @posturl = File.join('https://',@hostname,'/v1custom/eventdata')
  @status,@responce, @header = put_request_api(@posturl,@query,@apitoken)
  

  puts "<b>ASSERTIONS</b>"
  @status.should == 202
  puts "&#10004;Status -- 202 was a number equal to 202"

  @responce['successful'].should  == 1
  puts "&#10004;body.successful -- '1' contained '1'"

  @responce['failed'].should  == 0
  puts "&#10004;body.failed -- '0' was equal to '0'"
end

Then(/^Verify that the Event with multiple startedAtTime in Raw Index$/) do
 sleep(20)
  @hostname = configatron.workbench
 @apitoken = configatron.apitoken
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
 puts configatron.eventIndex
 @sufix = "/intellisearch/#{configatron.eventIndex}-eventdata-#{configatron.datasourceUUID}/_search"
  @posturl = File.join('https://',@hostname,@sufix)
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"

  @responce['hits']['total'].should  == 1
  puts "&#10004;body.hits.total -- '1' was equal to 1"

  @responce['hits']['hits'][0]['_source']['eventTimeEpoch'].should  == configatron.currnetTimeStamp
  puts "&#10004;['hits']['hits'][0]['_source']['eventTimeEpoch'] -- '#{configatron.currnetTimeStamp}' was equal to #{configatron.currnetTimeStamp}"

  @responce['hits']['hits'][0]['_source']['eventTimeISO'].should_not  == nil
  puts "&#10004;['hits']['hits'][0]['_source']['eventTimeISO']  was not null"

end

