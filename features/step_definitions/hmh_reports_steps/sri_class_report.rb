Given(/^Accessing the SRI Class Report using the (.*) and (.*) in the (.*) with (.*) and (.*)$/) do |siteid,classid,intelliview,key,secret|

  @hostname = configatron.hostname1
  @siteid = siteid
  @classid = classid
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

    page.ltiRefreshclick
    page.ltiLaunchclick
  end

end

Then(/^SRI Class Report should load as expected$/) do

  on SRIClassReport do |page|
    @s1  =   174.chr("UTF-8")
    page.average.exists?.should be_true
    page.header.should == "Lexile#{@s1} Proficiency and Growth Report"
    page.classname.should == 'Tribbles'
    page.printicon.exists?.should be_true
    page.readinginventoryimg.exists?.should be_true
    page.daterange.exists?.should be_true
  end

end

Then(/^SRI Class report Summary Section should display as expected$/) do
  on SRIClassReport do |page|
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

Then(/^SRI Class report Row Chart Section should display as expected$/) do
  on SRIClassReport do |page|
    page.chart_header.exists?.should be_true
    page.firsttest_header.exists?.should be_true
    page.lasttest_header.exists?.should be_true
  end
end

Then(/^SRI Class report Row Chart Image Display as expected$/) do
  on SRIClassReport do |page|
    page.chart_first.exists?.should be_true
    page.chart_last.exists?.should be_true
    page.tool_tip1.exists?.should be_true
    page.tool_tip2.exists?.should be_true
    page.tool_tip3.exists?.should be_true
    page.tool_tip4.exists?.should be_true
    page.tool_tip5.exists?.should be_true
  end
end

Then(/^SRI Class report Table Group Header Section should display as expected$/) do
  on SRIClassReport do |page|
    page.group_header_attemptfirst.exists?.should be_true
    page.group_header_attemptlast.exists?.should be_true
    page.growth_header.exists?.should be_true
  end
end

Then(/^SRI Class report Table Header Section should display as expected$/) do
  on SRIClassReport do |page|
    @s1  =   174.chr("UTF-8")
    page.table_header1(0,0).should == 'Student'
    page.table_header(3,0).should == 'Grade'
    page.table_header(4,0).should == 'Date'
    page.table_header(5,0).should == "Lexile#{@s1}"
    page.table_header(7,0).should == 'Level'
    page.table_header(15,0).should == 'Date'
    page.table_header(16,0).should == "Lexile#{@s1}"
    page.table_header(18,0).should == 'Level'
    page.table_header(38,0).should == 'Expected'
    page.table_header(39,0).should == 'Actual'
  end
end

Then(/^SRI Class report Table Values should display as expected for all the Students in the Class$/) do
  on SRIClassReport do |page|
    @s2  =   8212.chr("UTF-8")
    #studentname:Dummy, Doofus
    page.table_cell(0,0).should =='Dummy, Doofus'
    page.table_cell(0,3).should =='7'
    page.table_cell(0,4).should =='2/17/16'
    page.table_cell(0,5).should =='BR(53)'
    page.table_cell(0,7).should =='Below Basic'
    page.table_cell(0,15).should =="#{@s2}"
    page.table_cell(0,16).should =="#{@s2}"
    page.table_cell(0,18).should =="#{@s2}"
    page.table_cell(0,38).should =='220-350'
    page.table_cell(0,39).should =='N/A'
    #studentname:Eager, Eddie
    page.table_cell(1,0).should =='Eager, Eddie'
    page.table_cell(1,3).should =='5'
    page.table_cell(1,4).should =='12/18/15'
    page.table_cell(1,5).should =='453'
    page.table_cell(1,7).should =='Below Basic'
    page.table_cell(1,15).should =='2/2/16'
    page.table_cell(1,16).should =='359'
    page.table_cell(1,18).should =='Below Basic'
    page.table_cell(1,38).should =='130-180'
    page.table_cell(1,39).should =='No Growth'
    #studentname:Early, Elvis
    page.table_cell(2,0).should =='Early, Elvis'
    page.table_cell(2,3).should =='11'
    page.table_cell(2,4).should =="#{@s2}"
    page.table_cell(2,5).should =="#{@s2}"
    page.table_cell(2,7).should =="#{@s2}"
    page.table_cell(2,15).should =="#{@s2}"
    page.table_cell(2,16).should =="#{@s2}"
    page.table_cell(2,18).should =="#{@s2}"
    page.table_cell(2,38).should =="#{@s2}"
    page.table_cell(2,39).should =='N/A'
    #studentname:Failure, Fred
    page.table_cell(3,0).should =='Failure, Fred'
    page.table_cell(3,3).should =='7'
    page.table_cell(3,4).should =="#{@s2}"
    page.table_cell(3,5).should =="#{@s2}"
    page.table_cell(3,7).should =="#{@s2}"
    page.table_cell(3,15).should =="#{@s2}"
    page.table_cell(3,16).should =="#{@s2}"
    page.table_cell(3,18).should =="#{@s2}"
    page.table_cell(3,38).should =="#{@s2}"
    page.table_cell(3,39).should =='N/A'
    #studentname:irtest1, irtest1
    page.table_cell(4,0).should =='irtest1, irtest1'
    page.table_cell(4,3).should =='2'
    page.table_cell(4,4).should =="#{@s2}"
    page.table_cell(4,5).should =="#{@s2}"
    page.table_cell(4,7).should =="#{@s2}"
    page.table_cell(4,15).should =="#{@s2}"
    page.table_cell(4,16).should =="#{@s2}"
    page.table_cell(4,18).should =="#{@s2}"
    page.table_cell(4,38).should =='N/A'
    page.table_cell(4,39).should =='N/A'
    #studentname:Nevertake, Nancy
    page.table_cell(5,0).should =='Nevertake, Nancy'
    page.table_cell(5,3).should =='6'
    page.table_cell(5,4).should =="#{@s2}"
    page.table_cell(5,5).should =="#{@s2}"
    page.table_cell(5,7).should =="#{@s2}"
    page.table_cell(5,15).should =="#{@s2}"
    page.table_cell(5,16).should =="#{@s2}"
    page.table_cell(5,18).should =="#{@s2}"
    page.table_cell(5,38).should =="#{@s2}"
    page.table_cell(5,39).should =='N/A'
    #studentname:Nevertake, Ned
    page.table_cell(6,0).should =='Nevertake, Ned'
    page.table_cell(6,3).should =='6'
    page.table_cell(6,4).should =="#{@s2}"
    page.table_cell(6,5).should =="#{@s2}"
    page.table_cell(6,7).should =="#{@s2}"
    page.table_cell(6,15).should =="#{@s2}"
    page.table_cell(6,16).should =="#{@s2}"
    page.table_cell(6,18).should =="#{@s2}"
    page.table_cell(6,38).should =="#{@s2}"
    page.table_cell(6,39).should =='N/A'
    #studentname:Onetake, Ollie
    page.table_cell(7,0).should =='Onetake, Ollie'
    page.table_cell(7,3).should =='5'
    page.table_cell(7,4).should =='12/17/15'
    page.table_cell(7,5).should =='569'
    page.table_cell(7,7).should =='Below Basic'
    page.table_cell(7,15).should == '2/13/16'
    page.table_cell(7,16).should == '511'
    page.table_cell(7,18).should == 'Below Basic'
    page.table_cell(7,38).should == '105-155'
    page.table_cell(7,39).should =='No Growth'
    #studentname:Sally, Silly
    page.table_cell(8,0).should =='Sally, Silly'
    page.table_cell(8,3).should =='6'
    page.table_cell(8,4).should =='2/17/16'
    page.table_cell(8,5).should =='BR'
    page.table_cell(8,7).should =='Below Basic'
    page.table_cell(8,15).should =="#{@s2}"
    page.table_cell(8,16).should =="#{@s2}"
    page.table_cell(8,18).should =="#{@s2}"
    page.table_cell(8,38).should =='205-315'
    page.table_cell(8,39).should =='N/A'
    #studentname:Twelver, Trina
    page.table_cell(9,0).should =='Twelver, Trina'
    page.table_cell(9,3).should =='12'
    page.table_cell(9,4).should =='2/13/16'
    page.table_cell(9,5).should =='974'
    page.table_cell(9,7).should =='Below Basic'
    page.table_cell(9,15).should =="#{@s2}"
    page.table_cell(9,16).should =="#{@s2}"
    page.table_cell(9,18).should =="#{@s2}"
    page.table_cell(9,38).should =='40-70'
    page.table_cell(9,39).should =='N/A'
    #studentname:Yak, Yellow
    page.table_cell(10,0).should =='Yak, Yellow'
    page.table_cell(10,3).should =='5'
    page.table_cell(10,4).should =='1/26/16'
    page.table_cell(10,5).should =='639'
    page.table_cell(10,7).should =='Basic'
    page.table_cell(10,15).should =='2/3/16'
    page.table_cell(10,16).should =='526'
    page.table_cell(10,18).should =='Below Basic'
    page.table_cell(10,38).should =='85-130'
    page.table_cell(10,39).should =='No Growth'
    #studentname:Zillo, Zeke
    page.table_cell(11,0).should =='Zillo, Zeke'
    page.table_cell(11,3).should =='6'
    page.table_cell(11,4).should =='1/27/16'
    page.table_cell(11,5).should =='785'
    page.table_cell(11,7).should =='Basic'
    page.table_cell(11,15).should =="#{@s2}"
    page.table_cell(11,16).should =="#{@s2}"
    page.table_cell(11,18).should =="#{@s2}"
    page.table_cell(11,38).should =='45-75'
    page.table_cell(11,39).should =='N/A'
    #average row
    page.average.exists?.should be_true
    page.val1.exists?.should be_true
    page.val2.exists?.should be_true
    page.val3.exists?.should be_true
  end
end

Then(/^SRI Class report Verify the Date range Filter$/) do
  on SRIClassReport do |page|
    page.daterange.exists?.should be_true
  end
end

Then(/^SRI Class report Verify the Reset icon$/) do
  on SRIClassReport do |page|
    page.element(:xpath=>"//span[1]/a").exists?.should be_true
  end
end

When(/^SRI Class report provide the Date range$/) do
  on SRIClassReport do |page|
    page.daterange.click
    page.startdate.set '1/1/16'
    page.enddate.set '2/16/16'
    page.send_keys :enter
    page.apply.click
    sleep(20)
  end
end

Then(/^SRI Class report Verify the Class data with date range$/) do
  on SRIClassReport do |page|
    @s2  =   8212.chr("UTF-8")
    page.summary_val1.exists?.should be_true
    page.summary_val2.exists?.should be_true
    page.summary_date_val3.exists?.should be_true
    #studentname:Dummy, Doofus
    page.table_cell(0,0).should =='Dummy, Doofus'
    page.table_cell(0,3).should =='7'
    page.table_cell(0,4).should =="#{@s2}"
    page.table_cell(0,5).should =="#{@s2}"
    page.table_cell(0,7).should =="#{@s2}"
    page.table_cell(0,15).should =="#{@s2}"
    page.table_cell(0,16).should =="#{@s2}"
    page.table_cell(0,18).should =="#{@s2}"
    page.table_cell(0,38).should =="#{@s2}"
    page.table_cell(0,39).should =='N/A'
    #studentname:Eager, Eddie
    page.table_cell(1,0).should =='Eager, Eddie'
    page.table_cell(1,3).should =='5'
    page.table_cell(1,4).should =='2/2/16'
    page.table_cell(1,5).should =='359'
    page.table_cell(1,7).should =='Below Basic'
    page.table_cell(1,15).should =="#{@s2}"
    page.table_cell(1,16).should =="#{@s2}"
    page.table_cell(1,18).should =="#{@s2}"
    page.table_cell(1,38).should =='155-215'
    page.table_cell(1,39).should == 'N/A'
    #studentname:Early, Elvis
    page.table_cell(2,0).should =='Early, Elvis'
    page.table_cell(2,3).should =='11'
    page.table_cell(2,4).should =="#{@s2}"
    page.table_cell(2,5).should =="#{@s2}"
    page.table_cell(2,7).should =="#{@s2}"
    page.table_cell(2,15).should =="#{@s2}"
    page.table_cell(2,16).should =="#{@s2}"
    page.table_cell(2,18).should =="#{@s2}"
    page.table_cell(2,38).should =="#{@s2}"
    page.table_cell(2,39).should =='N/A'
    #studentname:Failure, Fred
    page.table_cell(3,0).should =='Failure, Fred'
    page.table_cell(3,3).should =='7'
    page.table_cell(3,4).should =="#{@s2}"
    page.table_cell(3,5).should =="#{@s2}"
    page.table_cell(3,7).should =="#{@s2}"
    page.table_cell(3,15).should =="#{@s2}"
    page.table_cell(3,16).should =="#{@s2}"
    page.table_cell(3,18).should =="#{@s2}"
    page.table_cell(3,38).should =="#{@s2}"
    page.table_cell(3,39).should =='N/A'
    #studentname:irtest1, irtest1
    page.table_cell(4,0).should =='irtest1, irtest1'
    page.table_cell(4,3).should =='2'
    page.table_cell(4,4).should =="#{@s2}"
    page.table_cell(4,5).should =="#{@s2}"
    page.table_cell(4,7).should =="#{@s2}"
    page.table_cell(4,15).should =="#{@s2}"
    page.table_cell(4,16).should =="#{@s2}"
    page.table_cell(4,18).should =="#{@s2}"
    page.table_cell(4,38).should =='N/A'
    page.table_cell(4,39).should =='N/A'
    #studentname:Nevertake, Nancy
    page.table_cell(5,0).should =='Nevertake, Nancy'
    page.table_cell(5,3).should =='6'
    page.table_cell(5,4).should =="#{@s2}"
    page.table_cell(5,5).should =="#{@s2}"
    page.table_cell(5,7).should =="#{@s2}"
    page.table_cell(5,15).should =="#{@s2}"
    page.table_cell(5,16).should =="#{@s2}"
    page.table_cell(5,18).should =="#{@s2}"
    page.table_cell(5,38).should =="#{@s2}"
    page.table_cell(5,39).should =='N/A'
    #studentname:Nevertake, Ned
    page.table_cell(6,0).should =='Nevertake, Ned'
    page.table_cell(6,3).should =='6'
    page.table_cell(6,4).should =="#{@s2}"
    page.table_cell(6,5).should =="#{@s2}"
    page.table_cell(6,7).should =="#{@s2}"
    page.table_cell(6,15).should =="#{@s2}"
    page.table_cell(6,16).should =="#{@s2}"
    page.table_cell(6,18).should =="#{@s2}"
    page.table_cell(6,38).should =="#{@s2}"
    page.table_cell(6,39).should =='N/A'
    #studentname:Onetake, Ollie
    page.table_cell(7,0).should =='Onetake, Ollie'
    page.table_cell(7,3).should =='5'
    page.table_cell(7,4).should =='2/13/16'
    page.table_cell(7,5).should =='511'
    page.table_cell(7,7).should =='Below Basic'
    page.table_cell(7,15).should == "#{@s2}"
    page.table_cell(7,16).should == "#{@s2}"
    page.table_cell(7,18).should == "#{@s2}"
    page.table_cell(7,38).should == '105-155'
    page.table_cell(7,39).should =='N/A'
    #studentname:Sally, Silly
    page.table_cell(8,0).should =='Sally, Silly'
    page.table_cell(8,3).should =='6'
    page.table_cell(8,4).should =="#{@s2}"
    page.table_cell(8,5).should =="#{@s2}"
    page.table_cell(8,7).should =="#{@s2}"
    page.table_cell(8,15).should =="#{@s2}"
    page.table_cell(8,16).should =="#{@s2}"
    page.table_cell(8,18).should =="#{@s2}"
    page.table_cell(8,38).should =="#{@s2}"
    page.table_cell(8,39).should =='N/A'
    #studentname:Twelver, Trina
    page.table_cell(9,0).should =='Twelver, Trina'
    page.table_cell(9,3).should =='12'
    page.table_cell(9,4).should =='2/13/16'
    page.table_cell(9,5).should =='974'
    page.table_cell(9,7).should =='Below Basic'
    page.table_cell(9,15).should =="#{@s2}"
    page.table_cell(9,16).should =="#{@s2}"
    page.table_cell(9,18).should =="#{@s2}"
    page.table_cell(9,38).should =='40-70'
    page.table_cell(9,39).should =='N/A'
    #studentname:Yak, Yellow
    page.table_cell(10,0).should =='Yak, Yellow'
    page.table_cell(10,3).should =='5'
    page.table_cell(10,4).should =='1/26/16'
    page.table_cell(10,5).should =='639'
    page.table_cell(10,7).should =='Basic'
    page.table_cell(10,15).should =='2/3/16'
    page.table_cell(10,16).should =='526'
    page.table_cell(10,18).should =='Below Basic'
    page.table_cell(10,38).should =='85-130'
    page.table_cell(10,39).should =='No Growth'
    #studentname:Zillo, Zeke
    page.table_cell(11,0).should =='Zillo, Zeke'
    page.table_cell(11,3).should =='6'
    page.table_cell(11,4).should =='1/27/16'
    page.table_cell(11,5).should =='785'
    page.table_cell(11,7).should =='Basic'
    page.table_cell(11,15).should =="#{@s2}"
    page.table_cell(11,16).should =="#{@s2}"
    page.table_cell(11,18).should =="#{@s2}"
    page.table_cell(11,38).should =='45-75'
    page.table_cell(11,39).should =='N/A'
    #average row
    page.average.exists?.should be_true
    page.date_val1.exists?.should be_true
    page.date_val2.exists?.should be_true
    page.val3.exists?.should be_true
  end
end

When(/^SRI Class report Click on the reset icon$/) do
  on SRIClassReport do |page|
    page.element(:xpath=>"//span[1]/a").click
    sleep(20)
  end
end

Then(/^SRI Class report Verify the Class data without date range$/) do
  on SRIClassReport do |page|
    page.average.exists?.should be_true
    page.val1.exists?.should be_true
    page.val2.exists?.should be_true
    page.val3.exists?.should be_true
  end
end