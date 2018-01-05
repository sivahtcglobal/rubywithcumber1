Given(/^login to intellify essential With Valid username and password$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify all element in the home page-Help tab$/) do
  on IntellifyEssentialHomePage do |page|
    page.data_source.wait_until_present
    page.pagetitle.should == "Intellify Essentials"
    page.element(:xpath=>"//span/img").visible?.should be true
    page.data_source.exists?.should be true
    page.acc_setting.exists?.should be true
    page.help.exists?.should be true
    page.data_tool.exists?.should be true
    page.username.should == 'Welcome EssentialsAdmin user'
  end
end

Then (/^Click on Help Tab & verify the Element in help page$/) do
  on IntellifyEssentialHelppage do |page|
    page.help.click
    sleep(3)
    page.welcome_header.should == "Welcome to Essential Documentation"
    page.welcome_para.should == "If you are new to essentials please see our getting started tour which will help you understand our core features and functionality. Or, if you would rather jump right in select a help topic to the left to start on a specific topic."
  end
end


Then(/^Click on Essentials User System Navigation in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.sys_orien.should == "System Orientation"
    page.sys_link1text.should == "Essentials User System Navigation"
    page.sys_link1.click
    page.help_page_view.exists?.should be true
  end
end

Then(/^Click on Essentials Admin System Navigation in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.sys_link2.click
    page.sys_link2text.should == "Essentials Admin System Navigation"
    page.help_page_view.exists?.should be true
  end
end

Then(/^Click on Add a New Data Source in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.datasource_title.should == "Data Sources"
    page.datasource_link1.click
    sleep(3)
    page.datasource_link1text.should == "Add a New Data Source"
    page.help_page_view.exists?.should be true  
  end
end

Then(/^Click on Configure a Moodle Data Source in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.config_moodlelink.click
    sleep(3)
    page.config_moodlelinktext.should == "Configure a Moodle Data Source"
    page.help_page_view.exists?.should be true   
  end
end

Then(/^Click on Configure a Canvas Data Source in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.config_canvaslink.click
    sleep(3)
    page.config_canvaslinktext.should == "Configure a Canvas Data Source"
    page.help_page_view.exists?.should be true
  end
end

Then(/^Click on Set Up Tableau Desktop Connector in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.datatools_title.should == "Data Tools"
    page.tableau_setuplink.click
    sleep(3)
    page.tableau_setuplinktext.should == "Set Up Tableau Desktop Connector"
    page.help_page_view.exists?.should be true
  end
end

Then(/^Click onImplement Essentials Starter Workbook in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.starter_workbooklink.click
    sleep(3)
    page.starter_workbooklinktext.should == "Implement Essentials Starter Workbook"
    page.help_page_view.exists?.should be true
  end
end

Then(/^Click onDownload CSV Export in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.downlaod_csvlink.click
    sleep(3)
    page.download_csvlinktext.should == "Download CSV Export"
    page.help_page_view.exists?.should be true
    page.send_keys :page_down
  end
end

Then(/^Click onChange User Email or Password in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.accsetting_title.should == "Account Settings"
    page.change_userpasslink.click
    sleep(3)
    page.change_userpasslinktext.should == "Change User Email or Password"
    page.help_page_view.exists?.should be true
    page.send_keys :page_down
  end
end

Then(/^Click onUpdate Organization Account Information in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    sleep(10)
    page.update_orgacclink.click
    sleep(3)
    page.update_orgacclinktext.should == "Update Organization Account Information"
    page.help_page_view.exists?.should be true
    page.send_keys :page_down
  end
end

Then(/^Click onCreate New User Account in Help page and validate$/) do
  on IntellifyEssentialHelppage do |page|
    page.create_userlink.click
    sleep(3)
    page.create_userlinktext.should == "Create New User Account"
    page.help_page_view.exists?.should be true
    sleep(3)
    page.send_keys :page_down

  end
end

Then(/^click on Data table list$/) do
  on IntellifyEssentialHelppage do |page|
    page.data_table_header.should == 'Data Table Documentation'
    reports = ['Canvas_Quiz_Submission_Table','Canvas_Course_Section_Table','Canvas_Enrollments_Table','Canvas_User_Profile_Table','Canvas_Assignment_Submission_Table','Canvas_Student_Activity_Table','Smarter_Measure_Table']
    reports.each do |item|
      row = 0
    until page.data_listtxt(row) == item
      row += 1
    end
    puts page.data_listtxt(row)
    page.data_table_list(row).click
    sleep(3)
    page.help_page_view.exists?.should be true
    page.send_keys :page_down
    end
    page.data_source.click
    page.logout.click
  end
end