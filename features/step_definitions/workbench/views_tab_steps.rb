Given(/^Navigate to Views Tab page$/) do

  on WorkbenchHomepage do |page|
    page.image_intellify.wait_until_present
    page.image_intellify.visible?.should be_true
    page.views_tab.wait_until_present
    page.views_tab.click
  end
end

Then(/^Header and Title Elements should be visible in the Views page$/) do
  on WorkbenchViews do |page|
    page.intelliview_txt.wait_until_present
    page.intelliview_txt.text.should  == 'IntelliView Designer'
    page.createinteractivedashboards_txt.text.should == 'Create Interactive Dashboards'
    page.templates_count_txt.text.should == 'Templates'
    page.intelliviews_count_txt.text.should == 'IntelliViews'
    page.intelliviews_count.text.should == '0'
    page.templates_count.text.should == '0'
  end
end

Then(/^All Elements Dashboard Templates should be visible$/) do
  on WorkbenchViews do |page|
    page.dashboard_template_txt.text.should == 'Dashboard Templates'
    page.dashboard_template_plus_btn.visible?.should be_true
    page.dashboard_template_search_btn.visible?.should be_true
    page.dashboard_template_search_btn.click
    page.dashboard_template_searchbox.wait_until_present
    page.dashboard_template_searchbox.visible?.should be_true
    page.dashboard_template_searchbox.click
    page.dashboard_template_previous_btn.visible?.should be_true
    page.dashboard_template_next_btn.visible?.should be_true
  end
end

Then(/^All Elements IntelliViews should be visible$/) do
  on WorkbenchViews do |page|
    page.intelliviews_txt.text.should == 'IntelliViews'
    page.intelliviews_plus_btn.visible?.should be_true
    page.intelliviews_search_btn.visible?.should be_true
    page.intelliviews_search_btn.click
    page.intelliviews_searchbox.wait_until_present
    page.intelliviews_searchbox.visible?.should be_true
    page.intelliviews_searchbox.click
    page.intelliviews_previous_btn.visible?.should be_true
    page.intelliviews_next_btn.visible?.should be_true
  end
end
