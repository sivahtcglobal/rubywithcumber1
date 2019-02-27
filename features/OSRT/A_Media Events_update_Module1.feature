@osrt
Feature: OSRT Module1 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance

    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
  Examples:
    |url|header|modul|
    |https://intellify.instructure.com/courses/21/modules/items/265|Introduction to Online Learning - about 12 minutes|intro|


  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      |Title|Title         |1            |
      |Online vs. Classroom|Online vs. Classroom|2|
      |How Does It Work?|How Does It Work?      |3|
      |Debunking Myths|Debunking Myths          |4|
      |Common Myths|Common Myths                |5|
      |Myth #1: Easier|Myth #1: Easier          |6|
      |Myth #2: Self-Paced|Myth #2: Self-Paced  |7|
      |Myth #3: Cheaper|Myth #3: Cheaper        |8|
      |Myth #4: Participation|Myth #4: Participation|9|
      |Myth #5: Tech Skills|Myth #5: Tech Skills    |10|
      |Myth #6: Communication Skills|Myth #6: Communication Skills|11|
      |Myth #7: Excuses|Myth #7: Excuses                          |12|
      |Conclusion|Conclusion                                      |13|
  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      |Online vs. Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Online vs. Classroom|2|pause|
      |How Does It Work?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|How Does It Work?      |3|pause|
      |Debunking Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Debunking Myths          |4|pause|
      |Common Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Common Myths                |5|pause|
      |Myth #1: Easier|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Myth #1: Easier          |6|pause|
      |Myth #2: Self-Paced|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Myth #2: Self-Paced  |7|pause|
      |Myth #3: Cheaper|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Myth #3: Cheaper        |8|pause|
      |Myth #4: Participation|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Myth #4: Participation|9|pause|
      |Myth #5: Tech Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Myth #5: Tech Skills    |10|pause|
      |Myth #6: Communication Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Myth #6: Communication Skills|11|pause|
      |Myth #7: Excuses|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Myth #7: Excuses                          |12|pause|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion                                      |13|pause|
  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
    |sections|action|chaptername|chapternumber|itemname|
    |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
    |Online vs. Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Online vs. Classroom|2|resume|
    |How Does It Work?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|How Does It Work?      |3|resume|
    |Debunking Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Debunking Myths          |4|resume|
    |Common Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Common Myths                |5|resume|
    |Myth #1: Easier|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Myth #1: Easier          |6|resume|
    |Myth #2: Self-Paced|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Myth #2: Self-Paced  |7|resume|
    |Myth #3: Cheaper|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Myth #3: Cheaper        |8|resume|
    |Myth #4: Participation|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Myth #4: Participation|9|resume|
    |Myth #5: Tech Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Myth #5: Tech Skills    |10|resume|
    |Myth #6: Communication Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Myth #6: Communication Skills|11|resume|
    |Myth #7: Excuses|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Myth #7: Excuses                          |12|resume|
    |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion                                      |13|resume|
  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      |Online vs. Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Online vs. Classroom|2|restart|
      |How Does It Work?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|How Does It Work?      |3|restart|
      |Debunking Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Debunking Myths          |4|restart|
      |Common Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Common Myths                |5|restart|
      |Myth #1: Easier|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Myth #1: Easier          |6|restart|
      |Myth #2: Self-Paced|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Myth #2: Self-Paced  |7|restart|
      |Myth #3: Cheaper|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Myth #3: Cheaper        |8|restart|
      |Myth #4: Participation|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Myth #4: Participation|9|restart|
      |Myth #5: Tech Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Myth #5: Tech Skills    |10|restart|
      |Myth #6: Communication Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Myth #6: Communication Skills|11|restart|
      |Myth #7: Excuses|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Myth #7: Excuses                          |12|restart|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion                                      |13|restart|
  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      |Online vs. Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Online vs. Classroom|2|forward|
      |How Does It Work?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|How Does It Work?      |3|forward|
      |Debunking Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Debunking Myths          |4|forward|
      |Common Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Common Myths                |5|forward|
      |Myth #1: Easier|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Myth #1: Easier          |6|forward|
      |Myth #2: Self-Paced|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Myth #2: Self-Paced  |7|forward|
      |Myth #3: Cheaper|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Myth #3: Cheaper        |8|forward|
      |Myth #4: Participation|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Myth #4: Participation|9|forward|
      |Myth #5: Tech Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Myth #5: Tech Skills    |10|forward|
      |Myth #6: Communication Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Myth #6: Communication Skills|11|forward|
      |Myth #7: Excuses|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Myth #7: Excuses                          |12|forward|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion                                      |13|forward|
  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      |Online vs. Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Online vs. Classroom|2|rewind|
      |How Does It Work?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|How Does It Work?      |3|rewind|
      |Debunking Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Debunking Myths          |4|rewind|
      |Common Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Common Myths                |5|rewind|
      |Myth #1: Easier|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Myth #1: Easier          |6|rewind|
      |Myth #2: Self-Paced|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Myth #2: Self-Paced  |7|rewind|
      |Myth #3: Cheaper|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Myth #3: Cheaper        |8|rewind|
      |Myth #4: Participation|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Myth #4: Participation|9|rewind|
      |Myth #5: Tech Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Myth #5: Tech Skills    |10|rewind|
      |Myth #6: Communication Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Myth #6: Communication Skills|11|rewind|
      |Myth #7: Excuses|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Myth #7: Excuses                          |12|rewind|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion                                      |13|rewind|
  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      |Online vs. Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Online vs. Classroom|2|slower|
      |How Does It Work?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|How Does It Work?      |3|slower|
      |Debunking Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Debunking Myths          |4|slower|
      |Common Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Common Myths                |5|slower|
      |Myth #1: Easier|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #1: Easier          |6|slower|
      |Myth #2: Self-Paced|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #2: Self-Paced  |7|slower|
      |Myth #3: Cheaper|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #3: Cheaper        |8|slower|
      |Myth #4: Participation|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #4: Participation|9|slower|
      |Myth #5: Tech Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #5: Tech Skills    |10|slower|
      |Myth #6: Communication Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #6: Communication Skills|11|slower|
      |Myth #7: Excuses|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #7: Excuses                          |12|slower|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion                                      |13|slower|
  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      |Online vs. Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Online vs. Classroom|2|faster|
      |How Does It Work?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|How Does It Work?      |3|faster|
      |Debunking Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Debunking Myths          |4|faster|
      |Common Myths|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Common Myths                |5|faster|
      |Myth #1: Easier|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #1: Easier          |6|faster|
      |Myth #2: Self-Paced|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #2: Self-Paced  |7|faster|
      |Myth #3: Cheaper|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #3: Cheaper        |8|faster|
      |Myth #4: Participation|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #4: Participation|9|faster|
      |Myth #5: Tech Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #5: Tech Skills    |10|faster|
      |Myth #6: Communication Skills|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #6: Communication Skills|11|faster|
      |Myth #7: Excuses|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Myth #7: Excuses                          |12|faster|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion                                      |13|faster|
  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application