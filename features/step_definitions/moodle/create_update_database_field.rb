Given(/^Create a New Database Field under Database for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @database_id = configatron.database_id
  @fieldName = 'Database Field Name_' + @currnetTimeStamp.to_s
  @fieldDescription = 'Database Field Description_' + @currnetTimeStamp.to_s
  configatron.databasefieldname = @fieldName
  configatron.databasefielddescription = @fieldDescription

  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)

  @browser.goto(configatron.moodleURL+'/mod/data/view.php?id='+@database_id)


  on CourseDatabasePage do |page|
    page.fields_link.wait_until_present
    page.fields_link.click
    page.create_new_field_select.wait_until_present
    @createDatabaseFieldStartTimeStamp = Time.new.to_i * 1000
    page.create_new_field_select.select 'Text input'

    page.text_field_name_txt.click
    page.text_field_name_txt.send_keys [:control, 'a']
    page.text_field_name_txt.send_keys @fieldName

    page.text_field_description_txt.click
    page.text_field_description_txt.send_keys [:control, 'a']
    page.text_field_description_txt.send_keys @fieldDescription

    page.required_chkbox.click
    page.add_btn.click
    sleep(configatron.eventWaitTime)
    @createDatabaseFieldEndTimeStamp = Time.new.to_i * 1000

  end
end

When(/^The New Database Field got successfully created$/) do

  on CourseDatabasePage do |page|
    page.success_msg_txt.wait_until_present
    page.success_msg_txt.text.include? 'Field added'
  end

  moodle_logout
end

Then(/^An Event for New Database Field should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @createDatabaseFieldStartTimeStamp
  @endTimeStamp = @createDatabaseFieldEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.fieldType\":\"data_fields\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']

  @hits.should == 1
end

And(/^The \['event'\]\.\['object'\]\.\['extensions'\]\.\['moduleType'\] = 'data'$/) do
  @response['hits']['hits'][0]['_source']['event']['object']['extensions']['moduleType'].should == 'data'
end

And(/^The \['event'\]\.\['generated'\]\.\['extensions'\]\.\['moduleType'\] = 'data_field'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['moduleType'].should == 'data_field'
end

And(/^The \['event'\]\.\['generated'\]\.\['extensions'\]\.\['fieldType'\] = 'data_fields'$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['fieldType'].should == 'data_fields'
end

And(/^The \['event'\]\.\['generated'\]\.\['extensions'\]\.\['fieldName'\] = Provided Field Name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['fieldName'].should == configatron.databasefieldname
end

And(/^The \['event'\]\.\['generated'\]\.\['extensions'\]\.\['fieldDescription'\] = Provided Field Description$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['fieldDescription'].should == configatron.databasefielddescription
end

Given(/^Update an Existing Database Field under Database for a course$/) do
  @currnetTimeStamp = Time.new.to_i * 1000
  @database_id = configatron.database_id
  @fieldName = 'Database Field Name Updated_' + @currnetTimeStamp.to_s
  @fieldDescription = 'Database Field Description Updated_' + @currnetTimeStamp.to_s
  configatron.databasefieldnameupdated = @fieldName
  configatron.databasefielddescriptionupdated = @fieldDescription

  @username = configatron.autoTeacherUsername
  @password = configatron.autoTeacherPassword
  log_in_moodle(@username,@password)

  @browser.goto(configatron.moodleURL+'/mod/data/view.php?id='+@database_id)


  on CourseDatabasePage do |page|
    page.fields_link.wait_until_present
    page.fields_link.click
    page.edit_btn.wait_until_present
    @updateDatabaseFieldStartTimeStamp = Time.new.to_i * 1000
    page.edit_btn.click

    page.text_field_name_txt.click
    page.text_field_name_txt.send_keys [:control, 'a']
    page.text_field_name_txt.send_keys @fieldName

    page.text_field_description_txt.click
    page.text_field_description_txt.send_keys [:control, 'a']
    page.text_field_description_txt.send_keys @fieldDescription

    page.required_chkbox.click
    page.add_btn.wait_until_present
    page.add_btn.click
    sleep(configatron.eventWaitTime)
    @updateDatabaseFieldEndTimeStamp = Time.new.to_i * 1000

  end
end

When(/^The Existing Database Field got successfully updated$/) do

  on CourseDatabasePage do |page|
    page.success_msg_txt.wait_until_present
    page.success_msg_txt.text.include? 'Field updated'
  end
  moodle_logout
end

Then(/^An Event for Update Database Field should get generated and sent to our Raw Event Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEventStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @updateDatabaseFieldStartTimeStamp
  @endTimeStamp = @updateDatabaseFieldEndTimeStamp

  @query = "{\"query\":{\"bool\":{\"must\":[{\"match\":{\"event.generated.extensions.fieldType\":\"data_fields\"}},{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}},\"size\":2,\"from\":0}"
  puts @query

  @response = post_request(@posturl,@query,@apitoken)

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end

And(/^The \['event'\]\.\['generated'\]\.\['extensions'\]\.\['fieldName'\] = Updated Field Name$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['fieldName'].should == configatron.databasefieldnameupdated
end

And(/^The \['event'\]\.\['generated'\]\.\['extensions'\]\.\['fieldDescription'\] = Updated Field Description$/) do
  @response['hits']['hits'][0]['_source']['event']['generated']['extensions']['fieldDescription'].should == configatron.databasefielddescriptionupdated
end
