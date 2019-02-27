Given(/^Accessing the SRI Student Report for the (.*) using the (.*) and (.*) in the (.*) with (.*) and (.*)$/) do |studentid,siteid,classid,intelliview,key,secret|

  @hostname = configatron.hostname1
  @siteid = siteid
  @classid = classid
  @studentid = studentid
  @intelliview = intelliview
  @key = key
  @secret = secret

  visit LTIAutomationPage do |page|

    puts page.url
    page.pdfautoclick
    # page.launchUrl.exists?.should be_true
    page.launchUrl.set "https://#{@hostname}/ltilaunch/#{@intelliview}"
    page.key.set "#{@key}"
    page.secret.set "#{@secret}"
    page.cp1.set 'siteId'
    page.cpv1.set "#{@siteid}"
    page.cp2.set 'classId'
    page.cpv2.set "#{@classid}"
    page.cp3.set 'first_name'
    page.cpv3.set 'first_name'
    page.cp4.set 'last_name'
    page.cpv4.set 'last_name'
    page.cp5.set 'school_start_date'
    page.cpv5.set 'school_start_date'
    page.cp6.set 'school_end_date'
    page.cpv6.set 'school_end_date'
    page.cp7.set 'studentId'
    page.cpv7.set "#{@studentid}"

    page.ltiRefreshclick
    page.ltiLaunchclick
    sleep(20)
  end
end

Then(/^SRI Student Report  should load as expected$/) do
  on SRIStudentReport do |page|
    @s1  =   174.chr("UTF-8")
    page.date_header.exists?.should be_true
    #page.windows[0].close
    page.header.should == "Lexile#{@s1} Proficiency and Growth Report"
    sleep(5)
    page.classname.should == 'Aaron Able'
    page.printicon.exists?.should be_true
    page.readinginventoryimg.exists?.should be_true
    page.daterange.exists?.should be_true
  end
end

Then(/^SRI Student report Summary Section should display as expected$/) do
  on SRIStudentReport do |page|
    sleep(5)
    page.summary_header.exists?.should be_true
    page.summary_dis.exists?.should be_true
    page.summary_val1.exists?.should be_true
    page.summary_dis1.exists?.should be_true
    page.summary_val2.exists?.should be_true
    page.summary_dis2.exists?.should be_true
    page.summary_val3.exists?.should be_true
    page.summary_dis3.exists?.should be_true
  end
end

Then(/^SRI Student report line Chart Section should display as expected$/) do
  on SRIStudentReport do |page|
    page.line_chart.exists?.should be_true
    page.chart_header.exists?.should be_true
  end
end

Then(/^SRI Student report line Chart Image Display as expected$/) do
  on SRIStudentReport do |page|
    page.tool_tip1.exists?.should be_true
    page.tool_tip2.exists?.should be_true
    page.tool_tip3.exists?.should be_true
    page.tool_tip4.exists?.should be_true
  end
end

Then(/^SRI Student report Table Group Header Section should display as expected$/) do
  on SRIStudentReport do |page|
    page.group_header.exists?.should be_true
    page.group_header2.exists?.should be_true
  end
end

Then(/^SRI Student report Table Header Section should display as expected$/) do
  on SRIStudentReport do |page|
    @s1  =   174.chr("UTF-8")
    page.table_header1(0,0).should == "Date"
    page.table_header(1,0).should =='Grade'
    page.table_header(2,0).should =="Lexile#{@s1}"
    page.table_header(3,0).should =='Level'
    page.table_header(4,0).should =='Elapsed Test Time'
    page.table_header(10,0).should =='Percentile Rank'
    page.table_header(11,0).should =='Stanine'
    page.table_header(12,0).should =='NCE'
  end
end

Then(/^SRI Student report Table Values should display as expected for all the Students in the Class$/) do
  on SRIStudentReport do |page|
    #row1
    page.table_cell(0,0).should == '1/5/16'
    page.table_cell(0,1).should == '6'
    page.table_cell(0,2).should == '1326'
    page.table_cell(0,3).should == 'Advanced'
    page.table_cell(0,4).should == '26 min.'
    page.table_cell(0,10).should == '99'
    page.table_cell(0,11).should == '9'
    page.table_cell(0,12).should == '99'
    #row2
    page.table_cell(1,0).should == '12/18/15'
    page.table_cell(1,1).should == '6'
    page.table_cell(1,2).should == '1206'
    page.table_cell(1,3).should == 'Advanced'
    page.table_cell(1,4).should == '22 min.'
    page.table_cell(1,10).should == '94'
    page.table_cell(1,11).should == '8'
    page.table_cell(1,12).should == '83'
    #row3
    page.table_cell(2,0).should == '12/17/15'
    page.table_cell(2,1).should == '6'
    page.table_cell(2,2).should == '1143'
    page.table_cell(2,3).should == 'Advanced'
    page.table_cell(2,4).should == '45 min.'
    page.table_cell(2,10).should == '89'
    page.table_cell(2,11).should == '8'
    page.table_cell(2,12).should == '76'
    page.date_header.exists?.should be_true
    page.clockicon.exists?.should be_true
  end
end

Then(/^SRI Student report Verify the Date range Filter$/) do
  on SRIStudentReport do |page|
    page.daterange.exists?.should be_true
  end
end

Then(/^SRI Student report Verify the Reset icon$/) do
  on SRIStudentReport do |page|
    page.element(:xpath=>"//span[1]/a").exists?.should be_true
  end
end

When(/^SRI Student report provide the Date range$/) do
  on SRIStudentReport do |page|
    page.daterange.click
    page.startdate.set '12/1/15'
    page.enddate.set '12/31/15'
    page.send_keys :enter
    page.apply.click
    sleep(20)
  end
end

Then(/^SRI Student report Verify the Class data with date range$/) do
  on SRIStudentReport do |page|
    page.summary_date_val1.exists?.should be_true
    page.summary_date_val2.exists?.should be_true
    page.summary_date_val3.exists?.should be_true
    page.date_header.exists?.should be_true
    page.clockicon.exists?.should be_true
    #row1
    page.table_cell(0,0).should == '12/18/15'
    page.table_cell(0,1).should == '6'
    page.table_cell(0,2).should == '1206'
    page.table_cell(0,3).should == 'Advanced'
    page.table_cell(0,4).should == '22 min.'
    page.table_cell(0,10).should == '94'
    page.table_cell(0,11).should == '8'
    page.table_cell(0,12).should == '83'
    #row2
    page.table_cell(1,0).should == '12/17/15'
    page.table_cell(1,1).should == '6'
    page.table_cell(1,2).should == '1143'
    page.table_cell(1,3).should == 'Advanced'
    page.table_cell(1,4).should == '45 min.'
    page.table_cell(1,10).should == '89'
    page.table_cell(1,11).should == '8'
    page.table_cell(1,12).should == '76'
  end
end

When(/^SRI Student report Click on the reset icon$/) do
  on SRIStudentReport do |page|
    page.element(:xpath=>"//span[1]/a").click
    sleep(20)
  end
end

Then(/^SRI Student report Verify the Class data without date range$/) do
  on SRIStudentReport do |page|
    page.date_header.exists?.should be_true
    page.clockicon.exists?.should be_true
    #row1
    page.table_cell(0,0).should == '1/5/16'
    page.table_cell(0,1).should == '6'
    page.table_cell(0,2).should == '1326'
    page.table_cell(0,3).should == 'Advanced'
    page.table_cell(0,4).should == '26 min.'
    page.table_cell(0,10).should == '99'
    page.table_cell(0,11).should == '9'
    page.table_cell(0,12).should == '99'
    #row2
    page.table_cell(1,0).should == '12/18/15'
    page.table_cell(1,1).should == '6'
    page.table_cell(1,2).should == '1206'
    page.table_cell(1,3).should == 'Advanced'
    page.table_cell(1,4).should == '22 min.'
    page.table_cell(1,10).should == '94'
    page.table_cell(1,11).should == '8'
    page.table_cell(1,12).should == '83'
    #row3
    page.table_cell(2,0).should == '12/17/15'
    page.table_cell(2,1).should == '6'
    page.table_cell(2,2).should == '1143'
    page.table_cell(2,3).should == 'Advanced'
    page.table_cell(2,4).should == '45 min.'
    page.table_cell(2,10).should == '89'
    page.table_cell(2,11).should == '8'
    page.table_cell(2,12).should == '76'

  end
end