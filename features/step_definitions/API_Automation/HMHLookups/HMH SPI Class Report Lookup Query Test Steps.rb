
Then(/^Search classId against xxx-test-slms-classes-in-schools$/) do

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
						\"query\": \"#{configatron.spiClassId}\",
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
	\"size\": \"1\",
	\"sort\": [{
		\"timestamp\": {
			\"order\": \"desc\"
		}
	}]
}"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.slmsClasses}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  include "#{configatron.slmsClasses}"
  @responce['hits']['hits'][0]['_type'].should  == "event"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.spiClassId}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity.siteId'].should  == nil
  @responce['hits']['hits'][0]['_source']['entity']['@id'].should  == "#{configatron.spiClassId}"
end

Then(/^Search enrolled teacher against xxx-test-slms-students$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"class.@id\": {
						\"query\": \"#{configatron.spiClassId}\",
						\"operator\": \"and\"
					}
				}
			}, {
				\"match\": {
					\"entity.enrolledUserRole\": {
						\"query\": \"Teacher\",
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
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.slmsStudents}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['total'].should  == 0
  # @responce['hits']['hits'][0]['_index'].should  == "#{configatron.slmsStudents}"
  # @responce['hits']['hits'][0]['_type'].should  == "event"
  # @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  # @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  # @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.spiClassId}_enroll"
  # @responce['hits']['hits'][0]['_source']['type'].should  == "ENROLLMENT"
  # @responce['hits']['hits'][0]['_source']['entity.siteId'].should  == "h900000031"
  # @responce['hits']['hits'][0]['_source']['entity.enrolledUserRole'].should  == "Teacher"
  # @responce['hits']['hits'][0]['_source']['entity']['@id'].should  == "#{configatron.spiClassId}_enroll"
end

Then(/^Search ClassId against xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"entity.@id\": {
						\"query\": \"#{configatron.spiClassId}\",
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
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  == "xxx-test-hmh-slms-entities-entitydata-5534f-2017-08-14"
  @responce['hits']['hits'][0]['_type'].should  == "irecord"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.spiClassId}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity.siteId'].should  == nil
  @responce['hits']['hits'][0]['_source']['entity']['@id'].should  == "#{configatron.spiClassId}"
end

Then(/^Search ClassId against xxx-test-slms-classes-in-schools$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"entity.@id\": {
						\"query\": \"#{configatron.spiClassId}\",
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
	\"size\": \"1\",
	\"sort\": [{
		\"timestamp\": {
			\"order\": \"desc\"
		}
	}]
}"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.slmsClasses}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  include "xxx-test-slms-classes-in-schools"
  @responce['hits']['hits'][0]['_type'].should  == "event"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.spiClassId}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity.siteId'].should  == nil
  @responce['hits']['hits'][0]['_source']['entity']['@id'].should  == "#{configatron.spiClassId}"
end

Then(/^Search Enrolled Student against xxx-test-slms-students-with-grade$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"class.@id\": {
						\"query\": \"#{configatron.spiClassId}\",
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
  @responce['hits']['hits'][0]['_index'].should  include "xxx-test-slms-students-with-grade"
  @responce['hits']['hits'][0]['_type'].should  == "entityData"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['type'].should  == "ENROLLMENT"
  @responce['hits']['hits'][0]['_source']['entity.siteId'].should  == nil
  @responce['hits']['hits'][0]['_source']['entity.enrolledUserRole'].should  == "Student"
  @responce['hits']['hits'][0]['_source']['class']['@id'].should  == "#{configatron.spiClassId}"
end

Then(/^Search student against slms raw xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "
{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"entity.@id\": {
						\"query\": \"first_name\",
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
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
end

Then(/^Search Specific ClassId against xxx-test-slms-classes-in-schools$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"entity.@id\": {
						\"query\": \"#{configatron.spiClassId}\",
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
	\"size\": \"1\",
	\"sort\": [{
		\"timestamp\": {
			\"order\": \"desc\"
		}
	}]
}"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.slmsClasses}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  include "xxx-test-slms-classes-in-schools"
  @responce['hits']['hits'][0]['_type'].should  == "event"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.spiClassId}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity.siteId'].should  == nil
  @responce['hits']['hits'][0]['_source']['entity']['@id'].should  == "#{configatron.spiClassId}"
end

Then(/^Search Last_name against xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"entity.@id\": {
						\"query\": \"last_name\",
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
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
end

Then(/^Search ClassId against on xxx-test-slms-classes-in-schools$/) do

  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
	\"query\": {
		\"bool\": {
			\"must\": [{
				\"match\": {
					\"entity.@id\": {
						\"query\": \"#{configatron.spiClassId}\",
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
	\"size\": \"1\",
	\"sort\": [{
		\"timestamp\": {
			\"order\": \"desc\"
		}
	}]
}"
  @posturl = File.join('https://',@hostname,"/intellisearch/#{configatron.slmsClasses}/_search")
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  include "xxx-test-slms-classes-in-schools"
  @responce['hits']['hits'][0]['_type'].should  == "event"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.spiClassId}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h900000031"
  @responce['hits']['hits'][0]['_source']['entity']['@id'].should  == "#{configatron.spiClassId}"
end