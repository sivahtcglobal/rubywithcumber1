Given(/^Created a New  (.*) type Question Page for a Lesson$/) do |type|
  @currnetTimeStamp = Time.new.to_i * 1000
  @lessonId = 38
  @lessonId = configatron.lessonId unless configatron.lessonId == nil

  on MoodleHomePage do |page|
    if page.automation_site_admin.exists? then
      #do nothing
    else
      @username = configatron.autoTeacherUsername
      @password = configatron.autoTeacherPassword
      log_in_moodle(@username,@password)

    end
  end

  on CreateAndUpdateQuestionPage do |page|
  case type
    when 'Essay' then

      @title = "essay" + @currnetTimeStamp.to_s
      @essayContent = "essay" + @currnetTimeStamp.to_s
      @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?pageid=0&id="+@lessonId.to_s+"&qtype=10")
      page.page_title_txt.set @title
      page.page_content_editor.exists?.should be_true
      page.page_content_editor.send_keys "Automated Essay Question Page Content"
      page.essay_page_jump_select.select 'Next page'
      page.essay_page_score_txt.set 15
      page.add_question_page_btn_clk

    when 'Matching' then

      @title = "Matching" + @currnetTimeStamp.to_s
      @essayContent = "Matching" + @currnetTimeStamp.to_s
      @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?pageid=0&id="+@lessonId.to_s+"&qtype=5")
      page.page_title_txt.set @title
      page.page_content_editor.exists?.should be_true
      page.page_content_editor.send_keys "Automated Matching Question Page Content"

      page.correct_response_link.click
      page.correct_response_content_editor.send_keys "Correct Response Created using automation"

      page.wrong_response_link.click
      page.wrong_response_content_editor.send_keys "Wrong Response Created using automation"
      page.wrong_page_jump_select.select 'Next page'
      page.wrong_page_score_txt.set 25
      if page.matching_pair_1_content_editor.visible? then
        #do nothing
      else
        page.matching_pair_1_link.click
      end

      page.matching_pair_1_content_editor.send_keys "Automation Question 1"
      page.matching_pair_1_answer_txt.set "Matching Pari answer"


      if page.matching_pair_2_content_editor.visible? then
        #do nothing
      else
        page.matching_pair_2_link.click
      end
      page.matching_pair_2_content_editor.send_keys "Automation Question 2"
      page.matching_pair_2_answer_txt.set "Matching Pari answer"

      if page.matching_pair_3_content_editor.visible? then
        #do nothing
      else
        page.matching_pair_3_link.click
      end
      page.matching_pair_3_content_editor.send_keys "Automation Question 3"
      page.matching_pair_3_answer_txt.set "Matching Pari answer"

      if page.matching_pair_4_content_editor.visible? then
        #do nothing
      else
        page.matching_pair_4_link.click
      end
      page.matching_pair_4_content_editor.send_keys "Automation Question 4"
      page.matching_pair_4_answer_txt.set "Matching Pari answer"

      if page.matching_pair_5_content_editor.visible? then
        #do nothing
      else
        page.matching_pair_5_link.click
      end
      page.matching_pair_5_content_editor.send_keys "Automation Question 5"
      page.matching_pair_5_answer_txt.set "Matching Pari answer"


      page.add_question_page_btn_clk


    when 'Multichoice' then

      @title = "Multichoice" + @currnetTimeStamp.to_s

      @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?pageid=0&id="+@lessonId.to_s+"&qtype=3")
      page.page_title_txt.set @title
      page.page_content_editor.send_keys "Automated Multichoice Question Page Content"
      page.multiple_answer_option_chk.click

      if page.answer1_content_editor.visible? then
        #do nothing
      else
        page.answer1_link.click
      end

      page.answer1_content_editor.send_keys 'Multichoice Answer 1'
      page.answer1_response_editor.send_keys 'Multichoice response 1'
      page.answer1_page_jump_select.select  'Next page'
      page.answer1_page_score_txt.set 10

      if page.answer2_content_editor.visible? then
        #do nothing
      else
        page.answer2_link.click
      end
      page.answer2_content_editor.send_keys 'Multichoice Answer 2'
      page.answer2_response_editor.send_keys 'Multichoice response 2'
      page.answer2_page_jump_select.select  'Next page'
      page.answer2_page_score_txt.set 10

      if page.answer3_content_editor.visible? then
        #do nothing
      else
        page.answer3_link.click
      end
      page.answer3_content_editor.send_keys 'Multichoice Answer 3'
      page.answer3_response_editor.send_keys 'Multichoice response 3'
      page.answer3_page_jump_select.select  'Next page'
      page.answer3_page_score_txt.set 10

      if page.answer4_content_editor.visible? then
        #do nothing
      else
        page.answer4_link.click
      end
      page.answer4_content_editor.send_keys 'Multichoice Answer 4'
      page.answer4_response_editor.send_keys 'Multichoice response 4'
      page.answer4_page_jump_select.select  'Next page'
      page.answer4_page_score_txt.set 10

      if page.answer5_content_editor.visible? then
        #do nothing
      else
        page.answer5_link.click
      end
      page.answer5_content_editor.send_keys 'Multichoice Answer 5'
      page.answer5_response_editor.send_keys 'Multichoice response 5'
      page.answer5_page_jump_select.select  'Next page'
      page.answer5_page_score_txt.set 10

      page.add_question_page_btn_clk

    when 'Numerical' then

      @title = "Numerical" + @currnetTimeStamp.to_s
      @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?pageid=0&id="+@lessonId.to_s+"&qtype=8")
      page.page_title_txt.set @title
      page.page_content_editor.send_keys "Automated Numerical Question Page Content"

      if page.answer1_content_txt.visible? then
        #do nothing
      else
        page.answer1_link.click
      end
      page.answer1_content_txt.set 'Numerical Answer 1'
      page.answer1_response_editor.send_keys 'Numerical response 1'
      page.answer1_page_jump_select.select  'Next page'
      page.answer1_page_score_txt.set 10

      if page.answer2_content_txt.visible? then
        #do nothing
      else
        page.answer2_link.click
      end
      page.answer2_content_txt.set 'Numerical Answer 2'
      page.answer2_response_editor.send_keys 'Numerical response 2'
      page.answer2_page_jump_select.select  'Next page'
      page.answer2_page_score_txt.set 10

      if page.answer3_content_txt.visible? then
        #do nothing
      else
        page.answer3_link.click
      end
      page.answer3_content_txt.set 'Numerical Answer 3'
      page.answer3_response_editor.send_keys 'Numerical response 3'
      page.answer3_page_jump_select.select  'Next page'
      page.answer3_page_score_txt.set 10

      if page.answer4_content_txt.visible? then
        #do nothing
      else
        page.answer4_link.click
      end
      page.answer4_content_txt.set 'Numerical Answer 4'
      page.answer4_response_editor.send_keys 'Numerical response 4'
      page.answer4_page_jump_select.select  'Next page'
      page.answer4_page_score_txt.set 10

      if page.answer5_content_txt.visible? then
        #do nothing
      else
        page.answer5_link.click
      end
      page.answer5_content_txt.set 'Numerical Answer 5'
      page.answer5_response_editor.send_keys 'Numerical response 5'
      page.answer5_page_jump_select.select  'Next page'
      page.answer5_page_score_txt.set 10

      page.add_question_page_btn_clk


    when 'Short answer' then

      @title = "Short answer" + @currnetTimeStamp.to_s
      @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?pageid=0&id="+@lessonId.to_s+"&qtype=1")
      page.page_title_txt.set @title
      page.page_content_editor.send_keys "Automated Short answer Question Page Content"
      page.use_regular_expression_chk.click

      page.answer1_link.click unless page.answer1_content_txt.visible?

      page.answer1_content_txt.set 'Short answer Answer 1'
      page.answer1_response_editor.send_keys 'Short answer response 1'
      page.answer1_page_jump_select.select  'Next page'
      page.answer1_page_score_txt.set 10

      page.answer2_link.click unless page.answer2_content_txt.visible?

      page.answer2_content_txt.set 'Short answer Answer 2'
      page.answer2_response_editor.send_keys 'Short answer response 2'
      page.answer2_page_jump_select.select  'Next page'
      page.answer2_page_score_txt.set 10

      page.answer3_link.click unless page.answer3_content_txt.visible?

      page.answer3_content_txt.set 'Short answer Answer 3'
      page.answer3_response_editor.send_keys 'Short answer response 3'
      page.answer3_page_jump_select.select  'Next page'
      page.answer3_page_score_txt.set 10

      page.answer4_link.click unless page.answer4_content_txt.visible?
      page.answer4_content_txt.set 'Short answer Answer 4'
      page.answer4_response_editor.send_keys 'Short answer response 4'
      page.answer4_page_jump_select.select  'Next page'
      page.answer4_page_score_txt.set 10

      page.answer5_link.click unless page.answer5_content_txt.visible?
      page.answer5_content_txt.set 'Short answer Answer 5'
      page.answer5_response_editor.send_keys 'Short answer response 5'
      page.answer5_page_jump_select.select  'Next page'
      page.answer5_page_score_txt.set 10

      page.add_question_page_btn_clk


    when 'True/false' then

      @title = "True/false" + @currnetTimeStamp.to_s
      @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?pageid=0&id="+@lessonId.to_s+"&qtype=2")
      page.page_title_txt.set @title
      page.page_content_editor.send_keys "Automated True/false Question Page Content"

      if page.answer1_content_editor.visible? then
        #do nothing
      else
        page.answer1_link.click
      end
      page.answer1_content_editor.send_keys 'True/false Answer 1'
      page.answer1_response_editor.send_keys 'True/false response 1'
      page.answer1_page_jump_select.select  'Next page'
      page.answer1_page_score_txt.set 10

      if page.answer2_content_editor.visible? then
        #do nothing
      else
        page.answer2_link.click
      end
      page.answer2_content_editor.send_keys 'True/false Answer 2'
      page.answer2_response_editor.send_keys 'True/false response 2'
      page.answer2_page_jump_select.select  'Next page'
      page.answer2_page_score_txt.set 10
      page.add_question_page_btn_clk
  end
end

end

When(/^The New Question Pag Got successfully created$/) do
  on CreateAndUpdateQuestionPage do |page|
   sleep(10)
   page.get_pageid_element(@title).exists?.should be_true
   puts page.get_pageid_element(@title).html
   @quizLink =  page.get_pageid_element(@title).attribute_value('href')
   puts @quizLink
   @quizPageId = @quizLink.scan(/pageid=(\w+)/).last
   puts @quizPageId[0]
  end
  configatron.quizPageId << @quizPageId[0]
  moodle_logout
end

Then(/^A Entity for New Question Page should get generated and sent to our Raw Entity Index\.$/) do

  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  # puts @response

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1

end


Given(/^Updated the (.*) type Created Question Page for the Lesson$/) do |type|
  @lessonId = 131
  @pageId = configatron.quizPageId[0]
  puts @pageId
  @currnetTimeStamp = Time.new.to_i * 1000
  on MoodleHomePage do |page|
    if page.automation_site_admin.exists? then
      #do nothing
    else
      @username = configatron.autoTeacherUsername
      @password = configatron.autoTeacherPassword
      log_in_moodle(@username,@password)
    end
  end

  on CreateAndUpdateQuestionPage do |page|
    case type
      when 'Essay' then

        @title = "essay" + @currnetTimeStamp.to_s
        @essayContent = "essay" + @currnetTimeStamp.to_s
        @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?id="+@lessonId.to_s+"&pageid="+configatron.quizPageId[0]+"&edit=1")
        page.page_title_txt.set @title
        page.page_content_editor.exists?.should be_true
        page.page_content_editor.send_keys "Automated Essay Question Page Content"
        page.essay_page_jump_select.select 'Next page'
        page.essay_page_score_txt.set 15
        page.add_question_page_btn_clk

      when 'Matching' then

        @title = "Matching" + @currnetTimeStamp.to_s
        @essayContent = "Matching" + @currnetTimeStamp.to_s
        @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?id="+@lessonId.to_s+"&pageid="+configatron.quizPageId[1]+"&edit=1")
        page.page_title_txt.set @title
        page.page_content_editor.exists?.should be_true
        page.page_content_editor.send_keys "Automated Matching Question Page Content"

        page.correct_response_link.click
        page.correct_response_content_editor.send_keys "Correct Response Created using automation"

        page.wrong_response_link.click
        page.wrong_response_content_editor.send_keys "Wrong Response Created using automation"
        page.wrong_page_jump_select.select 'Next page'
        page.wrong_page_score_txt.set 25
        if page.matching_pair_1_content_editor.visible? then
          #do nothing
        else
          page.matching_pair_1_link.click
        end

        page.matching_pair_1_content_editor.send_keys "Automation Question 1"
        page.matching_pair_1_answer_txt.set "Matching Pari answer"


        if page.matching_pair_2_content_editor.visible? then
          #do nothing
        else
          page.matching_pair_2_link.click
        end
        page.matching_pair_2_content_editor.send_keys "Automation Question 2"
        page.matching_pair_2_answer_txt.set "Matching Pari answer"

        if page.matching_pair_3_content_editor.visible? then
          #do nothing
        else
          page.matching_pair_3_link.click
        end
        page.matching_pair_3_link.click
        page.matching_pair_3_content_editor.send_keys "Automation Question 3"
        page.matching_pair_3_answer_txt.set "Matching Pari answer"

        if page.matching_pair_4_content_editor.visible? then
          #do nothing
        else
          page.matching_pair_4_link.click
        end
        page.matching_pair_4_content_editor.send_keys "Automation Question 4"
        page.matching_pair_4_answer_txt.set "Matching Pari answer"

        if page.matching_pair_5_content_editor.visible? then
          #do nothing
        else
          page.matching_pair_5_link.click
        end
        page.matching_pair_5_content_editor.send_keys "Automation Question 5"
        page.matching_pair_5_answer_txt.set "Matching Pari answer"


        page.add_question_page_btn_clk


      when 'Multichoice' then

        @title = "Multichoice" + @currnetTimeStamp.to_s

        @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?id="+@lessonId.to_s+"&pageid="+configatron.quizPageId[2]+"&edit=1")
        page.page_title_txt.set @title
        page.page_content_editor.send_keys "Automated Multichoice Question Page Content"
        page.multiple_answer_option_chk.click

        if page.answer1_content_editor.visible? then
          #do nothing
        else
          page.answer1_link.click
        end

        page.answer1_content_editor.send_keys 'Multichoice Answer 1'
        page.answer1_response_editor.send_keys 'Multichoice response 1'
        page.answer1_page_jump_select.select  'Next page'
        page.answer1_page_score_txt.set 10

        if page.answer2_content_editor.visible? then
          #do nothing
        else
          page.answer2_link.click
        end
        page.answer2_content_editor.send_keys 'Multichoice Answer 2'
        page.answer2_response_editor.send_keys 'Multichoice response 2'
        page.answer2_page_jump_select.select  'Next page'
        page.answer2_page_score_txt.set 10

        if page.answer3_content_editor.visible? then
          #do nothing
        else
          page.answer3_link.click
        end
        page.answer3_content_editor.send_keys 'Multichoice Answer 3'
        page.answer3_response_editor.send_keys 'Multichoice response 3'
        page.answer3_page_jump_select.select  'Next page'
        page.answer3_page_score_txt.set 10

        if page.answer4_content_editor.visible? then
          #do nothing
        else
          page.answer4_link.click
        end
        page.answer4_content_editor.send_keys 'Multichoice Answer 4'
        page.answer4_response_editor.send_keys 'Multichoice response 4'
        page.answer4_page_jump_select.select  'Next page'
        page.answer4_page_score_txt.set 10

        if page.answer5_content_editor.visible? then
          #do nothing
        else
          page.answer5_link.click
        end
        page.answer5_content_editor.send_keys 'Multichoice Answer 5'
        page.answer5_response_editor.send_keys 'Multichoice response 5'
        page.answer5_page_jump_select.select  'Next page'
        page.answer5_page_score_txt.set 10

        page.add_question_page_btn_clk

      when 'Numerical' then

        @title = "Numerical" + @currnetTimeStamp.to_s
        @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?id="+@lessonId.to_s+"&pageid="+configatron.quizPageId[3]+"&edit=1")
        page.page_title_txt.set @title
        page.page_content_editor.send_keys "Automated Numerical Question Page Content"

        if page.answer1_content_txt.visible? then
          #do nothing
        else
          page.answer1_link.click
        end
        page.answer1_content_txt.set 'Numerical Answer 1'
        page.answer1_response_editor.send_keys 'Numerical response 1'
        page.answer1_page_jump_select.select  'Next page'
        page.answer1_page_score_txt.set 10

        if page.answer2_content_txt.visible? then
          #do nothing
        else
          page.answer2_link.click
        end
        page.answer2_content_txt.set 'Numerical Answer 2'
        page.answer2_response_editor.send_keys 'Numerical response 2'
        page.answer2_page_jump_select.select  'Next page'
        page.answer2_page_score_txt.set 10

        if page.answer3_content_txt.visible? then
          #do nothing
        else
          page.answer3_link.click
        end
        page.answer3_content_txt.set 'Numerical Answer 3'
        page.answer3_response_editor.send_keys 'Numerical response 3'
        page.answer3_page_jump_select.select  'Next page'
        page.answer3_page_score_txt.set 10

        if page.answer4_content_txt.visible? then
          #do nothing
        else
          page.answer4_link.click
        end
        page.answer4_content_txt.set 'Numerical Answer 4'
        page.answer4_response_editor.send_keys 'Numerical response 4'
        page.answer4_page_jump_select.select  'Next page'
        page.answer4_page_score_txt.set 10

        if page.answer5_content_txt.visible? then
          #do nothing
        else
          page.answer5_link.click
        end
        page.answer5_content_txt.set 'Numerical Answer 5'
        page.answer5_response_editor.send_keys 'Numerical response 5'
        page.answer5_page_jump_select.select  'Next page'
        page.answer5_page_score_txt.set 10

        page.add_question_page_btn_clk


      when 'Short answer' then

        @title = "Short answer" + @currnetTimeStamp.to_s
        @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?id="+@lessonId.to_s+"&pageid="+configatron.quizPageId[4]+"&edit=1")
        page.page_title_txt.set @title
        page.page_content_editor.send_keys "Automated Short answer Question Page Content"
        page.use_regular_expression_chk.click

        if page.answer1_content_txt.visible? then
          #do nothing
        else
          page.answer1_link.click
        end
        page.answer1_content_txt.set 'Short answer Answer 1'
        page.answer1_response_editor.send_keys 'Short answer response 1'
        page.answer1_page_jump_select.select  'Next page'
        page.answer1_page_score_txt.set 10

        if page.answer2_content_txt.visible? then
          #do nothing
        else
          page.answer2_link.click
        end
        page.answer2_content_txt.set 'Short answer Answer 2'
        page.answer2_response_editor.send_keys 'Short answer response 2'
        page.answer2_page_jump_select.select  'Next page'
        page.answer2_page_score_txt.set 10

        if page.answer3_content_txt.visible? then
          #do nothing
        else
          page.answer3_link.click
        end
        page.answer3_content_txt.set 'Short answer Answer 3'
        page.answer3_response_editor.send_keys 'Short answer response 3'
        page.answer3_page_jump_select.select  'Next page'
        page.answer3_page_score_txt.set 10

        if page.answer4_content_txt.visible? then
          #do nothing
        else
          page.answer4_link.click
        end
        page.answer4_content_txt.set 'Short answer Answer 4'
        page.answer4_response_editor.send_keys 'Short answer response 4'
        page.answer4_page_jump_select.select  'Next page'
        page.answer4_page_score_txt.set 10

        if page.answer5_content_txt.visible? then
          #do nothing
        else
          page.answer5_link.click
        end
        page.answer5_content_txt.set 'Short answer Answer 5'
        page.answer5_response_editor.send_keys 'Short answer response 5'
        page.answer5_page_jump_select.select  'Next page'
        page.answer5_page_score_txt.set 10

        page.add_question_page_btn_clk


      when 'True/false' then

        @title = "True/false" + @currnetTimeStamp.to_s
        @browser.goto(configatron.moodleURL+"/mod/lesson/editpage.php?id="+@lessonId.to_s+"&pageid="+configatron.quizPageId[5]+"&edit=1")
        page.page_title_txt.set @title
        page.page_content_editor.send_keys "Automated True/false Question Page Content"

        if page.answer1_content_editor.visible? then
          #do nothing
        else
          page.answer1_link.click
        end
        page.answer1_content_editor.send_keys 'True/false Answer 1'
        page.answer1_response_editor.send_keys 'True/false response 1'
        page.answer1_page_jump_select.select  'Next page'
        page.answer1_page_score_txt.set 10

        if page.answer2_content_editor.visible? then
          #do nothing
        else
          page.answer2_link.click
        end
        page.answer2_content_editor.send_keys 'True/false Answer 2'
        page.answer2_response_editor.send_keys 'True/false response 2'
        page.answer2_page_jump_select.select  'Next page'
        page.answer2_page_score_txt.set 10
        page.add_question_page_btn_clk
    end
  end
end

When(/^The Question Page Got successfully Updated$/) do
  sleep(5)
  moodle_logout
end

Then(/^A Entity for Update Question Page should get generated and sent to our Raw Entity Index\.$/) do
  ENV['TZ'] = 'UTC'
  #Get API Token for Preceding POST Requests
  @tokenhost = configatron.moodleWorkbench
  @tokenuser = configatron.tokenuser
  @tokenpass = configatron.tokenpass
  @intellistream = configatron.moodleEntityStream
  @apitoken =  get_apitoken(@tokenhost,@tokenuser,@tokenpass)
  @posturl = File.join('https://',@tokenhost,'/intellisearch/',@intellistream,'/_search')
  @streamDelayTime = configatron.streamDelayTime

  @startTimeStamp = @currnetTimeStamp
  sleep(10)
  @endTimeStamp = Time.new.to_i * 1000

  @query = "{\"query\":{\"filtered\":{\"filter\":{\"bool\":{\"must\":[{\"range\":{\"timestamp\":{\"gte\":#{@startTimeStamp},\"lte\":#{@endTimeStamp}}}}]}}}},\"size\":2,\"from\":0}"

  @response = post_request(@posturl,@query,@apitoken)

  # puts @response

  @hits = @response['hits']['total']
  # @hits.should_not == 0
  @hits.should == 1
end