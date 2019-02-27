Given(/^Intellify workbench login Using Valid credentials$/) do
  @username= configatron.intellifywbuser
  @password= configatron.intellifywbpassword
  log_inwb(@username,@password)
  sleep(5)
end
And(/^Retreive the API Token-Stream Data flow$/) do
  @tokenhost = configatron.hostname1
  @tokenuser = configatron.intellifywbuser
  @tokenpass = configatron.intellifywbpassword
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  puts @apitoken
  end
Then(/^Use GET method to verify the created DataSource and retreive all data from created DataSource-Stream Data flow$/) do
  @url = configatron.datasourcedetails
  @datasourceresponse = get_request(@url,@apitoken)
  puts @datasourceresponse.to_json
  @datasourceid = @datasourceresponse[0]['id']
  @datasourcesensorid = @datasourceresponse[0]['sensorId']
  @datasourceapiKey = @datasourceresponse[0]['apiKey']
  @datasourcename = @datasourceresponse[0]['name']
  puts @datasourceid
  puts @datasourcesensorid
  puts @datasourceapiKey
  puts @datasourcename
  end

Then(/^Verify the Data flow into the Streams$/) do
 on Workbenchdynamicstream do |page|
   @eventstream = "data-eventdata-#{@datasourceid}"
   @entitystream = "data-entitydata-#{@datasourceid}"
    page.streams_tab.click
   sleep(10)
   page.filter_icon.click
   page.computed_chk.click
   page.dynamic_chk.click
   page.streamname_filter.set "#{@eventstream}"
   @recordcount = puts page.record_count
   puts @recordcount
   page.record_count.should_not == '0'
   sleep(5)
   page.entitystream_name.set "#{@entitystream}"
   @recordcount1 = puts page.record_count
   puts @recordcount1
   page.record_count.should_not == '0'
   sleep(3)
   page.sign_out.click
 end
end