Given(/^Accessing the R180U Student Report for the (.*) using the (.*) and (.*) in the (.*) with (.*) and (.*)$/) do |studentid,siteid,classid,intelliview,key,secret|

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
  end
end

Then(/^The R180U Student Report should load as expected$/) do
  on R180UStudentReport do |page|
  page.segmentaverage.exists?.should be_true
  end
end

Then(/^R180U Student report header should display as expected$/) do
  on R180UStudentReport do |page|
    page.classname.exists?.should be_true
    page.printicon.exists?.should be_true
    page.read180img.exists?.should be_true
    page.header.exists?.should be_true
  end
  end

Then(/^R180U Student report Summary Section should display as expected$/) do
  on R180UStudentReport do |page|
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

Then(/^R180U Student report Bar Chart Section should display as expected$/) do
  on R180UStudentReport do |page|
    page.chart_header.exists?.should be_true
    page.bar_chart_tooltip.exists?.should be_true
    page.bar_chart_tooltip2.exists?.should be_true

    end
end

Then(/^R180U Student report Bar Chart Image Display as expected$/) do
  on R180UStudentReport do |page|
   page.bar_chart.exists?.should be_true
    end
end

Then(/^R180U Student report Table Group Header Section should display as expected$/) do
  on R180UStudentReport do |page|
  page.group_header_imp.exists?.should be_true
  page.table_header_stu.exists?.should be_true
  end
  end

Then(/^R180U Student report Table Header Section should display as expected$/) do
  on R180UStudentReport do |page|
  page.segment.exists?.should be_true
  page.level.exists?.should be_true
  page.date_start.exists?.should be_true
  page.date_completed.exists?.should be_true
  page.averagessw.exists?.should be_true
  page.explore.exists?.should be_true
  page.reading.exists?.should be_true
  page.language.exists?.should be_true
  page.word.exists?.should be_true
  page.spelling.exists?.should be_true
  page.success.exists?.should be_true
  end
  end

Then(/^R180U Student report Table Values should display as expected for the Students$/) do
  on R180UStudentReport do |page|
  @s2  =   8212.chr("UTF-8")
  #segmentname:Brain Power
  page.table_cell(1,0).should == 'Brain Power'
  page.table_cell(1,1).should == '6'
  page.table_cell(1,2).should == '2/1/16'
  page.table_cell(1,3).should == "#{@s2}"
  page.table_cell(1,4).should == '5'
  page.table_cell(1,5).should == '75%'
  page.table_cell(1,6).should == "#{@s2}"
  page.table_cell(1,7).should == "#{@s2}"
  page.table_cell(1,8).should == "#{@s2}"
  page.table_cell(1,9).should == "#{@s2}"
  page.table_cell(1,10).should == "#{@s2}"
  #segmentname:Mindset Matters
  page.table_cell(2,0).should == 'Mindset Matters'
  page.table_cell(2,1).should == '6'
  page.table_cell(2,2).should == '1/25/16'
  page.table_cell(2,3).should == '2/1/16'
  page.table_cell(2,4).should == '3'
  page.table_cell(2,5).should == '50%'
  page.table_cell(2,6).should == '30%'
  page.table_cell(2,7).should == '75%'
  page.table_cell(2,8).should == '80%'
  page.table_cell(2,9).should == '81%'
  page.table_cell(2,10).should == '100%'
  #average row
  page.val1.exists?.should be_true
  page.val2.exists?.should be_true
  page.val3.exists?.should be_true
  page.val4.exists?.should be_true
  page.val5.exists?.should be_true
  page.val6.exists?.should be_true
  page.val7.exists?.should be_true
  page.val8.exists?.should be_true
end
end

Then(/^R180U Student report Verify the Date range Filter$/) do
  on R180UStudentReport do |page|
  page.daterange.exists?.should be_true
  end
  end

Then(/^R180u Student report Verify the Reset icon$/) do
  on R180UStudentReport do |page|
  page.element(:xpath=>"//span[1]/a").exists?.should be_true
  end
  end

When(/^R180U Student report provide the Date range$/) do
  on R180UStudentReport do |page|
  page.daterange.click
  page.startdate.set '1/1/16'
  page.enddate.set '1/27/16'
  page.send_keys :enter
  page.apply.click
  sleep(20)
  end
  end

Then(/^R180U Student report Verify the student data with date range$/) do
  on R180UStudentReport do |page|
    @s2  =   8212.chr("UTF-8")
  #segmentname:Mindset Matters
  page.table_cell(1,0).should == 'Mindset Matters'
  page.table_cell(1,1).should == '6'
  page.table_cell(1,2).should == '1/25/16'
  page.table_cell(1,3).should == "#{@s2}"
  page.table_cell(1,4).should == '1'
  page.table_cell(1,5).should == '50%'
  page.table_cell(1,6).should == '30%'
  page.table_cell(1,7).should == '100%'
  page.table_cell(1,8).should == '80%'
  page.table_cell(1,9).should == '75%'
  page.table_cell(1,10).should == "#{@s2}"
  #average row
    page.date_val1.exists?.should be_true
    page.date_val2.exists?.should be_true
    page.date_val3.exists?.should be_true
    page.date_val4.exists?.should be_true
    page.date_val5.exists?.should be_true
    page.date_val6.exists?.should be_true
    page.date_val7.exists?.should be_true
end
end
When(/^R180U Student report Click on the reset icon$/) do
  on R180UStudentReport do |page|
  page.element(:xpath=>"//span[1]/a").click
  sleep(20)
end
end
Then(/^R180U Student report Verify the student data without date range$/) do
  on R180UStudentReport do |page|
    page.val1.exists?.should be_true
    page.val2.exists?.should be_true
    page.val3.exists?.should be_true
    page.val4.exists?.should be_true
    page.val5.exists?.should be_true
    page.val6.exists?.should be_true
    page.val7.exists?.should be_true
    page.val8.exists?.should be_true
  end
  end