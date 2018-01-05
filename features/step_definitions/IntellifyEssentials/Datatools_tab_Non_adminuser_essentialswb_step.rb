Given(/^Data Tools-login to with Valid credentials-Non Adminuser$/) do
  @username= configatron.essNonAdminusername
  @password= configatron.essNonAdminpassword
  log_in_intellifyessential(@username,@password)
end

And(/^Verify the tools added Tableau and CSV-Non Adminuser$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    sleep(10)
    page.nonadmin_username.exists?.should be true
    page.tableau_image.exists?.should be true
    page.action_info.exists?.should be true
    page.csv_image.exists?.should be true
    page.export_btn.exists?.should be true
  end
end

And(/^Verify the elements in Tableau and CSV Tools-Non Adminuser$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_tool_element.exists?.should be true
    page.tools_header1.should == 'Data Tool Name'
    page.tools_header2.should == 'Actions'
    page.csv_name.should == 'CSV Download'
    page.export_btn.click
    page.csv_control.should == 'CSV Download Controls'
    page.csv_control1.should == 'Select the data you want to export and download'
    sleep(10)
    reports = ['Canvas_Assignment_Submission_Table','Canvas_Course_Section_Table','Canvas_Quiz_Submission_Table','Smarter_Measure_Table']
    reports.each do |item|
      row = 0
      until page.report_name1(row) == item
        row += 1
      end
      puts page.report_name1(row)
      puts page.report_column(row)
      page.report_downloadicon(row).exists?.should be true
      page.report_datatablelink(row).exists?.should be true
    end
    page.send_keys [:control, :end]
    page.report_close.wait_until_present
    page.report_close.click
    sleep(3)
    page.tableau_name.should == 'Tableau Desktop Connector'
    page.info_icon.click
    sleep(5)
    page.info_header.should == 'User Guide > Setup Tableau Desktop Connector'
    if configatron.environment == 'Master-Staging' then
      page.tableaulic_header.should == 'Your Tableau License Keys'
      page.license_header1.should == 'License Key #1'
      page.license_key1.should == 'licensekey123'
      page.license_header2.should == 'License Key #2'
      page.license_key2.should == 'licensekey456'
    elsif configatron.environment == 'Master-DEV' then
      puts 'Master Dev No license Key configured'
    else
      puts 'Master Prod No license Key configured'
    end
    page.setup_info_header.should == 'Follow the step by step instructions below to connect to the Intellify Tableau Desktop Connector:'
    page.setup_1.should == 'Download and install Tableau Desktop at https://www.tableau.com/trial/download-tableau'
    page.setup_2.should == 'Use your assigned Tableau Desktop license key to authenticate your instance of Tableau Desktop.'
    page.setup_3.should == 'Open Tableau Desktop and go to Server > More > Web Data Connector.'
    page.setup_4.should == 'Connect to the Intellify Tableau Desktop connector by adding "/apps/tableau/" to the end of your Essentials .intellify.io URL.'
    page.setup_5.should == 'Use your Intellify Essentials user credentials to login and connect to Essentials.'
    page.setup_6.should == 'Select the table you wish to load into Tableau Desktop.'
    page.help_info.should == 'Need more help? Click to see more documentation'
    page.send_keys [:control, :end]
    page.close_btn.wait_until_present
    page.close_btn.click
    sleep(5)
    page.logout.click
  end
  end

