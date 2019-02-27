
Then(/^Search against hmh-slms-entities-entitydata$/) do


  @hostname = configatron.workbench
  @username= configatron.designerUsername
  @password= configatron.designerPassword
  @apitoken =  get_apitoken(@hostname,@username,@password)
  configatron.apitoken = @apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"entity.@id\": {
						\"query\": \"#{configatron.classIdR180}\",
						\"operator\": \"and\"
					}
				}
			}]
		}
	},
	\"filter\": {
		\"matchAll\": {}
	},
	\"aggs\": {},
	\"size\": 10
}"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.slmsRAWEntity}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  == "xxx-test-hmh-slms-entities-entitydata-5534f-2017-08-14"
  @responce['hits']['hits'][0]['_type'].should  == "irecord"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.classIdR180}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == nil
  @responce['hits']['hits'][0]['_source']['entity']['name'].should  == "Class0002"
  @responce['hits']['hits'][0]['_source']['entity']['displayName'].should  == "Class0002"
end

Then(/^Search against xxx-test-slms-students-with-grade-revamped and get count in index$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"class.@id\": {
						\"query\": \"#{configatron.classIdR180}\",
						\"operator\": \"and\"
					}
				}
			}, {
				\"match\": {
					\"entity.enrolledUserRole\": {
						\"query\": \"Student\",
						\"operator\": \"and\"
					}
				}
			}]
		}
	},
	\"filter\": {
		\"matchAll\": {}
	},
	\"aggs\": {},
	\"size\": \"1000\"
}"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.slmsSTUGrade}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_type'].should  == "entityData"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['person']['siteId'].should  == "h502000001"
  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h502000001"
  @responce['hits']['hits'][0]['_index'].should  include("#{configatron.slmsSTUGrade}")
  @responce['hits']['hits'][0]['_source']['entity']['enrolledIntoEntity'].should  == "#{configatron.classIdR180}"
  @responce['hits']['hits'][0]['_source']['entity']['enrolledUserRole'].should  == "Student"
end

Then(/^Search against xxx-test-r180u-synthetic-a5-b3-aggregate-with-student-info and verify we receive data$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"filtered\": {
			\"query\": {
				\"bool\": {
					\"should\": [{
						\"query_string\": {
							\"query\": \"*\"
						}
					}]
				}
			},
			\"filter\": {
				\"bool\": {
					\"must\": [{
						\"fquery\": {
							\"query\": {
								\"query_string\": {
									\"query\": \"siteId:(\\\"h502000001\\\")\"
								}
							},
							\"_cache\": true
						}
					}, {
						\"fquery\": {
							\"query\": {
								\"query_string\": {
									\"query\": \"class.@id:(\\\"#{configatron.classIdR180}\\\")\"
								}
							},
							\"_cache\": true
						}
					}],
					\"must_not\": [{
						\"fquery\": {
							\"query\": {
								\"query_string\": {
									\"query\": \"applicationId:(\\\"first_name\\\")\"
								}
							},
							\"_cache\": true
						}
					}, {
						\"fquery\": {
							\"query\": {
								\"query_string\": {
									\"query\": \"applicationId:(\\\"last_name\\\")\"
								}
							},
							\"_cache\": true
						}
					}, {
						\"fquery\": {
							\"query\": {
								\"query_string\": {
									\"query\": \"applicationId:(\\\"school_start_date\\\")\"
								}
							},
							\"_cache\": true
						}
					}, {
						\"fquery\": {
							\"query\": {
								\"query_string\": {
									\"query\": \"applicationId:(\\\"school_end_date\\\")\"
								}
							},
							\"_cache\": true
						}
					}]
				}
			}
		}
	},
	\"size\": 100000
}"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.a5b3R180}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"
end

