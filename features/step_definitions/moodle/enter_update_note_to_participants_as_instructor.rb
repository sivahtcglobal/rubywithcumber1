Given(/^Enter (.*?) Note to a Participant as an instructor$/) do |context|

  ENV['TZ'] = 'UTC'
  @currnetTimeStamp = Time.new.to_i * 1000
  @course_Id = 397
  @course_Id = configatron.courseId unless configatron.courseId == nil

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

  @browser.goto(configatron.moodleURL + '/course/view.php?id=' + configatron.courseId)
  @Note = 'Instructor Notes by automation ' + @currnetTimeStamp.to_s

  on CourseDetailPage do |page|

   case configatron.environment

       when 'Master-DEV'
           #For Moodle Build Version 3.1 (Build: 20160523)
         begin

           page.participants_old_link.wait_until_present
           page.participants_old_link.click
           page.participants_stud_link("sname_").wait_until_present
           page.participants_stud_link("sname_").click

           page.participants_notes_link.wait_until_present
           page.participants_notes_link.click

           page.participants_add_notes_link.wait_until_present
           page.participants_add_notes_link.click

           page.participants_notes_txt.wait_until_present
           page.participants_notes_txt.set @Note

           page.participants_notes_context_select.wait_until_present
           page.participants_notes_context_select.select context

           @addCommentStartTimeStamp = Time.new.to_i * 1000
           page.participants_notes_save_btn.click
         end

       when 'Master-PROD', 'Master-Staging'
           #For Moodle Build Version 3.2.3 (Build: 20170508)
         begin

           page.participants_link.wait_until_present
           page.participants_link.click
           page.participants_stud_link("sname_").wait_until_present
           page.participants_stud_link("sname_").click
           page.participants_notes_link.wait_until_present
           page.participants_notes_link.click

           page.participants_add_notes_link.wait_until_present
           page.participants_add_notes_link.click

           page.participants_notes_txt.wait_until_present
           page.participants_notes_txt.set @Note

           page.participants_notes_context_select.wait_until_present
           page.participants_notes_context_select.select context

           @addCommentStartTimeStamp = Time.new.to_i * 1000
           page.participants_notes_save_btn.click
         end

   end

  end

end

When(/^Note got created to a Participant as an instructor$/) do
  on AssignmentViewPage do |page|
    sleep(10)
    # Should Assert that it got successfully saved
  end
  @addCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^Instructor Note creation Event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')

  @startTimeStamp = @addCommentStartTimeStamp
  @endTimeStamp = @addCommentEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"and\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}},{\"term\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Created\"}}]}}}}"
  puts @query.to_json
  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  @hits.should == 1
end


And(/^Instructor Note Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/MessageEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MessageEvent'

end

And(/^Instructor Note Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'

end

And(/^Instructor Note Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Created'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Created'

end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['@type'\] = 'h ttp:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'

end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['body'\] = Provided Instructor Note$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].should == @Note
end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'notes'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should  == 'notes'
end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['context'\] = '(.*?)'$/) do |context|

  case context
    when 'site'
      @contextValue = 'site'
    when 'course'
      @contextValue = 'public'
    when 'personal'
      @contextValue = 'draft'
  end

  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['context'].should  == "#{@contextValue}"
end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseSection'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'

end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseOffering'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'

end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^Instructor Note Event \['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Instructor Note Event \['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'

end

And(/^Instructor Note Event \['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end



# Updated Notes Validation

Given(/^Update the (.*?) Note to a Participant as an instructor$/) do |context|

  ENV['TZ'] = 'UTC'
  @currnetTimeStamp = Time.new.to_i * 1000
  @course_Id = 397
  @course_Id = configatron.courseId unless configatron.courseId == nil

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

  @browser.goto(configatron.moodleURL + '/course/view.php?id=' + configatron.courseId)
  @Note = 'Updated Instructor Notes by automation ' + @currnetTimeStamp.to_s

  on CourseDetailPage do |page|

    case configatron.environment

      when 'Master-DEV'
        #For Moodle Build Version 3.1 (Build: 20160523)
        begin

            case context
              when 'site'
                @index = 0
              when 'course'
                @index = 1
              when 'personal'
                @index = 2
            end
          page.participants_old_link.wait_until_present
          page.participants_old_link.click
          page.participants_stud_link("sname_").wait_until_present
          page.participants_stud_link("sname_").click

          page.participants_notes_link.wait_until_present
          page.participants_notes_link.click

          page.participants_notes_edit_link(@index).wait_until_present
          page.participants_notes_edit_link(@index).click
            
          page.participants_notes_txt.wait_until_present
          page.participants_notes_txt.set @Note

          @addCommentStartTimeStamp = Time.new.to_i * 1000
          page.participants_notes_save_btn.click
        end

      when 'Master-PROD', 'Master-Staging'
        #For Moodle Build Version 3.2.3 (Build: 20170508)
        begin
          case context
            when 'site'
              @index = 0
            when 'course'
              @index = 1
            when 'personal'
              @index = 2
          end

          page.participants_link.wait_until_present
          page.participants_link.click
          page.participants_stud_link("sname_").wait_until_present
          page.participants_stud_link("sname_").click
          page.participants_notes_link.wait_until_present
          page.participants_notes_link.click

          page.participants_notes_edit_link(@index).wait_until_present
          page.participants_notes_edit_link(@index).click

          page.participants_notes_txt.wait_until_present
          page.participants_notes_txt.set @Note

          @addCommentStartTimeStamp = Time.new.to_i * 1000
          page.participants_notes_save_btn.click
        end

    end

  end

end

When(/^Note got Updated to a Participant as an instructor$/) do
  on AssignmentViewPage do |page|
    sleep(10)
    # Should Assert that it got successfully saved
  end
  @addCommentEndTimeStamp = Time.new.to_i * 1000
  moodle_logout
end

Then(/^Instructor Note Updation Event should get generated and sent to our Raw Event Index$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime
  @startTimeStamp = @addCommentStartTimeStamp
  @endTimeStamp = @addCommentEndTimeStamp

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"and\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}},{\"term\":{\"event.action\":\"http://purl.imsglobal.org/vocab/caliper/v1/action#Updated\"}}]}}}}"
  puts @query.to_json
  @response = post_request(@posturl,@query,@apitoken)

  puts @response.to_json

  @hits = @response['hits']['total']
  @hits.should == 1
end


And(/^Instructor Note Updation Event \['event'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Updation Event \['event'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/MessageEvent'$/) do
  @response['hits']['hits'][0]['_source']['event']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/MessageEvent'

end

And(/^Instructor Note Updation Event \['event'\]\.\['actor'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Updation Event \['event'\]\.\['actor'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/Person'$/) do
  @response['hits']['hits'][0]['_source']['event']['actor']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/Person'

end

And(/^Instructor Note Updation Event \['event'\]\.\['action'\] = 'http:\/\/purl\.imsglobal\.org\/vocab\/caliper\/v1\/action\#Updated'$/) do
  @response['hits']['hits'][0]['_source']['event']['action'].should == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Updated'

end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['@type'\] = 'h ttp:\/\/purl\.imsglobal\.org\/caliper\/v1\/Message'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/Message'

end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['body'\] = Provided Instructor Note$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['body'].should == @Note
end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'notes'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should  == 'notes'
end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['context'\] = '(.*?)'$/) do |context|

  case context
    when 'site'
      @contextValue = 'site'
    when 'course'
      @contextValue = 'public'
    when 'personal'
      @contextValue = 'draft'
  end

  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['context'].should  == "#{@contextValue}"
end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseSection'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'

end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['courseSection'\]\.\['subOrganizationOf'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/lis\/CourseOffering'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['courseSection']['subOrganizationOf']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'

end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'

end

And(/^Instructor Note Updation Event \['event'\]\.\['object'\]\.\['extensions'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
end

And(/^Instructor Note Updation Event \['event'\]\.\['edApp'\]\.\['@context'\] = 'http:\/\/purl\.imsglobal\.org\/ctx\/caliper\/v1\/Context'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@context'].should == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
end

And(/^Instructor Note Updation Event \['event'\]\.\['edApp'\]\.\['@type'\] = 'http:\/\/purl\.imsglobal\.org\/caliper\/v1\/SoftwareApplication'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['@type'].should == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'

end

And(/^Instructor Note Updation Event \['event'\]\.\['edApp'\]\.\['name'\] = 'IntellifyLearning'$/) do
  @response['hits']['hits'][0]['_source']['event']['edApp']['name'].should == 'IntellifyLearning'
end




