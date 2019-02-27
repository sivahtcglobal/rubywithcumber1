
Then(/^Search List of Teacher using classId in xxx-test-slms-students$/) do

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
								\"class.@id\": {
									\"query\": \"#{configatron.sriClassId}\",
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
  @posturl = File.join('https://',@hostname,'/intellisearch/xxx-test-slms-students/_search')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"
  # @responce['hits']['hits'][0]['_index'].should  == "xxx-test-slms-students"
  # @responce['hits']['hits'][0]['_type'].should  == "event"
  # @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  # @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  # @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.sriClassId}_enroll"
  # @responce['hits']['hits'][0]['_source']['type'].should  == "ENROLLMENT"
  # @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h900000031"
  # @responce['hits']['hits'][0]['_source']['entity.enrolledUserRole'].should  == "Teacher"
  # @responce['hits']['hits'][0]['_source']['entity']['@id'].should  == "#{configatron.sriClassId}_enroll"
end

Then(/^Search and get the class information using classId against xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken

  @query = "{
					\"query\": {
						\"bool\": {
							\"must\": [{
								\"match\": {
									\"entity.@id\": {
										\"query\": \"#{configatron.sriClassId}\",
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
  @posturl = File.join('https://',@hostname,'/intellisearch/xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d/_search')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  == "xxx-test-hmh-slms-entities-entitydata-5534f-2017-08-14"
  @responce['hits']['hits'][0]['_type'].should  == "irecord"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.sriClassId}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h900000031"
end

Then(/^Search and get the class information from school index against xxx-test-slms-classes-in-schools$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
							\"query\": {
								\"bool\": {
									\"must\": [{
										\"match\": {
											\"entity.@id\": {
												\"query\": \"#{configatron.sriClassId}\",
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
  @posturl = File.join('https://',@hostname,'/intellisearch/xxx-test-slms-classes-in-schools/_search')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"
  @responce['hits']['hits'][0]['_index'].should  == "xxx-test-slms-classes-in-schools-20161013"
  @responce['hits']['hits'][0]['_type'].should  == "event"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entityId'].should  == "#{configatron.sriClassId}"
  @responce['hits']['hits'][0]['_source']['type'].should  == "CLASS"
  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h900000031"
end

Then(/^Search and get the list of students with grade enrolled in xxx-test-slms-students-with-grade-revamped$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
								\"query\": {
									\"bool\": {
										\"must\": [{
											\"match\": {
												\"class.@id\": {
													\"query\": \"#{configatron.sriClassId}\",
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
  @posturl = File.join('https://',@hostname,'/intellisearch/xxx-test-slms-students-with-grade/_search')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to "
  @responce['hits']['hits'][0]['_index'].should  == "xxx-test-slms-students-with-grade-20161013-5"
  @responce['hits']['hits'][0]['_type'].should  == "event"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['type'].should  == "ENROLLMENT"
  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h900000031"
  @responce['hits']['hits'][0]['_source']['entity.enrolledUserRole'].should  == "Student"
  @responce['hits']['hits'][0]['_source']['entity.enrolledIntoEntity'].should  == "#{configatron.sriClassId}"
end

Then(/^Search and get the lexile range -1000 to 1000 from xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
							\"query\": {
								\"filtered\": {
									\"query\": {
										\"bool\": {
											\"must\": [{
												\"range\": {
													\"entity.lowerLexileRangeValue\": {
														\"gte\": \"-10000\",
														\"lte\": \"10000\"
													}
												}
											}]
										}
									},
									\"filter\": {
										\"term\": {
											\"entity.@type\": \"EXPECTED_LEXILE_GROWTH\"
										}
									}
								}
							},
							\"aggs\": {},
							\"size\": \"8000\"
						}"
  @posturl = File.join('https://',@hostname,'/intellisearch/xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d/_search')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"
  @responce['hits']['hits'][0]['_index'].should  == "xxx-test-hmh-slms-entities-entitydata-5534f-2017-08-14"
  @responce['hits']['hits'][0]['_type'].should  == "irecord"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entity']['@type'].should  == "EXPECTED_LEXILE_GROWTH"
end

Then(/^Search and get the GRADE_NORM from 0 to 5 from xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken

  @query = "{
									\"query\": {
										\"bool\": {
											\"must\": [{
												\"constant_score\": {
													\"filter\": {
														\"term\": {
															\"entity.@type\": \"LEXILE_GRADE_NORM\"
														}
													},
													\"boost\": 1
												}
											}, {
												\"constant_score\": {
													\"filter\": {
														\"range\": {
															\"entity.gradePerformanceThresholdId\": {
																\"gte\": \"0\",
																\"lte\": \"5\"
															}
														}
													},
													\"boost\": 1
												}
											}, {
												\"constant_score\": {
													\"filter\": {
														\"range\": {
															\"creationTime\": {
																\"gte\": \"1455995793400\",
																\"lte\": \"1456275864099\"
															}
														}
													},
													\"boost\": 1
												}
											}],
											\"must_not\": [],
											\"should\": []
										}
									},
									\"aggs\": {},
									\"size\": \"200\",
									\"sort\": [{
										\"entity.gradeLevel\": {
											\"order\": \"asc\"
										}
									}, {
										\"entity.gradePerformanceThresholdId\": {
											\"order\": \"asc\"
										}
									}]
								}"
  @posturl = File.join('https://',@hostname,'/intellisearch/xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d/_search')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"
  @responce['hits']['hits'][0]['_index'].should  == "xxx-test-hmh-slms-entities-entitydata-5534f-2017-08-14"
  @responce['hits']['hits'][0]['_type'].should  == "irecord"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
  @responce['hits']['hits'][0]['_source']['entity']['siteId'].should  == "h900000031"
  @responce['hits']['hits'][0]['_source']['entity']['@type'].should  == "LEXILE_GRADE_NORM"
end


Then(/^Search and get the lowerLexileRangeValue from -1000 to 1000 in xxx-test-slms-classes-in-schools$/) do


  @hostname = configatron.workbench
  @apitoken = configatron.apitoken
  @query = "{
						\"query\": {
							\"filtered\": {
								\"query\": {
									\"bool\": {
										\"must\": [{
											\"range\": {
												\"entity.lowerLexileRangeValue\": {
													\"gte\": \"-10000\",
													\"lte\": \"10000\"
												}
											}
										}]
									}
								},
								\"filter\": {
									\"term\": {
										\"entity.@type\": \"EXPECTED_LEXILE_GROWTH\"
									}
								}
							}
						},
						\"aggs\": {},
						\"size\": \"8000\"
					}"
  @posturl = File.join('https://',@hostname,'/intellisearch/xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d/_search')
  @status,@responce, @header = post_request_api(@posturl,@query,@apitoken)
  @hitcount = @responce['hits']['total']

  puts "<b>ASSERTIONS</b>"
  @status.should == 200
  puts "&#10004;Status -- 200 was a number equal to 200"
  @responce['hits']['hits'][0]['_type]'].should  == "irecord"
  @responce['hits']['hits'][0]['_source']['apiKey'].should  == "yScTs-BpQVaSg0PIlDlfzw"
  @responce['hits']['hits'][0]['_source']['sensorId'].should  == "com.scholastic.slms.dev1"
end

