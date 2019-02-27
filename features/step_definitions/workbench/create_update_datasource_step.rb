Given (/^Create a New Datasource$/) do

  #New Data Source Test Data
  @currnetTimeStamp = Time.new.to_i
  @datasource = 'sel_ds_' + @currnetTimeStamp.to_s
  @sensorid = 'com.sel.auto.' + @currnetTimeStamp.to_s
  @eventstream = 'com-event-' + @currnetTimeStamp.to_s
  @entitystream = 'com-entity-' + @currnetTimeStamp.to_s

  @orgname = configatron.orgname
  @collectionname = configatron.collectionname

  #Create a New Data Source
  begin
    on WorkbenchHomepage do |page|

      page.image_intellify.visible?.should be_true
    end
    on WorkbenchDatastore do |page|
      page.refresh
      #Redirect to Data source
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click
      page.treeview_datacollection_name(@collectionname).wait_until_present
      page.treeview_datacollection_name(@collectionname).click
      page.icon_plus.click

      #Create Data source
      page.new_datasource_creation.click

    end
    
    on WorkbenchDatasource do |page|

      page.datasource_name.set @datasource
      page.datasource_sensorId.set @sensorid
      page.datasource_eventStreamName.set @eventstream
      page.datasource_entityStreamName.set @entitystream
      #page.datasource_active.click
      page.datasource_updateBtnDS.click

    end
  end
end

When (/^New Datasource got created Successfully$/) do

  on WorkbenchDatasource do |page|

      page.datasource_alert.wait_until_present
      page.datasource_alert.text.should include "Saved","Successfully saved DataSource",'1 alert(s)','×'

      @datasourceuuid = page.datasource_uuid_check
      configatron.datasourceWB_uuid = @datasourceuuid

  end

  on WorkbenchDatastore do |page|
    page.refresh
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").wait_until_present
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click
    page.treeview_datasource_link(@datasource[0..19]).wait_until_present
    page.treeview_datasource_link(@datasource[0..19]).click
  end
end

Then (/^Verify the created Datasource Active Status,Parent Org,Parent Data collection and UUID$/) do
   on WorkbenchDatasource do |page|
     page.datasource_name_check.should == @datasource
     page.datasource_uuid_check.should == "#{@datasourceuuid}"

     #copying Element in configatron
     configatron.datasource = @datasource
     configatron.sensorid = @sensorid
     configatron.eventstream = @eventstream
     configatron.entitystream = @entitystream
   end
end

#Scenario to verify an existing Datasource
Given (/^Update an Existing Datasource$/) do

  #Update Data source variable
  @datasource = configatron.datasource
  @orgname = configatron.orgname
  @collectionname = configatron.collectionname
  @newdatasource = @datasource + '_upd'


  #Update Data source
  on WorkbenchDatastore do |page|
    #Redirect to Data source
    page.refresh
    #Redirect to Data source
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").wait_until_present
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click
    page.treeview_datasource_link(@datasource[0..19]).wait_until_present
    page.treeview_datasource_link(@datasource[0..19]).click
  end

  on WorkbenchDatasource do |page|

    #Update Data source
    page.editbtn.click
    page.datasource_name.set @newdatasource
    page.datasource_updateBtnDS.click
  end
end

When (/^Existing Datasource got updated successfully$/) do
   on WorkbenchDatasource do |page|

     page.datasource_alert.wait_until_present
     page.datasource_alert.text.should include "Saved","Successfully saved DataSource",'1 alert(s)','×'

     page.datasource_name.wait_until_present
     page.datasource_name_check.should == @newdatasource
   end
end

Then (/^Verify the Datasource updated values$/) do
   on WorkbenchDatasource do |page|
     page.datasource_name_check.should == @newdatasource
     configatron.datasource = @newdatasource
   end
end