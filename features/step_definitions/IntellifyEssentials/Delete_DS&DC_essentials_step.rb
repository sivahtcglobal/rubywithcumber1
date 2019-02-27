Given(/^valid API user-Delete DS&DC$/) do
  @tokenhost = configatron.hostname1
  @tokenuser = configatron.essusername
  @tokenpass = configatron.esspassword
end

And(/^Retreive the API Token-Delete DS&DC$/) do
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  puts @apitoken
end

Then(/^Use GET method to verify the created DataSource and retreive all data from created DataSource-Delete DS&DC$/) do
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
Then(/^Use Get method to Retreive the Created Data collection$/) do
  @hostname = configatron.hostname1
  @url = "https://#{@hostname}/datasource/#{@datasourceid}"
  @datasource = get_request(@url,@apitoken)
  @collectionuuid = @datasource['parentDataCollectionId']
  puts @collectionuuid
end
Then(/^Use Get method to Retreive collection UUID$/) do
  @hostname = configatron.hostname1
  @url = "https://#{@hostname}/datacollection/#{@collectionuuid}"
  @datacollection = get_request(@url,@apitoken)
  @collectionname = @datacollection['name']
  puts @collectionname
end
Then(/^Use Delete Method to delete the created DC and DS$/) do
  @deletedatasource = configatron.datasourcedetails
  @url = "#{@deletedatasource}/#{@datasourceid}"
  delete_request(@url,@apitoken)
end