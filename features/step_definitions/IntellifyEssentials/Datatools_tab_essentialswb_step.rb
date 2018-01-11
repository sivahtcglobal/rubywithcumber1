Given(/^Data Tools-login to with Valid credentials$/) do
  @username= configatron.essusername
  @password= configatron.esspassword
  log_in_intellifyessential(@username,@password)
end
And(/^Verify element Present in the home page-data tools$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_source.wait_until_present
    page.pagetitle.should == 'Intellify Essentials'
    page.element(:xpath=>"//span/img").visible?.should be true
    page.data_source.exists?.should be true
    page.acc_setting.exists?.should be true
    page.help.exists?.should be true
    page.data_tool.exists?.should be true
    page.username.should == 'Welcome EssentialsAdmin user'

  end
end
Then(/^Click on Data Source tab Verify the created Canvas Data Source$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_source.click
    page.canvas_image.wait_until_present
    page.canvas_image.exists?.should be true
    page.canvas_name.should == 'Canvas'
    page.canvas_version.should == 'Connector Version 1.0.9'
    page.canvas_status.should == 'Status: Paused'
    page.config_canvas.exists?.should be true
    page.config_canvas.click
    page.config_header.should == 'User Guide > Canvas'
    page.inst_header.should == 'Follow the step by step instructions below to create your Canvas API Credentials:'
    page.step1_inst.should == 'Login to Canvas as an administrator, or contact your adminstrator for further assistance.'
    page.step2_inst.should == 'Go to Account Navigation > Canvas Data Portal > Credential Portal.'
    page.step3_inst.should == 'Click the Create Credentials button to generate the API credentials. For more information, refer to https://community.canvaslms.com/docs/DOC-4656.'
    page.step4_inst.should == 'Enter the Canvas API key and Secret values below.'
    page.canvas_url.should == 'Canvas Portal Url'
    page.canvas_url_input.set 'https://intellify.instructure.com'
    page.canvas_synurl.should == 'Canvas File Sync Url'
    page.canvas_synurl_input.set 'https://portal.inshosteddata.com/api/account/self/file/sync'
    page.canvas_key.should == 'Canvas Key'
    page.canvas_key_input.set '027fcec668723b15eb1db37a77bbbdf5839cee8b'
    page.canvas_secret.should == 'Canvas Secret'
    page.canvas_secret_input.set 'cf1c9b7535a0fd13049baf6553a38a31ca473246'
    page.canvas_courseid.should == 'Course Ids'
    page.canvas_courseid_input.set '56580000000000021,56580000000000023'
    page.canvas_save.exists?.should be true
    page.canvas_close.exists?.should be true
    sleep(10)
    page.canvas_save.click
    page.canvas_close.click
    sleep(10)
    page.data_tool.click
    page.data_source.click
    sleep(10)
    page.start_btn.wait_until_present
     page.start_btn.click
    sleep(5)
    page.canvas_status.should == 'Status: Running'

  end
end
Then(/^click data tools tab$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.data_tool.wait_until_present
    page.data_tool.click
    page.data_tool_element.exists?.should be true
  end
end

And(/^Verify the tools added Tableau and CSV$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.tableau_image.wait_until_present
    page.tableau_image.exists?.should be true
    page.action_info.exists?.should be true
    page.csv_image.exists?.should be true
    page.export_btn.exists?.should be true
  end
end

And(/^Verify the elements in Tableau and CSV Tools$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.tools_header1.should == 'Data Tool Name'
    page.tools_header2.should == 'Actions'
    page.csv_name.should == 'CSV Download'
    page.export_btn.click
    sleep(10)
    page.csv_control.should == 'CSV Download Controls'
    page.csv_control1.should == 'Select the data you want to export and download'
    reports = ['Canvas_Quiz_Submission_Table','Canvas_Course_Section_Table','Canvas_Enrollments_Table','Canvas_User_Profile_Table','Canvas_Assignment_Submission_Table','Canvas_Student_Activity_Table','Smarter_Measure_Table']
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
    sleep(15)
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
  end
  end
And(/^Verify the elements in Tableau and CSV Tools\-Moodle$/) do
  on IntellifyEssentialDatatoolsPage do |page|
    page.tools_header1.should == 'Data Tool Name'
    page.tools_header2.should == 'Actions'
    page.csv_name.should == 'CSV Download'
    page.export_btn.click
    sleep(5)
    page.csv_control.should == 'CSV Download Controls'
    page.csv_control1.should == 'Select the data you want to export and download'
    reports = ['Moodle_Student_Enrollments_Table','Moodle_User_Table','Moodle_Student_Activity_Table','Moodle_Quiz_Submission_Table','Moodle_Expanded_Student_Activity','Moodle_Course_Table']
    reports.each do |item|
      page.moodle_reports_name.text.include? item
      case item
        when 'Moodle_Student_Enrollments_Table'
          page.moodle_report(item).parent.text.include? 'This table is a list of the latest enrollment status per user for all courses. This table can be used to get a count of students enrolled in the course and to identify the role of a specific user within a course.'
          page.moodle_report(item).parent.parent.text.include? 'User Display Name, User Name, User ID, Course ID, Course Name, Course Category ID, Course Category Name, Role'
          page.moodle_report(item).parent.parent.parent.button.text.include? 'Download'
          @browser.execute_script('arguments[0].scrollIntoView();', page.moodle_report(item))
          @browser.send_keys :page_up
          page.moodle_report(item).parent.parent.parent.button.click
          sleep(5)
        # fail "download message not displayed" unless page.download_report_message(item).present?
        # sleep(8)
        when 'Moodle_User_Table'
          page.moodle_report(item).parent.text.include? 'This table is a list of every user that exists in your Moodle instance(s). This table can be joined to any event table, to provide additional details about a particular user, or to the enrollment table to add further context.'
          page.moodle_report(item).parent.parent.text.include? 'User Display Name, User Name, User ID, Username, User First Name, User Last Name, Email Address, City, Country, Time Zone, Description, Institution, Department, Phone Number, Mobile Phone Number, Address, Data Source, Instance, Date Created, Date Modified'
          page.moodle_report(item).parent.parent.parent.button.text.include? 'Download'
          @browser.execute_script('arguments[0].scrollIntoView();', page.moodle_report(item))
          @browser.send_keys :page_up
          page.moodle_report(item).parent.parent.parent.button.click
          sleep(5)
        # fail "download message not displayed" unless page.download_report_message(item).present?
        # sleep(8)
        when 'Moodle_Student_Activity_Table'
          page.moodle_report(item).parent.text.include? 'This table is a comprehensive log of every action that a student takes in Moodle, aside from logging in and logging out. As this table is the product of a series of joins, the primary use is monitoring and reviewing student activity. Further joining to the describe tables is possible if more in depth details are required.'
          page.moodle_report(item).parent.parent.text.include? 'Student Display Name, Student Name, Student ID, Course ID, Course Name, Action, Page, Activity Type, Activity Name, Activity ID, Data Source, Instance, Duration, Score, Max Score, Score (Percent), Date and Time, Instructor Name'
          page.moodle_report(item).parent.parent.parent.button.text.include? 'Download'
          @browser.execute_script('arguments[0].scrollIntoView();', page.moodle_report(item))
          @browser.send_keys :page_up
          page.moodle_report(item).parent.parent.parent.button.click
          sleep(5)
        # fail "download message not displayed" unless page.download_report_message(item).present?
        # sleep(8)
        when 'Moodle_Quiz_Submission_Table'
          page.moodle_report(item).parent.text.include? 'This table is a comprehensive log of every student Quiz Submission in your Moodle instance(s). This table is the product of a series of joins, providing the user with an extensive list of details for each quiz submission. Further joins are possible if additional fields are required.'
          page.moodle_report(item).parent.parent.text.include? 'Student Display Name, Student Name, Student ID, Role, Course ID, Course Name, Action, Page, Activity Type, Activity Name, Activity ID, Data Source, Instance, Duration, Score, Max Score, Score (Percent), Date and Time, Instructor Name, Weight, Attempt ID, Max Attempts, Open Quiz Date, Close Quiz Date, Competencies, Completion Tracking, Contribution To Course Total, Count, Started At Time, Ended At Time, Time Limit, Expected Completion Date, Grace Period, Overdue Handling, Restrictions, Tags, Require View, Require Grade, Grade Category, Grade Method, Grade To Pass, Visible, Grouping, Group Mode, Quiz Date Created, Quiz Date Modified'
          page.moodle_report(item).parent.parent.parent.button.text.include? 'Download'
          @browser.execute_script('arguments[0].scrollIntoView();', page.moodle_report(item))
          @browser.send_keys :page_up
          page.moodle_report(item).parent.parent.parent.button.click
          sleep(5)
        # fail "download message not displayed" unless page.download_report_message(item).present?
        # sleep(8)
        when 'Moodle_Expanded_Student_Activity'
          page.moodle_report(item).parent.text.include? 'This table is a comprehensive log of every action that a student takes in Moodle, aside from logging in and logging out. As this table is the product of a series of joins, the primary use is monitoring and reviewing student activity. Further joining to the describe tables is possible if more in depth details are required.'
          page.moodle_report(item).parent.parent.text.include? 'Student Display Name, Student Name, Student ID, Student Email Address, Course ID, Course Name, Course Category ID, Course Category Name, Action, Page, Activity Type, Activity Name, Activity ID, Attempt ID, Data Source, Instance, Duration, Score, Max Score, Score Percent, Date and Time, Instructor Name'
          page.moodle_report(item).parent.parent.parent.button.text.include? 'Download'
          @browser.execute_script('arguments[0].scrollIntoView();', page.moodle_report(item))
          @browser.send_keys :page_up
          page.moodle_report(item).parent.parent.parent.button.click
          sleep(5)
        # fail "download message not displayed" unless page.download_report_message(item).present?
        # sleep(8)
        when 'Moodle_Course_Table'
          page.moodle_report(item).parent.text.include? 'This table is a list of every course that you have specified Intellify should collect from your instance(s) of Moodle. This table can be joined to any of the event tables, to provide additional details about a particular course, or to the enrollment table to add further context.'
          page.moodle_report(item).parent.parent.text.include? 'Course Name, Course Short Name, Course ID, Course Number, Course Category ID, Course Category Name, Course Format, Course Layout, Course Visible, Course Start Date, Course End Date, Course Completion Tracking, Show Grade Book, Show Activity Reports, Group Mode, Tags, Data Source, Instance, Date Created, Date Modified'
          page.moodle_report(item).parent.parent.parent.button.text.include? 'Download'
          @browser.execute_script('arguments[0].scrollIntoView();', page.moodle_report(item))
          @browser.send_keys :page_up
          page.moodle_report(item).parent.parent.parent.button.click
          sleep(5)
        # fail "download message not displayed" unless page.download_report_message(item).present?
        # sleep(8)
      end
    end
    page.report_close.click
    sleep(5)
    page.tableau_name.should == 'Tableau Desktop Connector'
    page.info_icon.click
    sleep(5)
    page.info_header.should == 'User Guide > Setup Tableau Desktop Connector'
    page.setup_info_header.should == 'Follow the step by step instructions below to connect to the Intellify Tableau Desktop Connector:'
    page.setup_1.should == 'Download and install Tableau Desktop at https://www.tableau.com/trial/download-tableau'
    page.setup_2.should == 'Use your assigned Tableau Desktop license key to authenticate your instance of Tableau Desktop.'
    page.setup_3.should == 'Open Tableau Desktop and go to Server > More > Web Data Connector.'
    page.setup_4.should == 'Connect to the Intellify Tableau Desktop connector by adding "/apps/tableau/" to the end of your Essentials .intellify.io URL.'
    page.setup_5.should == 'Use your Intellify Essentials user credentials to login and connect to Essentials.'
    page.setup_6.should == 'Select the table you wish to load into Tableau Desktop.'
    page.help_info.should == 'Need more help? Click to see more documentation'
    page.close_btn.click
    sleep(5)
  end
end


