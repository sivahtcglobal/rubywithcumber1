Given(/^This is to Clean up all the test data created while execution$/) do

  @hostname = configatron.workbench
  @apitoken =  get_apitoken(@hostname,configatron.designerUsername,configatron.designerPassword)


  #Delete ComputeStream If Any

  puts "Cleaning Up ComputeStream UUID #{configatron.computeStreamWB_uuid}"
  @posturl = File.join('https://',@hostname,"/intellistream/#{configatron.computeStreamWB_uuid}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)

  #Delete Runtime User If Any
  puts "Cleaning Up User UUID : #{configatron.runtimeWBUser_uuid}"
  @posturl = File.join('https://',@hostname,"/user/#{configatron.runtimeWBUser_uuid}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)


  #Delete Datasource If Any

  puts "Cleaning Up DatasourceUUID #{configatron.datasourceWB_uuid}"
  @posturl = File.join('https://',@hostname,"/datasource/#{configatron.datasourceWB_uuid}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)

  #Delete APIKey If Any

  puts "Cleaning Up APIKey #{configatron.datacollectWB_uuid}"
  @posturl = File.join('https://',@hostname,"/apikey/#{configatron.apiKey_UUID}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)


  #Delete DataCollection If Any

  puts "Cleaning Up DataCollection UUID #{configatron.datacollectWB_uuid}"
  @posturl = File.join('https://',@hostname,"/datacollection/#{configatron.datacollectWB_uuid}")
  @status,@responce, @header = delete_request_api(@posturl,@apitoken)


end