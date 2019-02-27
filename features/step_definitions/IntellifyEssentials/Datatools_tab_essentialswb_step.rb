Given(/^Data Tools-login to with Valid credentials$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
  sleep(5)
end
When(/^Verify element Present in the home page-data tools$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.pagetitle.visible?.should be_true
    page.element(:xpath=>"//span/img").visible?.should be_true
    page.data_source.exists?.should be_true
    # page.data_store.exists?.should be_true
    page.acc_setting.exists?.should be_true
    page.help.exists?.should be_true
    page.data_tool.exists?.should be_true
    page.username.exists?.should be_true

  end
end
And(/^Click on Data Source tab Verify the created Canvas Data Source$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_source.click
    page.canvas_image.exists?.should be_true
    page.canvas_name.should == 'Canvas'
    page.canvas_version.should == 'Connector Version 0.1'
    page.canvas_status.should == 'Status: Paused'
    page.config_canvas.exists?.should be_true
    page.config_canvas.click
    page.config_header.should == 'User Guide > Canvas'
    page.inst_header.should == 'Follow the step by step instructions below to create your Canvas API Credentials:'
    page.step1_inst.should == 'Login to Canvas as an administrator, or contact your adminstrator for further assistance.'
    page.step2_inst.should == 'Go to Account Navigation > Canvas Data Portal > Credential Portal.'
    page.step3_inst.should == 'Click the Create Credentials button to generate the API credentials. For more information, refer to https://community.canvaslms.com/docs/DOC-4656.'
    page.step4_inst.should == 'Enter the Canvas API key and Secret values below.'
    page.canvas_url.should == 'Canvas Url'
    page.canvas_url_input.set 'https://intellify.instructure.com'
    page.canvas_key.should == 'Canvas Key'
    page.canvas_key_input.set 'a326dec9239b6c59b168daa3f9edb79f67c57e81'
    page.canvas_secret.should == 'Canvas Secret'
    page.canvas_secret_input.set '3fc18798caa8bd1c194b37e5e33cdf8a8e3a9741'
    page.canvas_save.exists?.should be_true
    page.canvas_close.exists?.should be_true
    page.canvas_save.click
    page.canvas_close.click
    sleep(5)
      page.start_btn.click
    sleep(5)
    page.canvas_status.should == 'Status: Running'

  end
end
Then(/^click data tools tab$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_tool.click
    page.data_tool_element.exists?.should be_true
  end
end

And(/^Verify the tools added Tableau and CSV$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.tableau_image.exists?.should be_true
    page.action_info.exists?.should be_true
    page.csv_image.exists?.should be_true
    page.export_btn.exists?.should be_true
  end
end

And(/^Verify the elements in Tableau and CSV Tools$/) do
  on IntellifyEssentialDatatoolsPage do |page|
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

