Given(/^Accessing the R180U Class Report using the (.*) and (.*) in the (.*) with (.*) and (.*)$/) do |siteid,classid,intelliview,key,secret|


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

Then(/^R180U Class report header should display as expected$/) do

  on R180UClassReport do |page|
    page.header.exists?.should be_true
    page.classname.exists?.should be_true
    page.printicon.exists?.should be_true
#    page.reset.exists?.should be_true
    page.read180img.exists?.should be_true
#

  end
end


Then(/^R180U Class report Summary Section should display as expected$/) do
  on R180UClassReport do |page|

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

Then(/^R180U Class report Line Chart Section should display as expected$/) do
  on R180UClassReport do |page|

    page.chart_header.exists?.should be_true
  end
end

Then(/^R180U Class report Line Chart Image Display as expected$/) do
  on R180UClassReport do |page|
    page.minuteheader.exists?.should be_true
  end
end

Then(/^R180U Class report Table Group Header Section should display as expected$/) do
  on R180UClassReport do |page|

    page.group_header_imp.exists?.should be_true

  end
end

Then(/^R180U Class report Table Header Section should display as expected$/) do
  on R180UClassReport do |page|

    page.table_header_stu.exists?.should be_true
    page.level.exists?.should be_true
    page.session.exists?.should be_true
    page.segments.exists?.should be_true
    page.time.exists?.should be_true
    page.averagessm.exists?.should be_true
    page.averagessw.exists?.should be_true
    page.explore.exists?.should be_true
    page.reading.exists?.should be_true
    page.language.exists?.should be_true
    page.word.exists?.should be_true
    page.spelling.exists?.should be_true
    page.success.exists?.should be_true
  end
end

Then(/^R180U Class report Table Values should display as expected for all the Students in the Class$/) do
  on R180UClassReport do |page|
    @studentname = "Kanaghederdauhauliah, O'Mally"
    @s2  =   8212.chr("UTF-8")
    #student name:Annunziata, Chauntriceller
    page.average.exists?.should be_true
    page.table_cell(0,0).should == 'Annunziata, Chauntriceller'
    page.table_cell(0,1).should == '6'
    page.table_cell(0,2).should == '7'
    page.table_cell(0,3).should == '1'
    page.table_cell(0,4).should == '216'
    page.table_cell(0,5).should == '31'
    page.table_cell(0,6).should == '2'
    page.table_cell(0,11).should == '63%'
    page.table_cell(0,12).should == '30%'
    page.table_cell(0,13).should == '75%'
    page.table_cell(0,14).should == '80%'
    page.table_cell(0,15).should == '81%'
    page.table_cell(0,16).should == '100%'
     #student name:Baby, Bunny
    page.table_cell(1,0).should == 'Baby, Bunny'
    page.table_cell(1,1).should == '1'
    page.table_cell(1,2).should == '2'
    page.table_cell(1,3).should == "#{@s2}"
    page.table_cell(1,4).should == '29'
    page.table_cell(1,5).should == '15'
    page.table_cell(1,6).should == '1'
    page.table_cell(1,11).should == "#{@s2}"
    page.table_cell(1,12).should == "#{@s2}"
    page.table_cell(1,13).should == '100%'
    page.table_cell(1,14).should == "#{@s2}"
    page.table_cell(1,15).should == '65%'
    page.table_cell(1,16).should == "#{@s2}"
     #student name:Caine, Kain
    page.table_cell(2,0).should == 'Caine, Kain'
    page.table_cell(2,1).should == '6'
    page.table_cell(2,2).should == '1'
    page.table_cell(2,3).should == "#{@s2}"
    page.table_cell(2,4).should == "#{@s2}"
    page.table_cell(2,5).should == "#{@s2}"
    page.table_cell(2,6).should == '1'
    page.table_cell(2,11).should == "#{@s2}"
    page.table_cell(2,12).should == '100%'
    page.table_cell(2,13).should == '100%'
    page.table_cell(2,14).should == "#{@s2}"
    page.table_cell(2,15).should == "#{@s2}"
    page.table_cell(2,16).should == "#{@s2}"
     #student name:Chu, Amy
    page.table_cell(3,0).should == 'Chu, Amy'
    page.table_cell(3,1).should == '1'
    page.table_cell(3,2).should == '5'
    page.table_cell(3,3).should == "#{@s2}"
    page.table_cell(3,4).should == '126'
    page.table_cell(3,5).should == '25'
    page.table_cell(3,6).should == '3'
    page.table_cell(3,11).should == '0%'
    page.table_cell(3,12).should == '67%'
    page.table_cell(3,13).should == "#{@s2}"
    page.table_cell(3,14).should == "#{@s2}"
    page.table_cell(3,15).should == '70%'
    page.table_cell(3,16).should == "#{@s2}"
     #student name:Chu, Amy
    page.table_cell(4,0).should == 'Chu, Amy'
    page.table_cell(4,1).should == '1'
    page.table_cell(4,2).should == '4'
    page.table_cell(4,3).should == "#{@s2}"
    page.table_cell(4,4).should == '291'
    page.table_cell(4,5).should == '73'
    page.table_cell(4,6).should == '1'
    page.table_cell(4,11).should == '33%'
    page.table_cell(4,12).should == '87%'
    page.table_cell(4,13).should == '91%'
    page.table_cell(4,14).should == '100%'
    page.table_cell(4,15).should == '100%'
    page.table_cell(4,16).should == "#{@s2}"
     #student name:Chu, Amy
    page.table_cell(5,0).should == 'Chu, Amy'
    page.table_cell(5,1).should == '1'
    page.table_cell(5,2).should == '3'
    page.table_cell(5,3).should == "#{@s2}"
    page.table_cell(5,4).should == '30'
    page.table_cell(5,5).should == '10'
    page.table_cell(5,6).should == '2'
    page.table_cell(5,11).should == '14%'
    page.table_cell(5,12).should == '80%'
    page.table_cell(5,13).should == "#{@s2}"
    page.table_cell(5,14).should == "#{@s2}"
    page.table_cell(5,15).should == "#{@s2}"
    page.table_cell(5,16).should == "#{@s2}"
     #student name:Chu, Soni
    page.table_cell(6,0).should == 'Chu, Soni'
    page.table_cell(6,1).should == '3'
    page.table_cell(6,2).should == '1'
    page.table_cell(6,3).should == "#{@s2}"
    page.table_cell(6,4).should == '37'
    page.table_cell(6,5).should == '37'
    page.table_cell(6,6).should == '1'
    page.table_cell(6,11).should == "#{@s2}"
    page.table_cell(6,12).should == '100%'
    page.table_cell(6,13).should == '100%'
    page.table_cell(6,14).should == '96%'
    page.table_cell(6,15).should == "#{@s2}"
    page.table_cell(6,16).should == "#{@s2}"
     #student name:ghosh, Amit
    page.table_cell(7,0).should == 'ghosh, Amit'
    page.table_cell(7,1).should == '4'
    page.table_cell(7,2).should == '1'
    page.table_cell(7,3).should == "#{@s2}"
    page.table_cell(7,4).should == "#{@s2}"
    page.table_cell(7,5).should == "#{@s2}"
    page.table_cell(7,6).should == '1'
    page.table_cell(7,11).should == "#{@s2}"
    page.table_cell(7,12).should == '100%'
    page.table_cell(7,13).should == '100%'
    page.table_cell(7,14).should == '100%'
    page.table_cell(7,15).should == "#{@s2}"
    page.table_cell(7,16).should == "#{@s2}"
     #student name:Jong, Kim
    page.table_cell(8,0).should == 'Jong, Kim'
    page.table_cell(8,1).should == '1'
    page.table_cell(8,2).should == '2'
    page.table_cell(8,3).should == "#{@s2}"
    page.table_cell(8,4).should == '45'
    page.table_cell(8,5).should == '22'
    page.table_cell(8,6).should == '2'
    page.table_cell(8,11).should == '71%'
    page.table_cell(8,12).should == '79%'
    page.table_cell(8,13).should == '100%'
    page.table_cell(8,14).should == "#{@s2}"
    page.table_cell(8,15).should == "#{@s2}"
    page.table_cell(8,16).should == "#{@s2}"
     #student name:Junior, Kim
    page.table_cell(9,0).should == 'Junior, Kim'
    page.table_cell(9,1).should == "#{@s2}"
    page.table_cell(9,2).should == '2'
    page.table_cell(9,3).should == "#{@s2}"
    page.table_cell(9,4).should == '78'
    page.table_cell(9,5).should == '39'
    page.table_cell(9,6).should == '1'
    page.table_cell(9,11).should == "#{@s2}"
    page.table_cell(9,12).should == "#{@s2}"
    page.table_cell(9,13).should == "#{@s2}"
    page.table_cell(9,14).should == "#{@s2}"
    page.table_cell(9,15).should == "#{@s2}"
    page.table_cell(9,16).should == "#{@s2}"
     #student name:Kanaghederdauhauliah, O'Mally
    page.table_cell(10,0).should == "#{@studentname}"
    page.table_cell(10,1).should == '6'
    page.table_cell(10,2).should == '3'
    page.table_cell(10,3).should == '1'
    page.table_cell(10,4).should == '25'
    page.table_cell(10,5).should == '8'
    page.table_cell(10,6).should == '1'
    page.table_cell(10,11).should == '35%'
    page.table_cell(10,12).should == '70%'
    page.table_cell(10,13).should == '85%'
    page.table_cell(10,14).should == '86%'
    page.table_cell(10,15).should == '43%'
    page.table_cell(10,16).should == '50%'
     #student name:Ken, Kristi
    page.table_cell(11,0).should == 'Ken, Kristi'
    page.table_cell(11,1).should == '5'
    page.table_cell(11,2).should == '1'
    page.table_cell(11,3).should == "#{@s2}"
    page.table_cell(11,4).should == "#{@s2}"
    page.table_cell(11,5).should == "#{@s2}"
    page.table_cell(11,6).should == '1'
    page.table_cell(11,11).should == "#{@s2}"
    page.table_cell(11,12).should == '100%'
    page.table_cell(11,13).should == '100%'
    page.table_cell(11,14).should == "#{@s2}"
    page.table_cell(11,15).should == "#{@s2}"
    page.table_cell(11,16).should == "#{@s2}"
     #student name:Liang, Chin
    page.table_cell(12,0).should == 'Liang, Chin'
    page.table_cell(12,1).should == '1'
    page.table_cell(12,2).should == '1'
    page.table_cell(12,3).should == "#{@s2}"
    page.table_cell(12,4).should == "#{@s2}"
    page.table_cell(12,5).should == "#{@s2}"
    page.table_cell(12,6).should == '1'
    page.table_cell(12,11).should == "#{@s2}"
    page.table_cell(12,12).should == '100%'
    page.table_cell(12,13).should == '100%'
    page.table_cell(12,14).should == "#{@s2}"
    page.table_cell(12,15).should == "#{@s2}"
    page.table_cell(12,16).should == "#{@s2}"
     #student name:LRS, Intellify
    page.table_cell(13,0).should == 'LRS, Intellify'
    page.table_cell(13,1).should == '6'
    page.table_cell(13,2).should == '1'
    page.table_cell(13,3).should == "#{@s2}"
    page.table_cell(13,4).should == "#{@s2}"
    page.table_cell(13,5).should == "#{@s2}"
    page.table_cell(13,6).should == '1'
    page.table_cell(13,11).should == '100%'
    page.table_cell(13,12).should == "#{@s2}"
    page.table_cell(13,13).should == "#{@s2}"
    page.table_cell(13,14).should == "#{@s2}"
    page.table_cell(13,15).should == "#{@s2}"
    page.table_cell(13,16).should == "#{@s2}"
     #student name:LRS, LRSpsi8
    page.table_cell(14,0).should == 'LRS, LRSpsi8'
    page.table_cell(14,1).should == '1'
    page.table_cell(14,2).should == '1'
    page.table_cell(14,3).should == "#{@s2}"
    page.table_cell(14,4).should == '155'
    page.table_cell(14,5).should == '155'
    page.table_cell(14,6).should == '1'
    page.table_cell(14,11).should == '86%'
    page.table_cell(14,12).should == '90%'
    page.table_cell(14,13).should == '97%'
    page.table_cell(14,14).should == '90%'
    page.table_cell(14,15).should == '98%'
    page.table_cell(14,16).should == '100%'
     #student name:LRS, Retest
    page.table_cell(15,0).should == 'LRS, Retest'
    page.table_cell(15,1).should == '1'
    page.table_cell(15,2).should == '1'
    page.table_cell(15,3).should == '1'
    page.table_cell(15,4).should == '4'
    page.table_cell(15,5).should == '4'
    page.table_cell(15,6).should == '1'
    page.table_cell(15,11).should == '75%'
    page.table_cell(15,12).should == '60%'
    page.table_cell(15,13).should == '92%'
    page.table_cell(15,14).should == '84%'
    page.table_cell(15,15).should == '95%'
    page.table_cell(15,16).should == '100%'
     #student name:LRS1, Intel1
    page.table_cell(16,0).should == 'LRS1, Intel1'
    page.table_cell(16,1).should == '6'
    page.table_cell(16,2).should == '1'
    page.table_cell(16,3).should == "#{@s2}"
    page.table_cell(16,4).should == '12'
    page.table_cell(16,5).should == '12'
    page.table_cell(16,6).should == '1'
    page.table_cell(16,11).should == '100%'
    page.table_cell(16,12).should == "#{@s2}"
    page.table_cell(16,13).should == "#{@s2}"
    page.table_cell(16,14).should == "#{@s2}"
    page.table_cell(16,15).should == "#{@s2}"
    page.table_cell(16,16).should == "#{@s2}"
     #student name:LRS180, student
    page.table_cell(17,0).should == 'LRS180, student'
    page.table_cell(17,1).should == "#{@s2}"
    page.table_cell(17,2).should == "#{@s2}"
    page.table_cell(17,3).should == "#{@s2}"
    page.table_cell(17,4).should == "#{@s2}"
    page.table_cell(17,5).should == "#{@s2}"
    page.table_cell(17,6).should == "#{@s2}"
    page.table_cell(17,11).should == "#{@s2}"
    page.table_cell(17,12).should == "#{@s2}"
    page.table_cell(17,13).should == "#{@s2}"
    page.table_cell(17,14).should == "#{@s2}"
    page.table_cell(17,15).should == "#{@s2}"
    page.table_cell(17,16).should == "#{@s2}"
     #student name:LRS2, Intelly2
    page.table_cell(18,0).should == 'LRS2, Intelly2'
    page.table_cell(18,1).should == '6'
    page.table_cell(18,2).should == '1'
    page.table_cell(18,3).should == "#{@s2}"
    page.table_cell(18,4).should == '11'
    page.table_cell(18,5).should == '11'
    page.table_cell(18,6).should == '1'
    page.table_cell(18,11).should == '100%'
    page.table_cell(18,12).should == '50%'
    page.table_cell(18,13).should == "#{@s2}"
    page.table_cell(18,14).should == "#{@s2}"
    page.table_cell(18,15).should == "#{@s2}"
    page.table_cell(18,16).should == "#{@s2}"
     #student name:Retest, LRS
    page.table_cell(19,0).should == 'Retest, LRS'
    page.table_cell(19,1).should == "#{@s2}"
    page.table_cell(19,2).should == "#{@s2}"
    page.table_cell(19,3).should == "#{@s2}"
    page.table_cell(19,4).should == "#{@s2}"
    page.table_cell(19,5).should == "#{@s2}"
    page.table_cell(19,6).should == "#{@s2}"
    page.table_cell(19,11).should == "#{@s2}"
    page.table_cell(19,12).should == "#{@s2}"
    page.table_cell(19,13).should == "#{@s2}"
    page.table_cell(19,14).should == "#{@s2}"
    page.table_cell(19,15).should == "#{@s2}"
    page.table_cell(19,16).should == "#{@s2}"
     #student name:Son, Suni
    page.table_cell(20,0).should == 'Son, Suni'
    page.table_cell(20,1).should == '1'
    page.table_cell(20,2).should == '1'
    page.table_cell(20,3).should == "#{@s2}"
    page.table_cell(20,4).should == '21'
    page.table_cell(20,5).should == '21'
    page.table_cell(20,6).should == '1'
    page.table_cell(20,11).should == '100%'
    page.table_cell(20,12).should == "#{@s2}"
    page.table_cell(20,13).should == "#{@s2}"
    page.table_cell(20,14).should == "#{@s2}"
    page.table_cell(20,15).should == "#{@s2}"
    page.table_cell(20,16).should == "#{@s2}"
     #student name:Sone, Soni
    page.table_cell(21,0).should == 'Sone, Soni'
    page.table_cell(21,1).should == '2'
    page.table_cell(21,2).should == '1'
    page.table_cell(21,3).should == "#{@s2}"
    page.table_cell(21,4).should == "#{@s2}"
    page.table_cell(21,5).should == "#{@s2}"
    page.table_cell(21,6).should == '1'
    page.table_cell(21,11).should == "#{@s2}"
    page.table_cell(21,12).should == '100%'
    page.table_cell(21,13).should == '100%'
    page.table_cell(21,14).should == "#{@s2}"
    page.table_cell(21,15).should == "#{@s2}"
    page.table_cell(21,16).should == "#{@s2}"
     #average column
    page.val1.exists?.should be_true
    page.val2.exists?.should be_true
    page.val3.exists?.should be_true
    page.val4.exists?.should be_true
    page.val5.exists?.should be_true
    page.val6.exists?.should be_true
    page.val7.exists?.should be_true
    page.val8.exists?.should be_true
    page.val9.exists?.should be_true
    page.val10.exists?.should be_true
    page.val11.exists?.should be_true


  end
end

Then(/^R180U Class report Verify the Date range Filter$/) do
  on R180UClassReport do |page|
  page.daterange.exists?.should be_true
  end
  end

Then(/^R180u Class report Verify the Reset icon$/) do
  on R180UClassReport do |page|
  page.element(:xpath=>"//span[1]/a").exists?.should be_true
  end
  end

When(/^R180U Class report provide the Date range$/) do
  on R180UClassReport do |page|
  page.daterange.click
  page.startdate.set '1/1/16'
  page.enddate.set '2/22/16'
  page.send_keys :enter
  page.apply.click
  sleep(20)
  end
  end

Then(/^R180U Class report Verify the Class data with date range$/) do
  on R180UClassReport do |page|
    @studentname = "Kanaghederdauhauliah, O'Mally"
    @s2  =   8212.chr("UTF-8")
    page.table_cell(0,0).should =='Annunziata, Chauntriceller'
    page.table_cell(0,1).should =='6'
    page.table_cell(0,2).should =='6'
    page.table_cell(0,3).should =='1'
    page.table_cell(0,4).should =='204'
    page.table_cell(0,5).should =='34'
    page.table_cell(0,6).should =='3'
    page.table_cell(0,11).should =='63%'
    page.table_cell(0,12).should =='30%'
    page.table_cell(0,13).should =='75%'
    page.table_cell(0,14).should =='80%'
    page.table_cell(0,15).should =='81%'
    page.table_cell(0,16).should =='100%'
    #student name:Baby, Bunny
    page.table_cell(1,0).should =='Baby, Bunny'
    page.table_cell(1,1).should =='1'
    page.table_cell(1,2).should =='2'
    page.table_cell(1,3).should =="#{@s2}"
    page.table_cell(1,4).should =='29'
    page.table_cell(1,5).should =='15'
    page.table_cell(1,6).should =='1'
    page.table_cell(1,11).should =="#{@s2}"
    page.table_cell(1,12).should =="#{@s2}"
    page.table_cell(1,13).should =='100%'
    page.table_cell(1,14).should =="#{@s2}"
    page.table_cell(1,15).should =='65%'
    page.table_cell(1,16).should =="#{@s2}"
    #student name:Caine, Kain
    page.table_cell(2,0).should =='Caine, Kain'
    page.table_cell(2,1).should =="#{@s2}"
    page.table_cell(2,2).should =="#{@s2}"
    page.table_cell(2,3).should =="#{@s2}"
    page.table_cell(2,4).should =="#{@s2}"
    page.table_cell(2,5).should =="#{@s2}"
    page.table_cell(2,6).should =="#{@s2}"
    page.table_cell(2,11).should =="#{@s2}"
    page.table_cell(2,12).should =="#{@s2}"
    page.table_cell(2,13).should =="#{@s2}"
    page.table_cell(2,14).should =="#{@s2}"
    page.table_cell(2,15).should =="#{@s2}"
    page.table_cell(2,16).should =="#{@s2}"
    #student name:Chu, Amy
    page.table_cell(3,0).should =='Chu, Amy'
    page.table_cell(3,1).should =='1'
    page.table_cell(3,2).should =='5'
    page.table_cell(3,3).should =="#{@s2}"
    page.table_cell(3,4).should =='126'
    page.table_cell(3,5).should =='25'
    page.table_cell(3,6).should =='3'
    page.table_cell(3,11).should =='0%'
    page.table_cell(3,12).should =='67%'
    page.table_cell(3,13).should =="#{@s2}"
    page.table_cell(3,14).should =="#{@s2}"
    page.table_cell(3,15).should =='70%'
    page.table_cell(3,16).should =="#{@s2}"
    #student name:Chu, Amy
    page.table_cell(4,0).should =='Chu, Amy'
    page.table_cell(4,1).should =='1'
    page.table_cell(4,2).should =='4'
    page.table_cell(4,3).should =="#{@s2}"
    page.table_cell(4,4).should =='291'
    page.table_cell(4,5).should =='73'
    page.table_cell(4,6).should =='1'
    page.table_cell(4,11).should =='33%'
    page.table_cell(4,12).should =='87%'
    page.table_cell(4,13).should =='91%'
    page.table_cell(4,14).should =='100%'
    page.table_cell(4,15).should =='100%'
    page.table_cell(4,16).should =="#{@s2}"
    #student name:Chu, Amy
    page.table_cell(5,0).should =='Chu, Amy'
    page.table_cell(5,1).should =='1'
    page.table_cell(5,2).should =='3'
    page.table_cell(5,3).should =="#{@s2}"
    page.table_cell(5,4).should =='30'
    page.table_cell(5,5).should =='10'
    page.table_cell(5,6).should =='2'
    page.table_cell(5,11).should =='14%'
    page.table_cell(5,12).should =='80%'
    page.table_cell(5,13).should =="#{@s2}"
    page.table_cell(5,14).should =="#{@s2}"
    page.table_cell(5,15).should =="#{@s2}"
    page.table_cell(5,16).should =="#{@s2}"
    #student name:Chu, Soni
    page.table_cell(6,0).should =='Chu, Soni'
    page.table_cell(6,1).should =="#{@s2}"
    page.table_cell(6,2).should =="#{@s2}"
    page.table_cell(6,3).should =="#{@s2}"
    page.table_cell(6,4).should =="#{@s2}"
    page.table_cell(6,5).should =="#{@s2}"
    page.table_cell(6,6).should =="#{@s2}"
    page.table_cell(6,11).should =="#{@s2}"
    page.table_cell(6,12).should =="#{@s2}"
    page.table_cell(6,13).should =="#{@s2}"
    page.table_cell(6,14).should =="#{@s2}"
    page.table_cell(6,15).should =="#{@s2}"
    page.table_cell(6,16).should =="#{@s2}"
    #student name:ghosh, Amit
    page.table_cell(7,0).should =='ghosh, Amit'
    page.table_cell(7,1).should =="#{@s2}"
    page.table_cell(7,2).should =="#{@s2}"
    page.table_cell(7,3).should =="#{@s2}"
    page.table_cell(7,4).should =="#{@s2}"
    page.table_cell(7,5).should =="#{@s2}"
    page.table_cell(7,6).should =="#{@s2}"
    page.table_cell(7,11).should =="#{@s2}"
    page.table_cell(7,12).should =="#{@s2}"
    page.table_cell(7,13).should =="#{@s2}"
    page.table_cell(7,14).should =="#{@s2}"
    page.table_cell(7,15).should =="#{@s2}"
    page.table_cell(7,16).should =="#{@s2}"
    #student name:Jong, Kim
    page.table_cell(8,0).should =='Jong, Kim'
    page.table_cell(8,1).should =='1'
    page.table_cell(8,2).should =='2'
    page.table_cell(8,3).should =="#{@s2}"
    page.table_cell(8,4).should =='45'
    page.table_cell(8,5).should =='22'
    page.table_cell(8,6).should =='2'
    page.table_cell(8,11).should =='71%'
    page.table_cell(8,12).should =='79%'
    page.table_cell(8,13).should =='100%'
    page.table_cell(8,14).should =="#{@s2}"
    page.table_cell(8,15).should =="#{@s2}"
    page.table_cell(8,16).should =="#{@s2}"
    #student name:Junior, Kim
    page.table_cell(9,0).should =='Junior, Kim'
    page.table_cell(9,1).should =="#{@s2}"
    page.table_cell(9,2).should =="#{@s2}"
    page.table_cell(9,3).should =="#{@s2}"
    page.table_cell(9,4).should =="#{@s2}"
    page.table_cell(9,5).should =="#{@s2}"
    page.table_cell(9,6).should =="#{@s2}"
    page.table_cell(9,11).should =="#{@s2}"
    page.table_cell(9,12).should =="#{@s2}"
    page.table_cell(9,13).should =="#{@s2}"
    page.table_cell(9,14).should =="#{@s2}"
    page.table_cell(9,15).should =="#{@s2}"
    page.table_cell(9,16).should =="#{@s2}"
    #student name:Kanaghederdauhauliah, O'Mally
    page.table_cell(10,0).should == "#{@studentname}" 
    page.table_cell(10,1).should =='6'
    page.table_cell(10,2).should =='3'
    page.table_cell(10,3).should =='1'
    page.table_cell(10,4).should =='25'
    page.table_cell(10,5).should =='8'
    page.table_cell(10,6).should =='1'
    page.table_cell(10,11).should =='35%'
    page.table_cell(10,12).should =='70%'
    page.table_cell(10,13).should =='85%'
    page.table_cell(10,14).should =='86%'
    page.table_cell(10,15).should =='43%'
    page.table_cell(10,16).should =='50%'
    #student name:Ken, Kristi
    page.table_cell(11,0).should =='Ken, Kristi'
    page.table_cell(11,1).should =="#{@s2}"
    page.table_cell(11,2).should =="#{@s2}"
    page.table_cell(11,3).should =="#{@s2}"
    page.table_cell(11,4).should =="#{@s2}"
    page.table_cell(11,5).should =="#{@s2}"
    page.table_cell(11,6).should =="#{@s2}"
    page.table_cell(11,11).should =="#{@s2}"
    page.table_cell(11,12).should =="#{@s2}"
    page.table_cell(11,13).should =="#{@s2}"
    page.table_cell(11,14).should =="#{@s2}"
    page.table_cell(11,15).should =="#{@s2}"
    page.table_cell(11,16).should =="#{@s2}"
    #student name:Liang, Chin
    page.table_cell(12,0).should =='Liang, Chin'
    page.table_cell(12,1).should =="#{@s2}"
    page.table_cell(12,2).should =="#{@s2}"
    page.table_cell(12,3).should =="#{@s2}"
    page.table_cell(12,4).should =="#{@s2}"
    page.table_cell(12,5).should =="#{@s2}"
    page.table_cell(12,6).should =="#{@s2}"
    page.table_cell(12,11).should =="#{@s2}"
    page.table_cell(12,12).should =="#{@s2}"
    page.table_cell(12,13).should =="#{@s2}"
    page.table_cell(12,14).should =="#{@s2}"
    page.table_cell(12,15).should =="#{@s2}"
    page.table_cell(12,16).should =="#{@s2}"
    #student name:LRS, Intellify
    page.table_cell(13,0).should =='LRS, Intellify'
    page.table_cell(13,1).should =='6'
    page.table_cell(13,2).should =='1'
    page.table_cell(13,3).should =="#{@s2}"
    page.table_cell(13,4).should =="#{@s2}"
    page.table_cell(13,5).should =="#{@s2}"
    page.table_cell(13,6).should =='1'
    page.table_cell(13,11).should =='100%'
    page.table_cell(13,12).should =="#{@s2}"
    page.table_cell(13,13).should =="#{@s2}"
    page.table_cell(13,14).should =="#{@s2}"
    page.table_cell(13,15).should =="#{@s2}"
    page.table_cell(13,16).should =="#{@s2}"
    #student name:LRS, LRSpsi8
    page.table_cell(14,0).should =='LRS, LRSpsi8'
    page.table_cell(14,1).should =="#{@s2}"
    page.table_cell(14,2).should =="#{@s2}"
    page.table_cell(14,3).should =="#{@s2}"
    page.table_cell(14,4).should =="#{@s2}"
    page.table_cell(14,5).should =="#{@s2}"
    page.table_cell(14,6).should =="#{@s2}"
    page.table_cell(14,11).should =="#{@s2}"
    page.table_cell(14,12).should =="#{@s2}"
    page.table_cell(14,13).should =="#{@s2}"
    page.table_cell(14,14).should =="#{@s2}"
    page.table_cell(14,15).should =="#{@s2}"
    page.table_cell(14,16).should =="#{@s2}"
    #student name:LRS, Retest
    page.table_cell(15,0).should =='LRS, Retest'
    page.table_cell(15,1).should =="#{@s2}"
    page.table_cell(15,2).should =="#{@s2}"
    page.table_cell(15,3).should =="#{@s2}"
    page.table_cell(15,4).should =="#{@s2}"
    page.table_cell(15,5).should =="#{@s2}"
    page.table_cell(15,6).should =="#{@s2}"
    page.table_cell(15,11).should =="#{@s2}"
    page.table_cell(15,12).should =="#{@s2}"
    page.table_cell(15,13).should =="#{@s2}"
    page.table_cell(15,14).should =="#{@s2}"
    page.table_cell(15,15).should =="#{@s2}"
    page.table_cell(15,16).should =="#{@s2}"
    #student name:LRS1, Intel1
    page.table_cell(16,0).should =='LRS1, Intel1'
    page.table_cell(16,1).should =='6'
    page.table_cell(16,2).should =='1'
    page.table_cell(16,3).should =="#{@s2}"
    page.table_cell(16,4).should =='12'
    page.table_cell(16,5).should =='12'
    page.table_cell(16,6).should =='1'
    page.table_cell(16,11).should =='100%'
    page.table_cell(16,12).should =="#{@s2}"
    page.table_cell(16,13).should =="#{@s2}"
    page.table_cell(16,14).should =="#{@s2}"
    page.table_cell(16,15).should =="#{@s2}"
    page.table_cell(16,16).should =="#{@s2}"
    #student name:LRS180, student
    page.table_cell(17,0).should =='LRS180, student'
    page.table_cell(17,1).should =="#{@s2}"
    page.table_cell(17,2).should =="#{@s2}"
    page.table_cell(17,3).should =="#{@s2}"
    page.table_cell(17,4).should =="#{@s2}"
    page.table_cell(17,5).should =="#{@s2}"
    page.table_cell(17,6).should =="#{@s2}"
    page.table_cell(17,11).should =="#{@s2}"
    page.table_cell(17,12).should =="#{@s2}"
    page.table_cell(17,13).should =="#{@s2}"
    page.table_cell(17,14).should =="#{@s2}"
    page.table_cell(17,15).should =="#{@s2}"
    page.table_cell(17,16).should =="#{@s2}"
    #student name:LRS2, Intelly2
    page.table_cell(18,0).should =='LRS2, Intelly2'
    page.table_cell(18,1).should =='6'
    page.table_cell(18,2).should =='1'
    page.table_cell(18,3).should =="#{@s2}"
    page.table_cell(18,4).should =='11'
    page.table_cell(18,5).should =='11'
    page.table_cell(18,6).should =='1'
    page.table_cell(18,11).should =='100%'
    page.table_cell(18,12).should =='50%'
    page.table_cell(18,13).should =="#{@s2}"
    page.table_cell(18,14).should =="#{@s2}"
    page.table_cell(18,15).should =="#{@s2}"
    page.table_cell(18,16).should =="#{@s2}"
    #student name:Retest, LRS
    page.table_cell(19,0).should =='Retest, LRS'
    page.table_cell(19,1).should =="#{@s2}"
    page.table_cell(19,2).should =="#{@s2}"
    page.table_cell(19,3).should =="#{@s2}"
    page.table_cell(19,4).should =="#{@s2}"
    page.table_cell(19,5).should =="#{@s2}"
    page.table_cell(19,6).should =="#{@s2}"
    page.table_cell(19,11).should =="#{@s2}"
    page.table_cell(19,12).should =="#{@s2}"
    page.table_cell(19,13).should =="#{@s2}"
    page.table_cell(19,14).should =="#{@s2}"
    page.table_cell(19,15).should =="#{@s2}"
    page.table_cell(19,16).should =="#{@s2}"
    #student name:Son, Suni
    page.table_cell(20,0).should =='Son, Suni'
    page.table_cell(20,1).should =='1'
    page.table_cell(20,2).should =='1'
    page.table_cell(20,3).should =="#{@s2}"
    page.table_cell(20,4).should =='21'
    page.table_cell(20,5).should =='21'
    page.table_cell(20,6).should =='1'
    page.table_cell(20,11).should =='100%'
    page.table_cell(20,12).should =="#{@s2}"
    page.table_cell(20,13).should =="#{@s2}"
    page.table_cell(20,14).should =="#{@s2}"
    page.table_cell(20,15).should =="#{@s2}"
    page.table_cell(20,16).should =="#{@s2}"
    #student name:Sone, Soni
    page.table_cell(21,0).should =='Sone, Soni'
    page.table_cell(21,1).should =="#{@s2}"
    page.table_cell(21,2).should =="#{@s2}"
    page.table_cell(21,3).should =="#{@s2}"
    page.table_cell(21,4).should =="#{@s2}"
    page.table_cell(21,5).should =="#{@s2}"
    page.table_cell(21,6).should =="#{@s2}"
    page.table_cell(21,11).should =="#{@s2}"
    page.table_cell(21,12).should =="#{@s2}"
    page.table_cell(21,13).should =="#{@s2}"
    page.table_cell(21,14).should =="#{@s2}"
    page.table_cell(21,15).should =="#{@s2}"
    page.table_cell(21,16).should =="#{@s2}"
    #average column
    page.date_val1.exists?.should be_true
    page.date_val2.exists?.should be_true
    page.date_val3.exists?.should be_true
    page.date_val4.exists?.should be_true
    page.date_val5.exists?.should be_true
    page.date_val6.exists?.should be_true
    page.date_val7.exists?.should be_true
    page.date_val8.exists?.should be_true
    page.date_val9.exists?.should be_true
    page.date_val10.exists?.should be_true
    page.date_val11.exists?.should be_true
  end
end

When(/^R180U Class report Click on the reset icon$/) do
  on R180UClassReport do |page|
    page.element(:xpath=>"//span[1]/a").click
    sleep(20)
  end
end

Then(/^R180U Class report Verify the Class data without date range$/) do
  on R180UClassReport do |page|
    #average column
    page.val1.exists?.should be_true
    page.val2.exists?.should be_true
    page.val3.exists?.should be_true
    page.val4.exists?.should be_true
    page.val5.exists?.should be_true
    page.val6.exists?.should be_true
    page.val7.exists?.should be_true
    page.val8.exists?.should be_true
    page.val9.exists?.should be_true
    page.val10.exists?.should be_true
    page.val11.exists?.should be_true
  end
end