
Then(/^Navigate to Streams page$/) do

  on WorkbenchHomepage do |page|
    page.image_intellify.visible?.should be_true
    page.streams_tab.click

  end

  on WorkbenchStreams do |page|
  end
end

Then(/^Verify the Stream Manager$/) do
  on WorkbenchStreams do |page|
    sleep(5)
    page.stream_manager_txt.text.should  == 'Stream Manager'
  end
end

Then(/^Verify All elements$/) do
  on WorkbenchStreams do |page|
    page.filter_btn1.visible?.should be_true
    page.refresh_btn1.visible?.should be_true
    sleep(2)
    page.filter_btn2.visible?.should be_true
    page.refresh_btn2.visible?.should be_true
    page.create_2_computed_stream_btn.visible?.should be_true
    page.create_dynamic_stream_btn.visible?.should be_true

    page.provider_lbl.visible?.should be_true
    page.provider_lbl.click
    page.stream_lbl.visible?.should be_true
    page.stream_lbl.click
    page.records_lbl.visible?.should be_true
    page.records_lbl.click
    page.size_lbl.visible?.should be_true
    page.size_lbl.click
    page.version_lbl.visible?.should be_true
    page.version_lbl.click
    page.active_lbl.visible?.should be_true
    page.active_lbl.click
    page.processing_lbl.visible?.should be_true
    page.processing_lbl.click
    page.type_lbl.visible?.should be_true
    page.type_lbl.click
    page.actions_lbl.visible?.should be_true
    page.actions_lbl.click

    page.filter_btn1.click
    page.type_filter_lbl.text.should == 'Type Filter:'
    page.raw_filter_lbl.text.should == '  Raw'
    page.raw_filter_chkbx.visible?.should be_true
    page.computed_filter_lbl.text.should == '  Computed'
    page.computed_filter_chkbx.visible?.should be_true
    page.dynamic_filter_lbl.text.should == '  Dynamic'
    page.dynamic_filter_chkbx.visible?.should be_true

    page.status_filter_lbl.text.should == 'Status Filter:'
    page.active_filter_lbl.text.should == '  Active'
    page.active_filter_chkbx.visible?.should be_true
    page.processing_filter_lbl.text.should == '  Processing'
    page.processing_filter_chkbx.visible?.should be_true

    page.name_filter_lbl.text.should == 'Name Filter:'
    page.search_stream_txt.send_keys 'DoNotDelete Automation Source'

    page.search_stream_txt2.visible?.should be_true
    page.type_filter_lbl2.text.should == 'Type: '
    page.raw_filter_lbl2.text.should == ' Raw  '
    page.raw_filter_chkbx2.visible?.should be_true
    page.computed_filter_lbl2.text.should == ' Computed  '
    page.computed_filter_chkbx2.visible?.should be_true
    page.dynamic_filter_lbl2.text.should == ' Dynamic  '
    page.dynamic_filter_chkbx2.visible?.should be_true
  end
end

