Given(/^Accessing the SPI Class Report using the (.*) and (.*) in the (.*) with (.*) and (.*)$/) do |siteid,classid,intelliview,key,secret|

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

Then(/^The SPI Class Report should load as expected$/) do
  on SPIClassReport do |page|
     page.average.exists?.should be_true
     page.header.should == 'Phonics Proficiency and Growth Report'
     page.classname.should == 'Tribbles'
     page.printicon.exists?.should be_true
     page.phonicsinventoryimg.exists?.should be_true
     page.daterange.exists?.should be_true
    #page.windows[0].close
  end
end

Then(/^SPI Class report Summary Section should display as expected$/) do
  on SPIClassReport do |page|
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

Then(/^SPI Class report Row Chart Section should display as expected$/) do
  on SPIClassReport do |page|
    page.chart_header.exists?.should be_true
    page.firsttest_header.exists?.should be_true
    page.lasttest_header.exists?.should be_true
  end
end

Then(/^SPI Class report Row Chart Image Display as expected$/) do
  on SPIClassReport do |page|
    page.chart_first.exists?.should be_true
    page.chart_last.exists?.should be_true
    page.tool_tip1.exists?.should be_true
    page.tool_tip2.exists?.should be_true
    page.tool_tip3.exists?.should be_true
    page.tool_tip4.exists?.should be_true
    page.tool_tip5.exists?.should be_true
  end
end

Then(/^SPI Class report Table Group Header Section should display as expected$/) do
  on SPIClassReport do |page|
    page.group_header_testfirst.exists?.should be_true
    page.group_header_testlast.exists?.should be_true
  end
end

Then(/^SPI Class report Table Header Section should display as expected$/) do
  on SPIClassReport do |page|
    page.table_header1(0,0).should == 'Name'
    page.table_header(1,0).should == 'Grade'
    page.table_header(5,0).should == 'Test Date'
    page.table_header(7,0).should == 'Fluency Score'
    page.table_header(8,0).should == 'Decoding Status'
    page.table_header(9,0).should == 'Test Date'
    page.table_header(11,0).should == 'Fluency Score'
    page.table_header(12,0).should == 'Decoding Status'
  end
end

Then(/^SPI Class report Table Values should display as expected for all the Students in the Class$/) do
  on SPIClassReport do |page|
    @s2  =   8212.chr("UTF-8")
    #studentname:Dummy, Doofus
    page.table_cell(0,0).should =='Dummy, Doofus'
    page.table_cell(0,1).should =='7'
    page.table_cell(0,5).should =='12/22/15'
    page.table_cell(0,7).should =='59'
    page.table_cell(0,8).should =='Advancing'
    page.table_cell(0,9).should =='2/17/16'
    page.table_cell(0,11).should =='28'
    page.table_cell(0,12).should =='Beginning'
    #studentname:Eager, Eddie
    page.table_cell(1,0).should =='Eager, Eddie'
    page.table_cell(1,1).should =='5'
    page.table_cell(1,5).should =='2/2/16'
    page.table_cell(1,7).should =='4'
    page.table_cell(1,8).should =='Beginning'
    page.table_cell(1,9).should =="#{@s2}"
    page.table_cell(1,11).should =="#{@s2}"
    page.table_cell(1,12).should =="#{@s2}"
    #studentname:Early, Elvis
    page.table_cell(2,0).should =='Early, Elvis'
    page.table_cell(2,1).should =='11'
    page.table_cell(2,5).should =="#{@s2}"
    page.table_cell(2,7).should =="#{@s2}"
    page.table_cell(2,8).should =="#{@s2}"
    page.table_cell(2,9).should =="#{@s2}"
    page.table_cell(2,11).should =="#{@s2}"
    page.table_cell(2,12).should =="#{@s2}"
    #studentname:Failure, Fred
    page.table_cell(3,0).should =='Failure, Fred'
    page.table_cell(3,1).should =='7'
    page.table_cell(3,5).should =="#{@s2}"
    page.table_cell(3,7).should =="#{@s2}"
    page.table_cell(3,8).should =="#{@s2}"
    page.table_cell(3,9).should =="#{@s2}"
    page.table_cell(3,11).should =="#{@s2}"
    page.table_cell(3,12).should =="#{@s2}"
    #studentname:irtest1, irtest1
    page.table_cell(4,0).should =='irtest1, irtest1'
    page.table_cell(4,1).should =='2'
    page.table_cell(4,5).should =="#{@s2}"
    page.table_cell(4,7).should =="#{@s2}"
    page.table_cell(4,8).should =="#{@s2}"
    page.table_cell(4,9).should =="#{@s2}"
    page.table_cell(4,11).should =="#{@s2}"
    page.table_cell(4,12).should =="#{@s2}"
    #studentname:Nevertake, Nancy
    page.table_cell(5,0).should =='Nevertake, Nancy'
    page.table_cell(5,1).should =='6'
    page.table_cell(5,5).should =="#{@s2}"
    page.table_cell(5,7).should =="#{@s2}"
    page.table_cell(5,8).should =="#{@s2}"
    page.table_cell(5,9).should =="#{@s2}"
    page.table_cell(5,11).should =="#{@s2}"
    page.table_cell(5,12).should =="#{@s2}"
    #studentname:Nevertake, Ned
    page.table_cell(6,0).should =='Nevertake, Ned'
    page.table_cell(6,1).should =='6'
    page.table_cell(6,5).should =="#{@s2}"
    page.table_cell(6,7).should =="#{@s2}"
    page.table_cell(6,8).should =="#{@s2}"
    page.table_cell(6,9).should =="#{@s2}"
    page.table_cell(6,11).should =="#{@s2}"
    page.table_cell(6,12).should =="#{@s2}"
    #studentname:Onetake, Ollie
    page.table_cell(7,0).should =='Onetake, Ollie'
    page.table_cell(7,1).should =='5'
    page.table_cell(7,5).should =='2/5/16'
    page.table_cell(7,7).should =='26'
    page.table_cell(7,8).should =='Advancing'
    page.table_cell(7,9).should =="#{@s2}"
    page.table_cell(7,11).should =="#{@s2}"
    page.table_cell(7,12).should =="#{@s2}"
    #studentname:Sally, Silly
    page.table_cell(8,0).should =='Sally, Silly'
    page.table_cell(8,1).should =='6'
    page.table_cell(8,5).should =='1/26/16'
    page.table_cell(8,7).should =='0'
    page.table_cell(8,8).should =='Beginning'
    page.table_cell(8,9).should =="#{@s2}"
    page.table_cell(8,11).should =="#{@s2}"
    page.table_cell(8,12).should =="#{@s2}"
    #studentname:Twelver, Trina
    page.table_cell(9,0).should =='Twelver, Trina'
    page.table_cell(9,1).should =='12'
    page.table_cell(9,5).should =='2/13/16'
    page.table_cell(9,7).should =='36'
    page.table_cell(9,8).should =='Advancing'
    page.table_cell(9,9).should =="#{@s2}"
    page.table_cell(9,11).should =="#{@s2}"
    page.table_cell(9,12).should =="#{@s2}"
    #studentname:Yak, Yellow
    page.table_cell(10,0).should =='Yak, Yellow'
    page.table_cell(10,1).should =='5'
    page.table_cell(10,5).should =='1/26/16'
    page.table_cell(10,7).should =='14'
    page.table_cell(10,8).should =='Developing'
    page.table_cell(10,9).should =='2/3/16'
    page.table_cell(10,11).should =='29'
    page.table_cell(10,12).should =='Advancing'
    #studentname:Zillo, Zeke
    page.table_cell(11,0).should =='Zillo, Zeke'
    page.table_cell(11,1).should =='6'
    page.table_cell(11,5).should =='1/25/16'
    page.table_cell(11,7).should =='18'
    page.table_cell(11,8).should =='Developing'
    page.table_cell(11,9).should =='1/27/16'
    page.table_cell(11,11).should =='14'
    page.table_cell(11,12).should =='Developing'
    #average row
    page.average.exists?.should be_true
    page.val1.exists?.should be_true
    page.val2.exists?.should be_true
  end
end

Then(/^SPI Class report Decoding Status Table Value should display$/) do
  on SPIClassReport do |page|
    page.fluencyscore_deco_header.exists?.should be_true
    page.decodingstatus_deco_header.exists?.should be_true
    page.recommended_deco_header.exists?.should be_true
    page.decoder_table(0,0).should == '0-10'
    page.decoder_table(0,1).should == 'Pre-Decoder'
    page.decoder_table(0,2).should == 'Phonemic awareness, letter names, letter-sound correspondence'
    page.decoder_table(1,0).should == '0-10'
    page.decoder_table(1,1).should == 'Beginning Decoder'
    page.decoder_table(1,2).should == 'Foundational Phonics'
    page.decoder_table(2,0).should == '11-22'
    page.decoder_table(2,1).should == 'Developing Decoder'
    page.decoder_table(2,2).should == 'Targeted phonics remediation'
    page.decoder_table(3,0).should == '23-60'
    page.decoder_table(3,1).should == 'Advancing Decoder'
    page.decoder_table(3,2).should == 'Vocabulary, comprehension, fluency'
  end
end

Then(/^SPI Class report Verify the Date range Filter$/) do
  on SPIClassReport do |page|
    page.daterange.exists?.should be_true
  end
end

Then(/^SPI Class report Verify the Reset icon$/) do
  on SPIClassReport do |page|
    page.element(:xpath=>"//span[1]/a").exists?.should be_true
  end
end

When(/^SPI Class report provide the Date range$/) do
  on SPIClassReport do |page|
    page.daterange.click
    page.startdate.set '1/1/16'
    page.enddate.set '2/22/16'
    page.send_keys :enter
    page.apply.click
    sleep(20)
  end
end

Then(/^SPI Class report Verify the Class data with date range$/) do
  on SPIClassReport do |page|
    @s2  =   8212.chr("UTF-8")
    page.summary_date_val1.exists?.should be_true
    page.summary_date_val2.exists?.should be_true
    page.summary_date_val3.exists?.should be_true
    #studentname:Dummy, Doofus
    page.table_cell(0,0).should =='Dummy, Doofus'
    page.table_cell(0,1).should =='7'
    page.table_cell(0,5).should =='1/4/16'
    page.table_cell(0,7).should =='31'
    page.table_cell(0,8).should =='Beginning'
    page.table_cell(0,9).should =='2/17/16'
    page.table_cell(0,11).should =='28'
    page.table_cell(0,12).should =='Beginning'
    #studentname:Eager, Eddie
    page.table_cell(1,0).should =='Eager, Eddie'
    page.table_cell(1,1).should =='5'
    page.table_cell(1,5).should =='2/2/16'
    page.table_cell(1,7).should =='4'
    page.table_cell(1,8).should =='Beginning'
    page.table_cell(1,9).should =="#{@s2}"
    page.table_cell(1,11).should =="#{@s2}"
    page.table_cell(1,12).should =="#{@s2}"
    #studentname:Early, Elvis
    page.table_cell(2,0).should =='Early, Elvis'
    page.table_cell(2,1).should =='11'
    page.table_cell(2,5).should =="#{@s2}"
    page.table_cell(2,7).should =="#{@s2}"
    page.table_cell(2,8).should =="#{@s2}"
    page.table_cell(2,9).should =="#{@s2}"
    page.table_cell(2,11).should =="#{@s2}"
    page.table_cell(2,12).should =="#{@s2}"
    #studentname:Failure, Fred
    page.table_cell(3,0).should =='Failure, Fred'
    page.table_cell(3,1).should =='7'
    page.table_cell(3,5).should =="#{@s2}"
    page.table_cell(3,7).should =="#{@s2}"
    page.table_cell(3,8).should =="#{@s2}"
    page.table_cell(3,9).should =="#{@s2}"
    page.table_cell(3,11).should =="#{@s2}"
    page.table_cell(3,12).should =="#{@s2}"
    #studentname:irtest1, irtest1
    page.table_cell(4,0).should =='irtest1, irtest1'
    page.table_cell(4,1).should =='2'
    page.table_cell(4,5).should =="#{@s2}"
    page.table_cell(4,7).should =="#{@s2}"
    page.table_cell(4,8).should =="#{@s2}"
    page.table_cell(4,9).should =="#{@s2}"
    page.table_cell(4,11).should =="#{@s2}"
    page.table_cell(4,12).should =="#{@s2}"
    #studentname:Nevertake, Nancy
    page.table_cell(5,0).should =='Nevertake, Nancy'
    page.table_cell(5,1).should =='6'
    page.table_cell(5,5).should =="#{@s2}"
    page.table_cell(5,7).should =="#{@s2}"
    page.table_cell(5,8).should =="#{@s2}"
    page.table_cell(5,9).should =="#{@s2}"
    page.table_cell(5,11).should =="#{@s2}"
    page.table_cell(5,12).should =="#{@s2}"
    #studentname:Nevertake, Ned
    page.table_cell(6,0).should =='Nevertake, Ned'
    page.table_cell(6,1).should =='6'
    page.table_cell(6,5).should =="#{@s2}"
    page.table_cell(6,7).should =="#{@s2}"
    page.table_cell(6,8).should =="#{@s2}"
    page.table_cell(6,9).should =="#{@s2}"
    page.table_cell(6,11).should =="#{@s2}"
    page.table_cell(6,12).should =="#{@s2}"
    #studentname:Onetake, Ollie
    page.table_cell(7,0).should =='Onetake, Ollie'
    page.table_cell(7,1).should =='5'
    page.table_cell(7,5).should =='2/5/16'
    page.table_cell(7,7).should =='26'
    page.table_cell(7,8).should =='Advancing'
    page.table_cell(7,9).should =="#{@s2}"
    page.table_cell(7,11).should =="#{@s2}"
    page.table_cell(7,12).should =="#{@s2}"
    #studentname:Sally, Silly
    page.table_cell(8,0).should =='Sally, Silly'
    page.table_cell(8,1).should =='6'
    page.table_cell(8,5).should =='1/26/16'
    page.table_cell(8,7).should =='0'
    page.table_cell(8,8).should =='Beginning'
    page.table_cell(8,9).should =="#{@s2}"
    page.table_cell(8,11).should =="#{@s2}"
    page.table_cell(8,12).should =="#{@s2}"
    #studentname:Twelver, Trina
    page.table_cell(9,0).should =='Twelver, Trina'
    page.table_cell(9,1).should =='12'
    page.table_cell(9,5).should =='2/13/16'
    page.table_cell(9,7).should =='36'
    page.table_cell(9,8).should =='Advancing'
    page.table_cell(9,9).should =="#{@s2}"
    page.table_cell(9,11).should =="#{@s2}"
    page.table_cell(9,12).should =="#{@s2}"
    #studentname:Yak, Yellow
    page.table_cell(10,0).should =='Yak, Yellow'
    page.table_cell(10,1).should =='5'
    page.table_cell(10,5).should =='1/26/16'
    page.table_cell(10,7).should =='14'
    page.table_cell(10,8).should =='Developing'
    page.table_cell(10,9).should =='2/3/16'
    page.table_cell(10,11).should =='29'
    page.table_cell(10,12).should =='Advancing'
    #studentname:Zillo, Zeke
    page.table_cell(11,0).should =='Zillo, Zeke'
    page.table_cell(11,1).should =='6'
    page.table_cell(11,5).should =='1/25/16'
    page.table_cell(11,7).should =='18'
    page.table_cell(11,8).should =='Developing'
    page.table_cell(11,9).should =='1/27/16'
    page.table_cell(11,11).should =='14'
    page.table_cell(11,12).should =='Developing'
    #average row
    page.average.exists?.should be_true
    page.val2.exists?.should be_true
    page.val3.exists?.should be_true
  end
end

When(/^SPI Class report Click on the reset icon$/) do
  on SPIClassReport do |page|
    page.element(:xpath=>"//span[1]/a").click
    sleep(20)
  end
end

Then(/^SPI Class report Verify the Class data without date range$/) do
  on SPIClassReport do |page|
    page.average.exists?.should be_true
    page.val1.exists?.should be_true
    page.val2.exists?.should be_true
  end
end