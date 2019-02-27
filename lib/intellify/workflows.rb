# Helper methods that don't properly belong elsewhere. This is
# a sort of "catch all" Module.
module Workflows

  def log_in(username,password)
    visit IntellifyLoginPage do |page|

      page.cookies.clear
      page.refresh
      page.intellify_login.wait_until_present
      page.intellify_login.set username
      page.intellify_password.set password
      page.login_button.click
    end
  end
  def log_inwb(username,password)
    visit IntellifyEssentialWBLoginPage do |page|
      page.cookies.clear
      page.intellify_login.set username
      page.intellify_password.set password
      page.login_button.click
    end
  end

  def workbench_logout
    visit WorkbenchHomepage do |page|
      page.image_intellify.visible?.should be_true
      page.sign_out.click
    end
  end

  def essentials_login(username,password)
    visit EssentialsLoginPage do |page|
      page.cookies.clear
      page.intellify_login.set username
      page.intellify_password.set password
      page.login_button.click
      sleep(10)
    end
  end

  def workbench_login(username,password)
    visit WorkbenchLoginPage do |page|
      page.cookies.clear
      page.workbench_username.send_keys username
      page.workbench_password.send_keys password
      page.workbench_login_btn.click
      sleep(10)
    end
  end

  def log_in_moodle(username,password)

    visit MoodleLoginPage do |page|
      page.cookies.clear
      page.login_link.wait_until_present
      page.login_link.click
      page.moodle_login.set username
      page.moodle_password.set password
      page.login_button.click
    end

  end

  def moodle_logout

    on MoodleHomePage do |page|
      page.error_continue_link.click if page.error_continue_link.exists?
      page.profile_dropdown.wait_until_present
      page.profile_dropdown_click
      page.moodle_logout_click
    end

  end

  def create_user(uname,pwd,role)

    visit CreateAndUpdateUserPage do |page|
      page.user_name.wait_until_present
      page.user_name.set uname
      page.password_link.click if page.password_link.exists?
      page.password.set pwd
      page.first_name.set uname+'_fname'
      page.last_name.set uname+'_lname'
      page.email.set uname+'_auto_qa@email.com'
      page.city.set 'Test City'
      page.country.select 'Canada'
      page.timezone.select 'America/Toronto'

      page.description.click
      page.description.send_keys [:control, 'a']
      page.description.send_keys 'Test Description'

      page.optional.click
      page.institution.set role
      page.department.set 'Test Department'
      page.phone.set '222-222-2222'
      page.mobile_phone.set '333-333-3333'
      page.address.set 'Test Address'

      page.submit_profile_button_click
    end
  end


  def update_user(uname)

    on BrowserListOfUsersPage do |page|
      if page.remove_all_button.exists?
        page.remove_all_button_click
      end
      page.user_full_name.set uname
      page.add_filter_button_click
      page.first_name_link.click
    end

    on UserProfilePage do |page|
      page.edit_profile_link_click
    end

    on CreateAndUpdateUserPage do |page|
      page.email.clear
      page.email.set uname+'_auto_qa_updated@email.com'
      page.submit_profile_button_click
    end

  end

  def get_user_id(uname)

    on BrowserListOfUsersPage do |page|
      if page.remove_all_button.exists?
        page.remove_all_button_click
      end
      page.user_full_name.set uname
      page.add_filter_button_click
      page.first_name_link.click
    end

    on UserProfilePage do |page|
      return page.url.split('?').last.split('=').last
    end

  end

  def enroll_user(uname, role)

    on EnrollUserPage do |page|
      page.enrol_users_button_clk
      sleep(2)

      if role == 'Instructor'
        page.role_select.option(:value => '3').select
      elsif role == 'Student'
        page.role_select.option(:value => '5').select
      end

      page.enrol_user_search.set uname
      sleep(3)
      page.search_button_clk
      sleep(3)
      page.enrol_button_clk
      sleep(3)
      page.finish_enrolling_users_button_clk
    end

  end

  def modify_user_enrollment(role)

    on EnrollUserPage do |page|

      page.assign_role_link_clk
      sleep(2)

      if role == 'Instructor'
        @browser.execute_script('arguments[0].scrollIntoView();', page.select_student_role_button)
        page.select_student_role_button_clk
        sleep(5)
      elsif role == 'Student'
        @browser.execute_script('arguments[0].scrollIntoView();', page.select_teacher_role_button)
        page.select_teacher_role_button_clk
        sleep(5)
      end

    end

  end

  def add_course_category (category_name, category_num)

    visit AddAndUpdateCourseCategoryPage do |page|
      page.category_name.wait_until_present
      page.category_name.set category_name
      page.category_num.set category_num

      page.submit_category_button_click
    end

  end

  def get_category_id

    on CouseManagmentPage do |page|
      return page.url.split('?').last.split('=').last
    end

  end

  def update_course_category (updated_category_num)

    on AddAndUpdateCourseCategoryPage do |page|
      page.category_num.wait_until_present
      page.category_num.clear
      page.category_num.set updated_category_num

      page.submit_category_button_click
    end

  end

  def get_item_id

    on CoursePagePage do |page|
      return page.url.split('?').last.split('=').last
    end

  end

  def track_course(course_name)

    @browser.goto(configatron.moodleURL+'/admin/settings.php?section=logsettingintellify')

    on IntellistoreDataCollectionSettingsPage do |page|
      @browser.send_keys :control
      page.course_list_select.select course_name
      page.save_changes_btn_clk
    end

  end

  def track_category(category_name)

    @browser.goto(configatron.moodleURL+'/admin/settings.php?section=logsettingintellify')

    on IntellistoreDataCollectionSettingsPage do |page|
      @browser.send_keys :control
      page.category_list_select.wait_until_present
      page.category_list_select.select category_name
      page.save_changes_btn_clk
    end

  end

  def track_tags(tag_name)

    @browser.goto(configatron.moodleURL+'/admin/settings.php?section=logsettingintellify')

    on IntellistoreDataCollectionSettingsPage do |page|
      @browser.send_keys :control
      page.tag_list_select.wait_until_present
      page.tag_list_select.select tag_name
      page.save_changes_btn_clk
    end

  end

  def load_lti
    visit LTIAutomationPage do |page|
      #page.goto 'https://automation.intellify.tools/lti/index.html'
      puts page.url

      # page.pdfauto.exists?.should be_true
      page.pdfauto.click

      # page.launchUrl.exists?.should be_true
      page.launchUrl.set 'https://master-staging.intellify.io/ltilaunch/561dc0fb0cf2bffa8004feff'
      page.key.set 'yScTs-BpQVaSg0PIlDlfzw'
      page.secret.set '22ab106d-52c7-418f-a35a-1b1adb3c43bc'
      page.cp1.set 'siteId'
      page.cpv1.set 'h900000031'
      page.cp2.set 'classId'
      page.cpv2.set 'pjg5omnv7r2hbk29le0p24b6_v8q9qq0'
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

  def get_course_id(coursename, categoryname)
    @coursename = coursename
    @categoryname = categoryname

    visit CouseManagmentPage do |page|
      puts "Getting Course Id for #{@coursename}"
      page.select_category_link(@categoryname).click
      page.course_name_link(@coursename).exists?.should be_true
      @getId = page.course_name_link(@coursename).attribute_value('href')
      @courseId = @getId.scan(/=(\w+)/).last
    end

    return @courseId[0].to_s
  end

  def delete_course(coursename, categoryname)
    @courseName = coursename
    @categoryname = categoryname
    @course_Id = get_course_id(@courseName, @categoryname)
    @browser.goto(configatron.moodleURL+"/course/delete.php?id=#{@course_Id}")
    on CourseDeletePage do |page|
      page.delete_button_clk
      sleep(10)
      page.continue_button_clk
    end

    on CouseManagmentPage do |page|
      page.create_course_link.exists?.should be_true
    end

  end

  def dc_creation(collectionname,sourcename)
    @collectionname = collectionname
    @sourcename = sourcename

    on WorkbenchDatastore do |page|
      page.datacollection_creation.click

    end


    on WorkbenchDatacollection do |page|
      page.org_name.set "#{collectionname}"
      page.update_btn.click
      sleep(5)
      configatron.datacollectWB_uuid = page.uuid
      return configatron.datacollectWB_uuid
    end
  end


  #Method to get the API Token
  def get_apitoken(hostname,username,password)
    @posturl = "https://#{hostname}/user/apiToken"
    @esQuery = "{\"username\": \"#{username}\",\"password\": \"#{password}\"}"
    response = RestClient.post @posturl,@esQuery, :content_type => :json, :accept => :json
    @data = JSON.parse response.body
    token = @data['apiToken']
    return token
  end

  def get_request(url,apitoken)
    @bearerToken =  "bearer " + apitoken

    response = RestClient.get url,:content_type => :json, :accept => :json, :Authorization => @bearerToken
    @data = JSON.parse response.body

    return @data
  end

  #method for CSV response body
  def get_csvrequest(url,apitoken)
    @bearerToken =  "bearer " + apitoken

    response = RestClient.get url,:content_type => :json, :accept => :csv, :Authorization => @bearerToken
    @data = CSV.parse response.body

    return @data
  end

  #Method for a POST Request and return the response body
  def post_request(posturl,query,apitoken)
    @bearerToken =  "bearer " + apitoken

    response = RestClient.post posturl,query, :content_type => :json, :accept => :json, :Authorization => @bearerToken
    @data = JSON.parse response.body

    return @data
  end

  def post_csv_request(posturl,query,apitoken)
    @bearerToken =  "bearer " + apitoken

    response = RestClient.post posturl,query, :content_type => :json, :Authorization => @bearerToken
    response.force_encoding('utf-8')
    csv = CSV.parse(response.body, {headers: true})

    @data = csv.map(&:to_h).to_json

    return @data
  end

  def delete_request(url,apitoken)
    @bearerToken =  "bearer " + apitoken
    RestClient.delete url,:content_type => :json, :accept => :json, :Authorization => @bearerToken
  end

  #Method for a PUT Request to send Events and Entities
  def put_request(posturl,query)
    response = RestClient.put posturl,query, :content_type => :json, :accept => :json
    @data = JSON.parse response.body
    return @data
  end

  #API Automation Support Methods

  #Method for a PUT Request it return the Response body  , Status and Response Headers

  def put_request_api(puturl,query,apitoken)
    @bearerToken =  "bearer " + apitoken

    begin
      response = RestClient.put puturl,query, :content_type => :json, :accept => :json, :Authorization => @bearerToken
    rescue RestClient::ExceptionWithResponse => error
      if error != nil then
        begin
          @responsedata = JSON.parse error.response.body
        rescue JSON::ParserError => e
          @responsedata = e
        end
        @status =  error.response.code
        @headers =  error.response.headers
      end
    end

    if error == nil then
      begin
        @responsedata = JSON.parse response.body
      rescue JSON::ParserError => e
        @responsedata = response.body
      end
      @status = response.code
      @headers = response.headers

    end
    # Print the API Test Details in the Report
    puts "<b>PUT URL : </b> #{puturl}"
    puts "<b>PUT Request Query : </b> #{query}"
    puts "<b>Status Code: </b>" + @status.to_s
    puts "<b>Responce Body: </b>" + @responsedata.to_json
    puts "<b>Responce Header: </b>" + @headers.to_json
    return @status , @responsedata , @headers
  end

  #Method for a POST Request and return the Response body  , Status and Response Headers

  def post_request_api(posturl,query,apitoken)
    @bearerToken =  "bearer " + apitoken

    begin
      response = RestClient.post posturl,query, :content_type => :json, :accept => :json, :Authorization => @bearerToken
    rescue RestClient::ExceptionWithResponse => error
      if error != nil then
        begin
          @responsedata = JSON.parse error.response.body
        rescue JSON::ParserError => e
          @responsedata = e
        end
        @status =  error.response.code
        @headers =  error.response.headers
      end
    end

    if error == nil then
      begin
        @responsedata = JSON.parse response.body
      rescue JSON::ParserError => e
        @responsedata = response.body
      end
      @status = response.code
      @headers = response.headers
    end

    # Print the API Test Details in the Report
    puts "<b>POST URL : </b> #{posturl}"
    puts "<b>POST Request Query : </b> #{query}"
    puts "<b>Status Code: </b>" + @status.to_s
    puts "<b>Responce Body: </b>" + @responsedata.to_json
    puts "<b>Responce Header: </b>" + @headers.to_json

    return @status , @responsedata , @headers
  end


  #Method for a GET Request and return the Response body  , Status and Response Headers

  def get_request_api(geturl,apitoken)
    @bearerToken =  "bearer " + apitoken

    begin
      response = RestClient.get geturl, :content_type => :json, :accept => :json, :Authorization => @bearerToken
    rescue RestClient::ExceptionWithResponse => error
      if error != nil then
        begin
        @responsedata = JSON.parse error.response.body
        rescue JSON::ParserError => e
          @responsedata = e
        end
        @status =  error.response.code
        @headers =  error.response.headers
      end
    end

    if error == nil then
      begin
        @responsedata = JSON.parse response.body
      rescue JSON::ParserError => e
        @responsedata = response.body
      end
      @status = response.code
      @headers = response.headers
    end
    # Print the API Test Details in the Report
    puts "<b>GET URL : </b> #{geturl}"
    puts "<b>Status Code: </b>" + @status.to_s
    puts "<b>Responce Body: </b>" + @responsedata.to_json
    puts "<b>Responce Header: </b>" + @headers.to_json

    return @status , @responsedata , @headers
  end

  #Method for a DELETE Request and return the Response body  , Status and Response Headers

  def delete_request_api(deleteurl,apitoken)
    @bearerToken =  "bearer " + apitoken

    begin
      response = RestClient.delete deleteurl, :content_type => :json, :accept => :json, :Authorization => @bearerToken
    rescue RestClient::ExceptionWithResponse => error
      if error != nil then
        begin
          @responsedata = JSON.parse error.response.body
        rescue JSON::ParserError => e
          @responsedata = e
        end
        @status =  error.response.code
        @headers =  error.response.headers
      end
    end

    if error == nil then
      begin
      @responsedata = JSON.parse response.body
      rescue JSON::ParserError => e
        @responsedata = response.body
      end
      @status = response.code
      @headers = response.headers
    end
    # Print the API Test Details in the Report
    puts "<b>DETETE URL : </b> #{deleteurl}"
    puts "<b>Status Code: </b>" + @status.to_s
    puts "<b>Responce Body: </b>" + @responsedata.to_json
    puts "<b>Responce Header: </b>" + @headers.to_json

    return @status , @responsedata , @headers
  end


end
