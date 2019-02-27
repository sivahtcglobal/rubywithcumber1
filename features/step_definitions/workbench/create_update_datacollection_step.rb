Given(/^Create New Data Collection$/) do

  #Data collection variables
  @currnetTimeStamp = Time.new.to_i
  @collectionname = 'sel_dc_' + @currnetTimeStamp.to_s
  @orgname = configatron.orgname
  configatron.collectionname = @collectionname


  #Create Data collection
  begin
    on WorkbenchHomepage do |page|
      #Nevigate to Create Data collection
      page.image_intellify.visible?.should be_true
    end

    on WorkbenchDatastore do |page|
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_plus.click
    end

    #Create data collection
    @datacollectionUUID = dc_creation(@collectionname,@orgname)

  end
end

When(/^Data collection got created successfully$/) do
  on WorkbenchDatastore do |page|
    #verify New Data collection created successfully
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click

    page.treeview_datacollection_name(@collectionname).wait_until_present
    page.treeview_datacollection_name(@collectionname).click
  end
end

Then(/^Verify and Collect the data collection UUID and Parent Org name$/) do
  on WorkbenchDatacollection do |page|

    configatron.datacollectWB_uuid = page.uuid
    #Collect Data collection uuid and parent org
    page.porg_name.should == "#{@orgname}"
    page.collectionname.should== "#{@collectionname}"
    page.uuid.should == "#{@datacollectionUUID}"
  end
end

Given(/^Update Created Data collection$/) do

  #exsiting data collection name
  @collectionname = configatron.collectionname
  #updated data collection name
  @collectionname_new = @collectionname + '_upd'
  @orgname = configatron.orgname
  #update data collection
  begin
    on WorkbenchDatastore do |page|
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click

      page.org_expand.wait_until_present
      page.org_expand.click
      page.org_expand.click
      page.treeview_datacollection_name(@collectionname).wait_until_present
      page.treeview_datacollection_name(@collectionname).click
    end

    on WorkbenchDatacollection do |page|

      page.edit_btn.click
      page.collection_name.wait_until_present
      page.collection_name.set "#{@collectionname_new}"
      page.update_btn.click
    end
  end
end

When(/^Data collection name should get updated successfully$/) do


  on WorkbenchDatastore do |page|
    page.refresh

    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.wait_until_present
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click

    page.treeview_datacollection_name(@collectionname).wait_until_present
    page.treeview_datacollection_name(@collectionname).click
  end
end

Then(/^Verify the data collection name got updated successfully$/) do
  on WorkbenchDatacollection do |page|
    page.collection_name.value.should == @collectionname

  end
end