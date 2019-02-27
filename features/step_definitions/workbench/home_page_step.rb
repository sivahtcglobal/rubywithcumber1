

When(/^Successfully logged in to Workbench Home page$/) do

  #Login in as a Newly Created Designer User
  @username= configatron.newdesignerusername
  @password= configatron.newdesignerpassword
  log_in(@username,@password)

  @orgname = configatron.orgname
  @user_fname = configatron.newdesigneruserfname
  @user_lname = configatron.newdesigneruserlname

  on WorkbenchHomepage do |page|
    page.sign_out.wait_until_present
    page.sign_out.visible?.should be_true
  end
end


Then(/^Verify the intellify logo gets displayed in the workbench Home page$/) do
  on WorkbenchHomepage do |page|
    page.image_intellify.visible?.should be_true
  end
end

Then(/^Verify the Logged in User's display name$/) do

  on WorkbenchHomepage do |page|
    page.username(@user_fname,@user_lname).exists?.should be_true
    page.userrole.exists?.should be_true
  end
end


Then(/^Verify the Envelop icon is displayed in the workbench$/) do
  on WorkbenchHomepage do |page|
  page.envelop_icon.exists?.should be_true
  end
end

Then(/^Verify the Comment icon is displayed in the workbench$/) do
  on WorkbenchHomepage do |page|
  page.comment_icon.exists?.should be_true
  end
end


  Then(/^Verify the Data store tab is available$/) do
  on WorkbenchHomepage do |page|
  page.data_store.visible?.should be_true
  end
end


  Then(/^Verify the Streams tab is available$/) do
  on WorkbenchHomepage do |page|
    page.element(:xpath,"//ul/li[2]/a/h2/small").exists?
  end
end


  Then(/^Verify the Views tab is available$/) do
  on WorkbenchHomepage do |page|
    page.element(:xpath,"//ul/li[3]/a/h2/small").exists?
  end
end


  Then(/^Verify the Data store tab page label$/) do
  on WorkbenchHomepage do |page|
  page.intelli_manager.exists?.should be_true
  end
end


  Then(/^Verify the Label Products organizations$/) do
  on WorkbenchHomepage do |page|
  page.product_org.exists?.should be_true
  end
end

Then(/^Verify the manage and orgdata$/) do
  on WorkbenchHomepage do |page|
    page.org_data.exists?.should be_true
end
end

  Then(/^Verify the Plus icon$/) do
  on WorkbenchHomepage do |page|
  page.icon_plus.exists?.should be_true
end
end

Then(/^verify the Refresh icon$/) do
  on WorkbenchHomepage do |page|
  page.icon_refresh.exists?.should be_true
  end
end




Then(/^Verify the Signout Icon$/) do
  on WorkbenchHomepage do |page|
    page.sign_out.exists?.should be_true

  end
end

Then(/^Verify the Tooltips in home page$/) do
  on WorkbenchHomepage do |page|
    page.tooltip_org.exists?.should be_true
    page.tooltip_user.exists?.should be_true
    page.tooltip_service.exists?.should be_true
    page.tooltip_collection.exists?.should be_true
    page.tooltip_source.exists?.should be_true
    page.tooltip_apikey.exists?.should be_true
    page.tooltip_intellistream.exists?.should be_true
    page.tooltip_intelliview.exists?.should be_true
  end
end

Then(/^Verify the Manage List$/) do
  on WorkbenchHomepage do |page|
    page.orgname(@orgname).wait_until_present
    page.orgname(@orgname).exists?.should be_true
    page.home_manage.exists?.should be_true
    page.organization.exists?.should be_true
    page.data_collection.exists?.should be_true
    page.api_key.exists?.should be_true
    page.data_Sources.exists?.should be_true
    page.services.exists?.should be_true
    #page.intelliview.exists?.should be_true
    #page.users.exists?.should be_true
    page.dis.exists?.should be_true
  end
end
