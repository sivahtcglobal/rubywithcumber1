Given(/^Cancelling a user Deletion$/) do
  @username= configatron.workbenchAdminUsername
  @password=configatron.workbenchAdminPassword

  @orgname = configatron.orgname
  @new_designer_user = configatron.newdesigneruserfname
  @new_designer_user_fname = configatron.newdesigneruserfname
  @new_designer_user_lname = configatron.newdesigneruserlname

  #login as admin user
  log_in(@username,@password)

  #Delete Designer user
  begin
    on WorkbenchDatastore do |page|
      #Redirect to Designer user
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click
      page.user_expand.click
      page.treeview_username_lnk("#{@new_designer_user_fname[0..19]}","").wait_until_present
      page.treeview_username_lnk("#{@new_designer_user_fname[0..19]}","").click
    end
    on WorkbenchUser do |page|

      #Cancel Delete Designer user
      page.edit_btn.wait_until_present
      page.edit_btn.click
      page.delete_usr_btn.click
      @browser.alert.wait_until_present
      @browser.alert.close #if @browser.alert.exists?
    end
  end
end

When(/^User should not get Deleted$/) do
  on WorkbenchDatastore do |page|
    page.treeview_username_lnk("#{@new_designer_user_fname[0..19]}","").exist?.should be_true
  end
end

Then(/^Verify Designer user is present$/) do

  on WorkbenchUser do |page|

    page.cancel_usr_btn.click

    page.user_firstname_txt.value.should == "#{@new_designer_user_fname}"
    page.user_lastname_txt.value.should == "#{@new_designer_user_lname}"

    page.user_city_txt.value.should == 'cityy'
    page.user_country_txt.value.should == 'countryy'
    page.user_email_txt.value.should == 'selenium@323ge.com'

  end

end

Given(/^Deleting a user$/) do


  @orgname = configatron.orgname
  @new_designer_user = configatron.newdesigneruserfname
  @new_designer_user_fname = configatron.newdesigneruserfname
  @new_designer_user_lname = configatron.newdesigneruserlname


  #Delete Designer user
  begin
    on WorkbenchDatastore do |page|
      page.refresh
      #Redirect to Designer user
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click
      page.user_expand.click
      page.treeview_username_lnk("#{@new_designer_user_fname[0..19]}","").wait_until_present
      page.treeview_username_lnk("#{@new_designer_user_fname[0..19]}","").click
    end
    on WorkbenchUser do |page|

      #Delete Designer user
      page.edit_btn.click
      page.delete_usr_btn.click
      @browser.alert.wait_until_present
      @browser.alert.ok if @browser.alert.exists?
    end
  end
end

When(/^User should get Deleted Successfully$/) do
  on WorkbenchUser do |page|
    page.userCreation_alert_errorMsg.wait_until_present
    page.userCreation_alert_errorMsg.text.should include "Deleted","Successfully deleted User",'1 alert(s)','×'

  end
end

Then(/^Verify user is not present$/) do
  on WorkbenchDatastore do |page|

    page.refresh
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click
    page.user_expand.click

    page.treeview_username_lnk("#{@new_designer_user_fname[0..19]}","").exist?.should be_false
  end
  #Logout of the Workbench
  workbench_logout
end

Then(/^Verify deleted user is not allowed to login$/) do

  @new_designer_username = configatron.newdesignerusername
  @new_designer_password = configatron.newdesignerpassword

#Login into Workbench with a valid Credentials
  log_in(@new_designer_username,@new_designer_password)

  on IntellifyLoginPage do |page|

    page.login_alert_errorMsg.wait_until_present
    page.login_alert_errorMsg.text.should include '×',"Login failed for #{@new_designer_username}. Please check your username and password and try again.",'1 alert(s)'

  end
end