Given(/^Cancelling a Data Source Deletion$/) do


  @orgname = configatron.orgname
  @collectionname = configatron.collectionname
  @datasource = configatron.datasource

  on WorkbenchHomepage do |page|
    page.sign_out.wait_until_present
    page.data_store.click

  end

  #Cancelling a Data Source Deletion
  begin
    on WorkbenchDatastore do |page|
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

      #cancel Delete Data source
      page.editbtn.wait_until_present
      page.editbtn.click
      page.delete_ds_btn.click
      @browser.alert.wait_until_present
      @browser.alert.close if @browser.alert.exists?
    end
  end
end

When(/^Data Source should not get Deleted$/) do
  on WorkbenchDatastore do |page|
    page.treeview_datasource_link(@datasource[0..19]).exists?.should be_true
  end
end

Then(/^Verify Data Source is not Deleted$/) do
  on WorkbenchDatasource do |page|

    page.datasource_name_check.should == @datasource
    page.cancel_datasource_btn.click

  end
end

Given(/^Deleting a Data Source$/) do

  @orgname = configatron.orgname
  @collectionname = configatron.collectionname
  @datasource = configatron.datasource

  #Delete Data source
  begin
    on WorkbenchDatastore do |page|
      #Redirect to Data source
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

    on WorkbenchDatasource do |page|

      #Delete Data source
      page.editbtn.wait_until_present
      page.editbtn.click
      page.delete_ds_btn.click
      @browser.alert.ok if @browser.alert.exists?
    end
  end
end

When(/^Data Source should get Deleted Successfully$/) do
  on WorkbenchDatasource do |page|
    page.datasource_alert.wait_until_present
    page.datasource_alert.text.should include "Deleted","Successfully deleted DataSource",'1 alert(s)','×'

  end
end

Then(/^Verify Data Source is not present$/) do
  on WorkbenchDatastore do |page|

    page.refresh
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").wait_until_present
    page.element(:xpath=>"//div/i/span[text()='"+@collectionname+"']/../../../i[1]").click

    page.treeview_datasource_link(@datasource[0..19]).exist?.should be_false
  end
end