@osrt
Feature: OSRT Module8 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/450|Educational Planning - about 8 minutes|educational|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | What is an Education Plan?|What is an Education Plan?|2|
      | A Diverse Body of Students|A Diverse Body of Students|3|
      | Three Essential Tasks|Three Essential Tasks|4|
      | The S.T.E.P. Process|The S.T.E.P. Process|5                  |
      | Conclusion|Conclusion|6|

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | What is an Education Plan?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|What is an Education Plan?|2|pause|
      | A Diverse Body of Students|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|A Diverse Body of Students|3|pause|
      | Three Essential Tasks|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Three Essential Tasks|4|pause|
      | The S.T.E.P. Process|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|The S.T.E.P. Process|5                  |pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|6|pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | What is an Education Plan?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|What is an Education Plan?|2|resume|
      | A Diverse Body of Students|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|A Diverse Body of Students|3|resume|
      | Three Essential Tasks|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Three Essential Tasks|4|resume|
      | The S.T.E.P. Process|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|The S.T.E.P. Process|5                  |resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|6|resume|

  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | What is an Education Plan?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|What is an Education Plan?|2|restart|
      | A Diverse Body of Students|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|A Diverse Body of Students|3|restart|
      | Three Essential Tasks|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Three Essential Tasks|4|restart|
      | The S.T.E.P. Process|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|The S.T.E.P. Process|5                  |restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|6|restart|

  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | What is an Education Plan?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|What is an Education Plan?|2|forward|
      | A Diverse Body of Students|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|A Diverse Body of Students|3|forward|
      | Three Essential Tasks|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Three Essential Tasks|4|forward|
      | The S.T.E.P. Process|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|The S.T.E.P. Process|5                  |forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|6|forward|

  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | What is an Education Plan?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|What is an Education Plan?|2|rewind|
      | A Diverse Body of Students|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|A Diverse Body of Students|3|rewind|
      | Three Essential Tasks|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Three Essential Tasks|4|rewind|
      | The S.T.E.P. Process|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|The S.T.E.P. Process|5                  |rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|6|rewind|

  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | What is an Education Plan?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|What is an Education Plan?|2|slower|
      | A Diverse Body of Students|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|A Diverse Body of Students|3|slower|
      | Three Essential Tasks|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Three Essential Tasks|4|slower|
      | The S.T.E.P. Process|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|The S.T.E.P. Process|5                  |slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|6|slower|

  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | What is an Education Plan?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|What is an Education Plan?|2|faster|
      | A Diverse Body of Students|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|A Diverse Body of Students|3|faster|
      | Three Essential Tasks|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Three Essential Tasks|4|faster|
      | The S.T.E.P. Process|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|The S.T.E.P. Process|5                  |faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|6|faster|

  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application