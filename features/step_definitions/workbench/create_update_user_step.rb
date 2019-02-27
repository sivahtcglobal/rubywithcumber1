Given(/^Create new Designer user with organization designer role$/) do
  @username= configatron.workbenchAdminUsername
  @password= configatron.workbenchAdminPassword

  #Designer user variables
  @currnetTimeStamp = Time.new.to_i

  @new_designer_user_fname = 'sel' + @currnetTimeStamp.to_s
  @new_designer_user_lname = 'automation'
  @new_designer_username = 'auto_sel' + @currnetTimeStamp.to_s
  @new_designer_password = 'fooBar1@34'

  #coping local variable to global variables
  configatron.newdesigneruserfname = @new_designer_user_fname
  configatron.newdesigneruserlname = @new_designer_user_lname
  configatron.newdesignerusername = @new_designer_username
  configatron.newdesignerpassword = @new_designer_password

  @orgname = configatron.orgname

  on WorkbenchHomepage do |page|
      if page.sign_out.visible? == false then
          #login as Admin user
          log_in(@username,@password)
        page.sign_out.wait_until_present
      end
      page.data_store.click
  end

  begin
    on WorkbenchDatastore do |page|
      #Navigate to Create user

      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_plus.click
      page.newuser.click
    end
    on WorkbenchUser do |page|

      #Verify Manage User Fields
      page.manage_user_title.wait_until_present
      page.manage_user_title.exists?.should be_true
      page.user_firstname_txt.exists?.should be_true
      page.user_lastname_txt.exists?.should be_true
      page.user_username_txt.exists?.should be_true
      page.user_password_txt.exists?.should be_true
      page.user_city_txt.exists?.should be_true
      page.user_country_txt.exists?.should be_true
      page.user_email_txt.exists?.should be_true

      #Verify All Available User Roles
      page.user_role_select("Organization Analyst/Designer").exists?.should be_true

      page.user_update_btn.exists?.should be_true

      #Create user
      page.user_firstname_txt.set @new_designer_user_fname
      page.user_lastname_txt.set @new_designer_user_lname
      page.user_username_txt.set @new_designer_username
      page.user_password_txt.set @new_designer_password
      page.user_city_txt.set 'city'
      page.user_country_txt.set 'country'
      page.user_email_txt.set 'selenium@323ge.com'
      page.user_role_select("Organization Analyst/Designer").click
      page.user_update_btn.click
    end
  end
end

When(/^New Designer user created successfully$/) do
  on WorkbenchUser do |page|
    page.userCreation_alert_errorMsg.wait_until_present
    page.userCreation_alert_errorMsg.text.should include "Saved","Successfully saved User #{configatron.newdesignerusername}",'1 alert(s)','×'
    #Get the UUID of the created User
    configatron.runtimeWBUser_uuid = page.runtimeWBUser_uuid
  end
end

Then(/^Verify the created user gets displayed in the tree view user list$/) do

  on WorkbenchDatastore do |page|

    #Verify New User gets displayed in the tree View
    page.refresh
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.click

    page.org_expand.click
    page.user_expand.click

    page.treeview_username_lnk("#{@new_designer_user_fname} ","a").wait_until_present
    page.treeview_username_lnk("#{@new_designer_user_fname} ","a").exist?.should be_true

  end
end

Given(/^Update Created user profile as a different user$/) do
  #existing designer user variable
  @new_designer_user_fname = configatron.newdesigneruserfname
  @new_designer_user_lname = configatron.newdesigneruserlname
  @new_designer_username = configatron.newdesignerusername

  @orgname = configatron.orgname
  #Update existing Designer user
  begin
    on WorkbenchDatastore do |page|
      page.refresh
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click
      page.icon_refresh.wait_until_present
      page.icon_refresh.click
      page.org_expand.click
      page.user_expand.click

      page.treeview_username_lnk("#{@new_designer_user_fname} ","a").wait_until_present
      page.treeview_username_lnk("#{@new_designer_user_fname} ","a").click

    end
    on WorkbenchUser do |page|

      page.edit_btn.wait_until_present
      page.edit_btn.click

      page.user_firstname_txt.set @new_designer_user_fname + '_upd'
      page.user_lastname_txt.set @new_designer_user_lname + '_upd'
      # page.user_password_txt.double_click
      # page.user_password.send_keys :delete
      # page.user_password_txt.set 'fooBar1@34'
      page.user_city_txt.set 'cityy'
      page.user_country_txt.set 'countryy'
      page.user_email_txt.set 'selenium@323ge.com'
      page.user_role_select("Organization Analyst/Designer").click
      page.user_update_btn.click
    end
  end
end

When(/^Very that user profile was not allowed to get updated by a different user$/) do
  on WorkbenchUser do |page|

    page.userCreation_alert_errorMsg.wait_until_present
    page.userCreation_alert_errorMsg.text.should include "Error","Failed to save user",'1 alert(s)','×'

    #Logout from Admin Login
    workbench_logout
  end
end

#Verifying Profile Update as a same User

Given(/^Update Created user profile as the same user$/) do
  #existing designer user variable
  @new_designer_user_fname = configatron.newdesigneruserfname
  @new_designer_user_lname = configatron.newdesigneruserlname
  @new_designer_username = configatron.newdesignerusername
  @username= configatron.newdesignerusername
  @password= configatron.newdesignerpassword

  #login as the New User
  log_in(@username,@password)

  #Update existing Designer user
  begin
    on WorkbenchDatastore do |page|
      page.orgname(@orgname).wait_until_present
      page.orgname(@orgname).click

      page.icon_refresh.wait_until_present
      page.icon_refresh.click
      page.org_expand.wait_until_present
      page.org_expand.click
      page.user_expand.click
      page.treeview_username_lnk("#{@new_designer_user_fname} ","a").exists?.should be_true
      page.treeview_username_lnk("#{@new_designer_user_fname} ","a").click
    end

    on WorkbenchUser do |page|

      page.edit_btn.wait_until_present
      page.edit_btn.click

      page.user_firstname_txt.set @new_designer_user_fname + '_upd'
      page.user_lastname_txt.set @new_designer_user_lname + '_upd'
      # page.user_password_txt.double_click
      # page.user_password.send_keys :delete
      # page.user_password_txt.set 'fooBar1@34'
      page.user_city_txt.set 'cityy'
      page.user_country_txt.set 'countryy'
      page.user_email_txt.set 'selenium@323ge.com'
      page.user_role_select("Organization Analyst/Designer").click
      page.user_update_btn.click

    end
  end
end

When(/^Very that user profile was allowed to get updated by the same user$/) do
  on WorkbenchUser do |page|

    page.userCreation_alert_errorMsg.wait_until_present
    page.userCreation_alert_errorMsg.text.should include "Saved","Successfully saved User #{configatron.newdesignerusername}",'1 alert(s)','×'
    configatron.newdesigneruserfname = @new_designer_user_fname + '_upd'
    configatron.newdesigneruserlname = @new_designer_user_lname + '_upd'
  end

  #logout from the newly created user
  workbench_logout

end

Then(/^Verify the updated user profile information$/) do

  #Login in as a Different User to verify the Updated User
  @username= configatron.workbenchAdminUsername
  @password= configatron.workbenchAdminPassword
  log_in(@username,@password)

  @orgname = configatron.orgname
  @new_designer_user_fname = configatron.newdesigneruserfname
  @new_designer_user_lname = configatron.newdesigneruserlname

  on WorkbenchDatastore do |page|
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).click
    page.icon_refresh.wait_until_present
    page.icon_refresh.click
    page.org_expand.wait_until_present
    page.org_expand.click
    page.user_expand.click

    page.treeview_username_lnk("#{@new_designer_user_fname} ","").wait_until_present
    page.treeview_username_lnk("#{@new_designer_user_fname} ","").click
  end

  on WorkbenchUser do |page|

    page.edit_btn.wait_until_present
    page.edit_btn.click

    page.user_firstname_txt.value.should == "#{@new_designer_user_fname}"
    page.user_lastname_txt.value.should == "#{@new_designer_user_lname}"

    page.user_city_txt.value.should == 'cityy'
    page.user_country_txt.value.should == 'countryy'
    page.user_email_txt.value.should == 'selenium@323ge.com'
  end
  workbench_logout
end