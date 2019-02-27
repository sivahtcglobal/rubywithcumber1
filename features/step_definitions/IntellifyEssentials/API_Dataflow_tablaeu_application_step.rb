Given(/^valid API user-Tableau$/) do
  @tokenhost = configatron.hostname1
  @tokenuser = configatron.essusername
  @tokenpass = configatron.esspassword
end

And(/^Retreive the API Token-Tableau$/) do
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  puts @apitoken
end

Then(/^Use GET method to verify the created DataSource and retreive all data from created DataSource-Tableau$/) do
  @url = configatron.datasourcedetails
  @datasourceresponse = get_request(@url,@apitoken)
  @datasourceid = @datasourceresponse[0]['id']
  @datasourcesensorid = @datasourceresponse[0]['sensorId']
  @datasourceapiKey = @datasourceresponse[0]['apiKey']
  @datasourcename = @datasourceresponse[0]['name']
  puts @datasourceid
  puts @datasourcesensorid
  puts @datasourceapiKey
  puts @datasourcename

end

And(/^Use GET method to verify available report in Workbench\-Tableau$/) do
  @url = configatron.reports
  @reportresponse = get_request(@url,@apitoken)
  puts @reportresponse[0]['name']
  puts @reportresponse[1]['name']
  puts @reportresponse[2]['name']
  puts @reportresponse[3]['name']
  puts @reportresponse[4]['name']
  puts @reportresponse[5]['name']
  puts @reportresponse[6]['name']
  puts @reportresponse[7]['name']
  puts @reportresponse[8]['name']
  sleep(60)
end

And(/^Use GET method to verify the Schema for the Report\-Tableau$/) do
  @url = configatron.schema
  @schemaresponse = get_request(@url,@apitoken)
   puts @schemaresponse.to_json
end

And(/^Use GET method to Verify the Data available in the Tableau application$/) do
  i = 0
  until i == 9
    @report = @reportresponse[i]['name']
    @essentialhost = configatron.hostname1
    @url = "https://#{@essentialhost}/api/essentials/reports/v0/#{@report}/data/tableau"
    @dataresponse = get_request(@url,@apitoken)
    @length =  @dataresponse['data'].length
    if @length == 0 then
      puts "#{@report}:" + "Record not Available"
    else
      puts "#{@report}:" +"#{@length}"
    end
    i += 1
  end
end

