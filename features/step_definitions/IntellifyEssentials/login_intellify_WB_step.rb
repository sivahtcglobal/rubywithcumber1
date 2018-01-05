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
end
Then(/^Use GET method to verify the created Datacollection and retreive all data from created Datacollection for Datatype (.*?) \-Stream Data flow$/) do |datatype|
  @url = configatron.datacollectiondetails
  @datacollectionresponse = get_request(@url,@apitoken)
  i = 0
  until @datacollectionresponse[i]['name'] == datatype
    i += 1
  end
  @datatype = datatype
  @parentcollectionid = @datacollectionresponse[i]['uuid']
end
Then(/^Use GET method to verify the created DataSource and retreive all data from created DataSource-Stream Data flow$/) do
  @url = configatron.datasourcedetails
  @datasourceresponse = get_request(@url,@apitoken)
  i = 0
  until @datasourceresponse[i]['parentDataCollectionId'] == "#{@parentcollectionid}"
    i += 1
  end
  @datasourceid = @datasourceresponse[i]['uuid']
  puts @datasourceid
end


Then(/^Verify the Data flow into the Streams$/) do
 on Workbenchstreamsmanager do |page|
   @eventstream = "data-eventdata-#{@datasourceid}"
   @entitystream = "data-entitydata-#{@datasourceid}"
    page.streams_tab.click
   page.filter_icon.wait_until_present
   page.filter_icon.click
   sleep(5)
   page.computed_chk.click
   page.dynamic_chk.click
   page.streamname_filter.set "#{@eventstream}"
   page.record_count.should_not == '0'
   sleep(5)
   page.entitystream_name.set "#{@entitystream}"
   if @datatype == 'data_collection_596cd5d9b7d7a9570f721701' then
   page.record_count.should == '0'
   else
   page.record_count.should_not == '0'
   end
   sleep(3)
   page.sign_out.click
 end
end

