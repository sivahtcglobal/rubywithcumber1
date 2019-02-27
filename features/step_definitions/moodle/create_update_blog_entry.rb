Given(/^Created a New Blog Entry under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @courseId = configatron.courseId unless configatron.courseId == nil

  on MoodleHomePage do |page|
    @browser.execute_script("window.onbeforeunload = null")
    @browser.goto(configatron.moodleURL)
    begin
      moodle_logout if page.profile_dropdown.exists?

      @username = configatron.autoTeacherUsername
      @password = configatron.autoTeacherPassword
      log_in_moodle(@username,@password)
    end unless (page.automation_site_Teacher.exists? && page.automation_site_Teacher.text.include?(configatron.autoTeacherUsername))
  end

  @blogEntryTitle =  'at_blog_entry_title_'+@currnetTimeStamp.to_s
  @blogEntryBody = 'Automated Blog Entry Body'+@currnetTimeStamp.to_s
  configatron.blogentrytitle = @blogEntryTitle
  configatron.blogentrybody = @blogEntryBody

  @browser.goto(configatron.moodleURL+'/blog/edit.php?action=add')

  on CourseBlogPage do |page|
    page.entry_title_txt.set @blogEntryTitle

    page.blog_entry_body_txt.click
    page.blog_entry_body_txt.send_keys [:control, 'a']
    page.blog_entry_body_txt.send_keys @blogEntryBody

    page.publish_to_select.select 'Yourself (draft)'

    page.blog_save_changes_btn_clk
  end
end

When(/^The New Blog Entry got successfully created$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == 'Blog entries'
  end
end

Then(/^An Event for New Blog Entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Posted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^\['event'\]\.\['object'\]\.\['body'\] = Provided Description$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].should include configatron.blogentrybody
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'blog_entry'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'blog_entry'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['publishTo'\] = 'draft'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['publishTo'].should == 'draft'
end

And(/^\['event'\]\.\['object'\]\.\['extensions'\]\.\['subject'\] = Provided Blog Name$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['subject'].should == configatron.blogentrytitle
end

Given(/^Updated the existing Blog Entry under a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000

  @blogEntryTitle =  'at_blog_entry_title_'+@currnetTimeStamp.to_s+'updated'
  @blogEntryBody = 'Automated Blog Entry Body'+@currnetTimeStamp.to_s+'updated'
  configatron.blogentrytitleupdated = @blogEntryTitle
  configatron.blogentrybodyupdated = @blogEntryBody

  on CourseBlogPage do |page|
    page.edit_link.click

    page.entry_title_txt.clear
    page.entry_title_txt.set @blogEntryTitle

    page.blog_entry_body_txt.click
    page.blog_entry_body_txt.send_keys [:control, 'a']
    page.blog_entry_body_txt.send_keys @blogEntryBody

    page.publish_to_select.select 'Anyone on this site'

    page.blog_save_changes_btn_clk
  end
end

When(/^The existing Blog Entry got successfully updated$/) do
  on CourseItemPage do |page|
    page.course_item_breadcrumb.text.should == 'Blog entries'
  end
  moodle_logout
end

Then(/^An Event for Update Blog Entry should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Posted\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^Updated \['event'\]\.\['object'\]\.\['body'\] = Provided Description$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].should include configatron.blogentrybodyupdated
end

And(/^Updated \['event'\]\.\['object'\]\.\['extensions'\]\.\['subject'\] = Provided Blog Name$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['subject'].should == configatron.blogentrytitleupdated
end

And(/^Updated \['event'\]\.\['object'\]\.\['extensions'\]\.\['publishTo'\] = 'site'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['publishTo'].should == 'site'
end
