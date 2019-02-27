Given(/^Cancelling API Key Deletion$/) do
  
  @orgname = configatron.orgname
  @collectionname = configatron.collectionname
  @apikeyname = configatron.apikeyname

 #Delete API key
  begin
    on WorkbenchDatastore do |page|
      page.refresh
      #Redirect to API key
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click

      page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").wait_until_present
      page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click
            
      page.treeview_apikey_link(@apikeyname[0..19]).wait_until_present
      page.treeview_apikey_link(@apikeyname[0..19]).click
    end
    
    on WorkbenchApikey do |page|

      #cancel Delete API key
      page.editbtn.click
      page.delete_apikey_btn.click
      @browser.alert.close if @browser.alert.exists?
      page.cancel_apikey_btn.click
    end
  end
end

When(/^API key should get not Deleted$/) do
  on WorkbenchDatastore do |page|
    page.treeview_apikey_link(@apikeyname[0..19]).exist?.should be_true
  end
end

Then(/^Verify API key is not Deleted$/) do
  on WorkbenchApikey do |page|
    page.apikey_name_check.should == @apikeyname
    page.apikey_parentorg_check.should == @orgname
    page.apikey_parentdatacollection_check.should == @collectionname
  end
end

Given(/^Deleting an API Key$/) do

  @orgname = configatron.orgname
  @collectionname = configatron.collectionname
  @apikeyname = configatron.apikeyname

  #Delete API key
  begin
    on WorkbenchDatastore do |page|
      page.refresh
      #Redirect to API key
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click
      page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").wait_until_present
      page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click
      page.treeview_apikey_link(@apikeyname[0..19]).wait_until_present
      page.treeview_apikey_link(@apikeyname[0..19]).click
    end
    on WorkbenchApikey do |page|

      #Delete API key
      page.editbtn.click
      page.delete_apikey_btn.click
      @browser.alert.ok if @browser.alert.exists?
    end
  end
end

When(/^API key should get Deleted Successfully$/) do

  on WorkbenchApikey do |page|

    page.apikey_alert.wait_until_present
    page.apikey_alert.text.should include "Deleted","Successfully deleted API Key",'1 alert(s)','×'

  end

end

Then(/^Verify API key is not present$/) do
  on WorkbenchDatastore do |page|

    page.refresh
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").wait_until_present
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click

    page.treeview_apikey_link(@apikeyname[0..19]).exist?.should be_false
  end
end