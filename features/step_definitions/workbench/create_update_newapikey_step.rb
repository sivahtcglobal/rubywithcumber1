Given(/^Creation of New Api key to the Data collection$/) do

  #New API key variable
  @currnetTimeStamp = Time.new.to_i
  @apikeyname = 'Sel_APIkey_' + @currnetTimeStamp.to_s
  @orgname = configatron.orgname
  @collectionname =  configatron.collectionname

  #Create API key
  begin
    on WorkbenchDatastore do |page|
      #Redirect to API key
      page.refresh
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.wait_until_present
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click

      page.treeview_datacollection_name(@collectionname).wait_until_present
      page.treeview_datacollection_name(@collectionname).click

      page.icon_plus.click
    end

      on WorkbenchApikey do |page|

      #API Key
      page.apikey_creation.click
      page.apikey_name.set @apikeyname
      page.apikey_active.click
      page.update_btn.click
      page.apikey_uuid.wait_until_present
      @apikeyuuid = page.apikey_uuid_check
      configatron.apiKey_UUID = @apikeyuuid
    end
  end
end

When(/^The New API KEY got created successfully$/) do
  on WorkbenchDatastore do |page|
    page.icon_refresh.click
    sleep(2)
    page.treeview_datacollection_name(@collectionname).wait_until_present
    page.treeview_datacollection_name(@collectionname).click

    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click
    page.treeview_apikey_link(@apikeyname[0..19]).wait_until_present
    page.treeview_apikey_link(@apikeyname[0..19]).click
    configatron.apikeyname = @apikeyname

  end

end

Then(/^Verify the New API KEY's API Key,Active Status,Parent Org,Parent Data collection and UUID$/) do
  on WorkbenchApikey do |page|
    page.apikey_name_check.should == @apikeyname
    page.apikey_parentorg_check.should == @orgname
    page.apikey_parentdatacollection_check.should == @collectionname
    page.apikey_uuid_check.should == "#{@apikeyuuid}"
    @apikeyid = page.apikey_id

  end
end

#Update the Newly Created API Key

Given(/^Update the name of the New API key$/) do

  #Update API key variable
  @apikeyname = configatron.apikeyname
  @orgname = configatron.orgname
  @collectionname = configatron.collectionname
  @newapikeyname = @apikeyname + '_update'

  #Update API key
  begin
    on WorkbenchDatastore do |page|
      #Redirect to existing API key
      page.refresh

      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.wait_until_present
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click

      page.treeview_datacollection_name(@collectionname).wait_until_present
      page.treeview_datacollection_name(@collectionname).click
      page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click
      page.treeview_apikey_link(@apikeyname[0..19]).wait_until_present
      page.treeview_apikey_link(@apikeyname[0..19]).click
    end
    on WorkbenchApikey do |page|

      #update API key
      page.editbtn.click
      page.apikey_name.set @newapikeyname
      page.update_btn.click
    end
  end
end

When(/^Apikey Name got Updated successfully$/) do
  on WorkbenchApikey do |page|
    page.apikey_name.wait_until_present
    page.apikey_name_check.should == @newapikeyname
  end
end

Then(/^Verify the updated API KEY's Name$/) do
  on WorkbenchApikey do |page|
    page.apikey_name_check.should == @newapikeyname
    configatron.apikeyname = @newapikeyname

  end
end
