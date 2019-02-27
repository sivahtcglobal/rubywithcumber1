@osrt
Feature: OSRT Module2 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/377|Getting Tech Ready - about 12 minutes|tech|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title        |1            |
      | Technical Understanding|Technical Understanding|2|
      | What will I need?|What will I need?            |3|
      | Technical Difficulties|Technical Difficulties  |4|
      | Is it plugged in?|Is it plugged in?            |5|
      | Is there power?|Is there power?                |6|
      | Using a portable?|Using a portable?            |7|
      | No picture?|No picture?                        |8|
      | No sound?|No sound?                            |9|
      | Getting Help|Getting Help                      |10|
      | Conclusion|Conclusion                          |11|

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | Technical Understanding|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Technical Understanding|2|pause|
      | What will I need?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|What will I need?|3|pause|
      | Technical Difficulties|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Technical Difficulties|4|pause|
      | Is it plugged in?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Is it plugged in?|5|pause|
      | Is there power?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Is there power?|6|pause|
      | Using a portable?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Using a portable?|7|pause|
      | No picture?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|No picture?|8|pause|
      | No sound?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|No sound?|9|pause|
      | Getting Help|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Getting Help|10|pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|11|pause|
  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | Technical Understanding|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Technical Understanding|2|resume|
      | What will I need?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|What will I need?|3|resume|
      | Technical Difficulties|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Technical Difficulties|4|resume|
      | Is it plugged in?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Is it plugged in?|5|resume|
      | Is there power?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Is there power?|6|resume|
      | Using a portable?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Using a portable?|7|resume|
      | No picture?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|No picture?|8|resume|
      | No sound?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|No sound?|9|resume|
      | Getting Help|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Getting Help|10|resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|11|resume|
  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | Technical Understanding|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Technical Understanding|2|restart|
      | What will I need?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|What will I need?|3|restart|
      | Technical Difficulties|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Technical Difficulties|4|restart|
      | Is it plugged in?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Is it plugged in?|5|restart|
      | Is there power?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Is there power?|6|restart|
      | Using a portable?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Using a portable?|7|restart|
      | No picture?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|No picture?|8|restart|
      | No sound?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|No sound?|9|restart|
      | Getting Help|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Getting Help|10|restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|11|restart|
  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | Technical Understanding|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Technical Understanding|2|forward|
      | What will I need?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|What will I need?|3|forward|
      | Technical Difficulties|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Technical Difficulties|4|forward|
      | Is it plugged in?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Is it plugged in?|5|forward|
      | Is there power?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Is there power?|6|forward|
      | Using a portable?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Using a portable?|7|forward|
      | No picture?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|No picture?|8|forward|
      | No sound?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|No sound?|9|forward|
      | Getting Help|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Getting Help|10|forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|11|forward|
  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | Technical Understanding|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Technical Understanding|2|rewind|
      | What will I need?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|What will I need?|3|rewind|
      | Technical Difficulties|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Technical Difficulties|4|rewind|
      | Is it plugged in?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Is it plugged in?|5|rewind|
      | Is there power?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Is there power?|6|rewind|
      | Using a portable?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Using a portable?|7|rewind|
      | No picture?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|No picture?|8|rewind|
      | No sound?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|No sound?|9|rewind|
      | Getting Help|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Getting Help|10|rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|11|rewind|
  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | Technical Understanding|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Technical Understanding|2|slower|
      | What will I need?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|What will I need?|3|slower|
      | Technical Difficulties|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Technical Difficulties|4|slower|
      | Is it plugged in?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Is it plugged in?|5|slower|
      | Is there power?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Is there power?|6|slower|
      | Using a portable?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Using a portable?|7|slower|
      | No picture?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|No picture?|8|slower|
      | No sound?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|No sound?|9|slower|
      | Getting Help|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Getting Help|10|slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|11|slower|
  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | Technical Understanding|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Technical Understanding|2|faster|
      | What will I need?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|What will I need?|3|faster|
      | Technical Difficulties|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Technical Difficulties|4|faster|
      | Is it plugged in?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Is it plugged in?|5|faster|
      | Is there power?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Is there power?|6|faster|
      | Using a portable?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Using a portable?|7|faster|
      | No picture?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|No picture?|8|faster|
      | No sound?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|No sound?|9|faster|
      | Getting Help|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Getting Help|10|faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|11|faster|
  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application