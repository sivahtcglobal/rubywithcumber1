Given(/^Accessing the SPI Student Report for the (.*) using the (.*) and (.*) in the (.*) with (.*) and (.*)$/) do |studentid,siteid,classid,intelliview,key,secret|

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

Then(/^SPI Student Report should load as expected$/) do
  on SPIStudentReport do |page|

    page.fluencyscore_deco_header.exists?.should be_true
    #page.windows[0].close
    page.header.should == 'Phonics Proficiency and Growth Report'
    sleep(5)
    page.classname.should == 'Aaron Able'
    page.printicon.exists?.should be_true
    page.phonicsinventoryimg.exists?.should be_true
    page.daterange.exists?.should be_true
  end
end

Then(/^SPI Student report Summary Section should display as expected$/) do
  on SPIStudentReport do |page|
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

Then(/^SPI Student report line Chart Section should display as expected$/) do
  on SPIStudentReport do |page|
    page.line_chart.exists?.should be_true
    page.chart_header.exists?.should be_true
  end
end

Then(/^SPI Student report line Chart Image Display as expected$/) do
  on SPIStudentReport do |page|
    page.tool_tip1.exists?.should be_true
    page.tool_tip2.exists?.should be_true
    page.tool_tip3.exists?.should be_true
    page.tool_tip4.exists?.should be_true

  end
end

Then(/^SPI Student report Table Group Header Section should display as expected$/) do
  on SPIStudentReport do |page|
   page.group_header.exists?.should be_true
  end
end

Then(/^SPI Student report Table Header Section should display as expected$/) do
  on SPIStudentReport do |page|
        page.table_header1(0,0).should == "Date"
        page.table_header(1,0).should =='Letter Names Accuracy'
        page.table_header(2,0).should =='Sight Words Accuracy'
        page.table_header(3,0).should =='Sight Words Fluency'
        page.table_header(4,0).should =='Nonsense Words Accuracy'
        page.table_header(5,0).should =='Nonsense Words Fluency'
        page.table_header(12,0).should =='Fluency Score'
        page.table_header(13,0).should =='Decoding Status'
  end
end

Then(/^SPI Student report Table Values should display as expected for all the Students in the Class$/) do
  on SPIStudentReport do |page|
    #row1
  page.table_cell(0,0).should == '2/5/16'
  page.table_cell(0,1).should == '91%'
  page.table_cell(0,2).should == '93%'
  page.table_cell(0,3).should == '47%'
  page.table_cell(0,4).should == '90%'
  page.table_cell(0,5).should == '77%'
  page.table_cell(0,12).should == '37'
  page.table_cell(0,13).should == 'Advancing'
    #row2
  page.table_cell(1,0).should == '1/11/16'
  page.table_cell(1,1).should == '37%'
  page.table_cell(1,2).should == '37%'
  page.table_cell(1,3).should == '60%'
  page.table_cell(1,4).should == '97%'
  page.table_cell(1,5).should == '37%'
  page.table_cell(1,12).should == '34'
  page.table_cell(1,13).should == 'Advancing'
    #row3
  page.table_cell(2,0).should == '1/4/16'
  page.table_cell(2,1).should == '37%'
  page.table_cell(2,2).should == '37%'
  page.table_cell(2,3).should == '13%'
  page.table_cell(2,4).should == '93%'
  page.table_cell(2,5).should == '37%'
  page.table_cell(2,12).should == '12'
  page.table_cell(2,13).should == 'Developing'
    #row4
  page.table_cell(3,0).should == '12/30/15'
  page.table_cell(3,1).should == '37%'
  page.table_cell(3,2).should == '37%'
  page.table_cell(3,3).should == '43%'
  page.table_cell(3,4).should == '100%'
  page.table_cell(3,5).should == '37%'
  page.table_cell(3,12).should == '29'
  page.table_cell(3,13).should == 'Advancing'
  end
end

Then(/^SPI Student report Decoding Status Table Value should display$/) do
  on SPIStudentReport do |page|
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

Then(/^SPI Student report Verify the Date range Filter$/) do
  on SPIStudentReport do |page|
    page.daterange.exists?.should be_true
  end
end

Then(/^SPI Student report Verify the Reset icon$/) do
  on SPIStudentReport do |page|
    page.element(:xpath=>"//span[1]/a").exists?.should be_true
  end
end

When(/^SPI Student report provide the Date range$/) do
  on SPIStudentReport do |page|
    page.daterange.click
    page.startdate.set '11/30/15'
    page.enddate.set '1/31/16'
    page.send_keys :enter
    page.apply.click
    sleep(20)
  end
end

Then(/^SPI Student report Verify the Class data with date range$/) do
  on SPIStudentReport do |page|
    page.summary_date_val1.exists?.should be_true
    page.summary_date_val2.exists?.should be_true
    page.summary_date_val3.exists?.should be_true
    #row1
    page.table_cell(0,0).should == '1/11/16'
    page.table_cell(0,1).should == '37%'
    page.table_cell(0,2).should == '37%'
    page.table_cell(0,3).should == '60%'
    page.table_cell(0,4).should == '97%'
    page.table_cell(0,5).should == '37%'
    page.table_cell(0,12).should == '34'
    page.table_cell(0,13).should == 'Advancing'
    #row2
    page.table_cell(1,0).should == '1/4/16'
    page.table_cell(1,1).should == '37%'
    page.table_cell(1,2).should == '37%'
    page.table_cell(1,3).should == '13%'
    page.table_cell(1,4).should == '93%'
    page.table_cell(1,5).should == '37%'
    page.table_cell(1,12).should == '12'
    page.table_cell(1,13).should == 'Developing'
    #row3
    page.table_cell(2,0).should == '12/30/15'
    page.table_cell(2,1).should == '37%'
    page.table_cell(2,2).should == '37%'
    page.table_cell(2,3).should == '43%'
    page.table_cell(2,4).should == '100%'
    page.table_cell(2,5).should == '37%'
    page.table_cell(2,12).should == '29'
    page.table_cell(2,13).should == 'Advancing'
  end
end

When(/^SPI Student report Click on the reset icon$/) do
  on SPIStudentReport do |page|
    page.element(:xpath=>"//span[1]/a").click
    sleep(20)
  end
end

Then(/^SPI Student report Verify the Class data without date range$/) do
  on SPIStudentReport do |page|
    #row1
    page.table_cell(0,0).should == '2/5/16'
    page.table_cell(0,1).should == '91%'
    page.table_cell(0,2).should == '93%'
    page.table_cell(0,3).should == '47%'
    page.table_cell(0,4).should == '90%'
    page.table_cell(0,5).should == '77%'
    page.table_cell(0,12).should == '37'
    page.table_cell(0,13).should == 'Advancing'
    #row2
    page.table_cell(1,0).should == '1/11/16'
    page.table_cell(1,1).should == '37%'
    page.table_cell(1,2).should == '37%'
    page.table_cell(1,3).should == '60%'
    page.table_cell(1,4).should == '97%'
    page.table_cell(1,5).should == '37%'
    page.table_cell(1,12).should == '34'
    page.table_cell(1,13).should == 'Advancing'
    #row3
    page.table_cell(2,0).should == '1/4/16'
    page.table_cell(2,1).should == '37%'
    page.table_cell(2,2).should == '37%'
    page.table_cell(2,3).should == '13%'
    page.table_cell(2,4).should == '93%'
    page.table_cell(2,5).should == '37%'
    page.table_cell(2,12).should == '12'
    page.table_cell(2,13).should == 'Developing'
    #row4
    page.table_cell(3,0).should == '12/30/15'
    page.table_cell(3,1).should == '37%'
    page.table_cell(3,2).should == '37%'
    page.table_cell(3,3).should == '43%'
    page.table_cell(3,4).should == '100%'
    page.table_cell(3,5).should == '37%'
    page.table_cell(3,12).should == '29'
    page.table_cell(3,13).should == 'Advancing'
  end
end