Given(/^Data Tools-login to with Valid credentials-Non Adminuser$/) do
  @username= configatron.essNonAdminusername
  @password= configatron.essNonAdminpassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end

Then(/^Verify the tools added Tableau and CSV-Non Adminuser$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.nonadmin_username.exists?.should be_true
    page.tableau_image.exists?.should be_true
    page.action_info.exists?.should be_true
    page.csv_image.exists?.should be_true
    page.export_btn.exists?.should be_true
  end
end

Then(/^Verify the elements in Tableau and CSV Tools-Non Adminuser$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_tool_element.exists?.should be_true
    page.tools_header1.should == 'Data Tool Name'
    page.tools_header2.should == 'Version'
    page.tools_header3.should == 'Actions'
    page.csv_name.should == 'CSV Download'
    page.export_btn.click
    page.csv_control.should == 'CSV Download Controls'
    page.csv_control1.should == 'Select the data you want to export and download'
    page.report_export.exists?.should be_true
    page.report_close.exists?.should be_true
    page.canvas_reports.option(text:"canvas-submission_dim").exists?.should be_true
    page.canvas_reports.option(text:"canvas-quiz_dim").exists?.should be_true
    page.canvas_reports.option(text:"canvas-user_dim").exists?.should be_true
    page.canvas_reports.option(text:"canvas-quiz_submission_fact").exists?.should be_true
    page.canvas_reports.option(text:"canvas-student-profile").exists?.should be_true
    page.canvas_reports.option(text:"canvas-assignment_dim").exists?.should be_true
    page.canvas_reports.option(text:"canvas-submission_fact").exists?.should be_true
    page.canvas_reports.option(text:"canvas-course_dim").exists?.should be_true
    page.canvas_reports.option(text:"canvas-enrollment_fact").exists?.should be_true
    page.report_close.click
    sleep(3)
    page.tableau_name.should == 'Tableau Desktop Connector'
    page.info_icon.click
    page.info_header.should == 'User Guide > Setup Tableau Desktop Connector'
    page.setup_info_header.should == 'Follow the step by step instructions below to connect to the Intellify Tableau Desktop Connector:'
    page.setup_1.should == 'Download and install Tableau Desktop at https://www.tableau.com/trial/download-tableau'
    page.setup_2.should == 'Use your assigned Tableau Desktop license key to authenticate your instance of Tableau Desktop.'
    page.setup_3.should == 'Open Tableau Desktop and go to Server > More > Web Data Connector.'
    page.setup_4.should == 'Connect to the Intellify Tableau Desktop connector by adding "/datatools/intellify-connector.html" to the end of your Essentials .intellify.io URL.'
    page.setup_5.should == 'Use your Intellify Essentials user credentials to login and connect to Essentials.'
    page.setup_6.should == 'Select the table you wish to load into Tableau Desktop.'
    page.help_info.should == 'Need more help? Click to see more documentation'
    page.close_btn.click
    page.logout.click
  end
  end

