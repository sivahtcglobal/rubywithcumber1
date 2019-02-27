Given(/^Cancelling a Data Collection Deletion$/) do
  
  @orgname = configatron.orgname
  @collectionname = configatron.collectionname

  #Delete Data collection
  begin
    on WorkbenchDatastore do |page|
      page.refresh
      #Redirect to Data collection
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click
      page.treeview_datacollection_name(@collectionname).wait_until_present
      page.treeview_datacollection_name(@collectionname).click
    end
    on WorkbenchDatacollection do |page|

      #cancel Delete Data collection
      page.edit_btn.click
      page.delete_dc_btn.click
      @browser.alert.close if @browser.alert.exists?
    end
  end
end

When(/^Data Collection should not get Deleted$/) do
  on WorkbenchDatacollection do |page|
    page.cancel_datacollection_btn.click
    page.collection_name.value.should== "#{@collectionname}"
  end
end


Given(/^Delete Data collection$/) do

  @orgname = configatron.orgname
  @collectionname = configatron.collectionname

   #Delete Data collection
  begin
    on WorkbenchDatastore do |page|
      page.refresh
      #Redirect to Data collection
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click
      page.treeview_datacollection_name(@collectionname).wait_until_present
      page.treeview_datacollection_name(@collectionname).click
    end
    on WorkbenchDatacollection do |page|

      #Delete Data collection
      page.edit_btn.click
      page.delete_dc_btn.click
      @browser.alert.ok if @browser.alert.exists?
    end
  end
end

When(/^Data Collection Deleted Successfully$/) do

  on WorkbenchDatacollection do |page|
    page.datacollection_alert.wait_until_present
    page.datacollection_alert.text.should include "Deleted","Successfully deleted DataCollection",'1 alert(s)','×'

  end
end

Then(/^Verify Data Collection is not present$/) do

  on WorkbenchDatastore do |page|

    page.refresh
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click

    page.treeview_datacollection_name(@collectionname).exist?.should be_false
  end
  #Logout of the Workbench
  workbench_logout

end