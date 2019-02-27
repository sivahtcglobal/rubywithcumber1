class CreateAndUpdateQuizPage < BasePage

  element(:quiz_showmore_link) { |b| b.a(text:"Show more...")}
  element(:quiz_showless_link) { |b| b.a(text:"Show less...")}
  element(:general_quiz_page_link) { |b| b.a(text:"General")}

  element(:quiz_name_txt) { |b| b.text_field(id:"id_name")}
  element(:quiz_description_editor) { |b| b.div(id:"id_introeditoreditable")}
  action(:quiz_description_display_chk) { |b| b.input(id:"id_showdescription")}

  #
  element(:timing_quiz_page_link) { |b| b.a(text:"Timing")}
  element(:quiz_timeopen_chkbox) { |b| b.input(id:"id_timeopen_enabled")}
  element(:quiz_timeclose_chkbox) { |b| b.input(id:"id_timeclose_enabled")}
  #Open Date Configuring
  element(:timeopen_day_select) { |b| b.select_list(id:"id_timeopen_day")}
  element(:timeopen_month_select) { |b| b.select_list(id:"id_timeopen_month")}
  element(:timeopen_year_select) { |b| b.select_list(id:"id_timeopen_year")}
  element(:timeopen_hour_select) { |b| b.select_list(id:"id_timeopen_hour")}
  element(:timeopen_minute_select) { |b| b.select_list(id:"id_timeopen_minute")}
  #Close Date Configuring
  element(:timeclose_day_select) { |b| b.select_list(id:"id_timeclose_day")}
  element(:timeclose_month_select) { |b| b.select_list(id:"id_timeclose_month")}
  element(:timeclose_year_select) { |b| b.select_list(id:"id_timeclose_year")}
  element(:timeclose_hour_select) { |b| b.select_list(id:"id_timeclose_hour")}
  element(:timeclose_minute_select) { |b| b.select_list(id:"id_timeclose_minute")}

  #Time Limit
  element(:quiz_timelimit_chkbox) { |b| b.input(id:"id_timelimit_enabled")}
  element(:quiz_timelimit_txt) { |b| b.text_field(id:"id_timelimit_number")}
  element(:quiz_timelimit_unit_select) { |b| b.select(id:"id_timelimit_timeunit")}
  #weeks
  #days
  #hours
  #minutes
  #seconds
  element(:quiz_overdue_select) { |b| b.select(id:"id_overduehandling")}
  #Open attempts are submitted automatically
  #There is a grace period when open attempts can be submitted, but no more questions answered
  #Attempts must be submitted before time expires, or they are not counted

  #Grace period
  element(:quiz_graceperiod_chkbox) { |b| b.input(id:"id_graceperiod_enabled")}
  element(:quiz_graceperiod_txt) { |b| b.text_field(id:"id_graceperiod_number")}
  element(:quiz_graceperiod_unit_select) { |b| b.select(id:"id_graceperiod_timeunit")}
  #weeks
  #days
  #hours
  #minutes
  #seconds



  #
  element(:grade_quiz_page_link) { |b| b.a(text:"Grade")}
  element(:quiz_grade_category_select) { |b| b.select(id:"id_gradecat")}
  #Uncategorised

  element(:quiz_grade_pass_txt) { |b| b.text_field(id:"id_gradepass")}
  element(:quiz_attempts_select) { |b| b.select(id:"id_attempts")}
  #Unlimited
  #1
  #2
  #3
  #4
  #5
  #6
  #7
  #8
  #9
  #10

  element(:quiz_grademethod_select) { |b| b.select(id:"id_grademethod")}
  #Highest grade
  #Average grade
  #First attempt
  #Last attempt

  #
  element(:layout_quiz_page_link) { |b| b.a(text:"Layout")}
  element(:quiz_questionsperpage_select) { |b| b.select(id:"id_questionsperpage")}
  #Never, all questions on one page
  #Every question
  #Every 2 questions
  #Every 3 questions
  #Every 4 questions
  #Every 5 questions
  #Every 6 questions
  #Every 7 questions
  #...
  #Every 50 questions
  element(:quiz_navmethod_select) { |b| b.select(id:"id_navmethod")}
  #Free
  #Sequential


  element(:question_behaviour_quiz_page_link) { |b| b.a(css:"#mform1 #id_interactionhdr .ftoggler a")}
  element(:quiz_shuffleanswers_select) { |b| b.select(id:"id_shuffleanswers")}
  #No
  #Yes

  element(:quiz_preferredbehaviour_select) { |b| b.select(id:"id_preferredbehaviour")}
  #Adaptive mode
  #Adaptive mode (no penalties)
  #Deferred feedback
  #Deferred feedback with CBM
  #Immediate feedback
  #Immediate feedback with CBM
  #Interactive with multiple tries


  element(:quiz_canredoquestions_select) { |b| b.select(id:"id_canredoquestions")}
  #No
  #Students may redo another version of any finished question
  element(:quiz_attemptonlast_select) { |b| b.select(id:"id_attemptonlast")}
  #No
  #Yes


  #
  element(:review_options_quiz_page_link) { |b| b.a(text:"Review options")}
  element(:quiz_during_attempt_chkbox) { |b| b.input(id:"id_attemptduring")}
  element(:quiz_during_whether_correct_chkbox) { |b| b.input(id:"id_correctnessduring")}
  element(:quiz_during_marks_chkbox) { |b| b.input(id:"id_marksduring")}
  element(:quiz_during_specific_fb_chkbox) { |b| b.input(id:"id_specificfeedbackduring")}
  element(:quiz_during_general_fb_chkbox) { |b| b.input(id:"id_generalfeedbackduring")}
  element(:quiz_during_right_answ_chkbox) { |b| b.input(id:"id_rightanswerduring")}
  element(:quiz_during_overall_fb_chkbox) { |b| b.input(id:"id_overallfeedbackduring")}

  element(:quiz_immediately_attempt_chkbox) { |b| b.input(id:"id_attemptimmediately")}
  element(:quiz_immediately_whether_correct_chkbox) { |b| b.input(id:"id_correctnessimmediately")}
  element(:quiz_immediately_marks_chkbox) { |b| b.input(id:"id_marksimmediately")}
  element(:quiz_immediately_specific_fb_chkbox) { |b| b.input(id:"id_specificfeedbackimmediately")}
  element(:quiz_immediately_general_fb_chkbox) { |b| b.input(id:"id_generalfeedbackimmediately")}
  element(:quiz_immediately_right_answ_chkbox) { |b| b.input(id:"id_rightanswerimmediately")}
  element(:quiz_immediately_overall_fb_chkbox) { |b| b.input(id:"id_overallfeedbackimmediately")}

  element(:quiz_while_attempt_chkbox) { |b| b.input(id:"id_attemptopen")}
  element(:quiz_while_whether_correct_chkbox) { |b| b.input(id:"id_correctnessopen")}
  element(:quiz_while_marks_chkbox) { |b| b.input(id:"id_marksduring")}
  element(:quiz_while_specific_fb_chkbox) { |b| b.input(id:"id_specificfeedbackopen")}
  element(:quiz_while_general_fb_chkbox) { |b| b.input(id:"id_generalfeedbackopen")}
  element(:quiz_while_right_answ_chkbox) { |b| b.input(id:"id_rightansweropen")}
  element(:quiz_while_overall_fb_chkbox) { |b| b.input(id:"id_overallfeedbackopen")}

  element(:quiz_after_attempt_chkbox) { |b| b.input(id:"id_attemptclosed")}
  element(:quiz_after_whether_correct_chkbox) { |b| b.input(id:"id_correctnessclosed")}
  element(:quiz_after_marks_chkbox) { |b| b.input(id:"id_marksclosed")}
  element(:quiz_after_specific_fb_chkbox) { |b| b.input(id:"id_specificfeedbackclosed")}
  element(:quiz_after_general_fb_chkbox) { |b| b.input(id:"id_generalfeedbackclosed")}
  element(:quiz_after_right_answ_chkbox) { |b| b.input(id:"id_rightanswerclosed")}
  element(:quiz_after_overall_fb_chkbox) { |b| b.input(id:"id_overallfeedbackclosed")}

  element(:appearance_quiz_page_link) { |b| b.a(text:"Appearance")}
  element(:quiz_showuserpicture_select) { |b| b.select(id:"id_showuserpicture")}
  #No image
  #Small image
  #Large image

  element(:quiz_decimalpoints_select) { |b| b.select(id:"id_decimalpoints")}
  #0
  #1
  #2
  #3
  #4
  #5

  element(:quiz_questiondecimalpoints_select) { |b| b.select(id:"id_questiondecimalpoints")}
  #Same as for overall grades
  #0
  #1
  #2
  #3
  #4
  #5
  #6
  #7

  element(:quiz_showblocks_select) { |b| b.select(id:"id_showblocks")}
  #Yes
  #No

  element(:extra_restrictions_attempts_quiz_page_link) { |b| b.a(text:"Extra restrictions on attempts")}
  element(:quiz_enterPassword_link) { |b| b.a(text:"Click to enter text")}
  element(:quiz_enterPassword_txt) { |b| b.text_field(id:"id_quizpassword")}
  element(:quiz_network_addres_txt) { |b| b.text_field(id:"id_subnet")}

  element(:overall_feedback_quiz_page_link) { |b| b.a(text:"Overall feedback")}

  element(:common_module_settings_quiz_page_link) { |b| b.a(text:"Common module settings")}

  element(:restrict_access_quiz_page_link) { |b| b.a(text:"Restrict access")}

  element(:tags_quiz_page_link) { |b| b.a(text:"Tags")}
  element(:quiz_tags_txt) { |b| b.text_field(placeholder:"Enter tags...")}

  element(:competencies_quiz_page_link) { |b| b.a(text:"Competencies")}

  element(:add_quiz_page_btn) { |b| b.input(id:"id_submitbutton2")}
  action(:add_quiz_page_btn_clk) { |b| b.add_quiz_page_btn.click }

end