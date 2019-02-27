@osrt
Feature: OSRT Module9 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/451|Instructional Support - about 5 minutes|instructional|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | How Do You Define Success?|How Do You Define Success?|2|
      | Achieving Success in the Classroom|Achieving Success in the Classroom|3|
      | Academic Support Resources|Academic Support Resources|4|
      | Conclusion|Conclusion|5                  |

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | How Do You Define Success?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|How Do You Define Success?|2|pause|
      | Achieving Success in the Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Achieving Success in the Classroom|3|pause|
      | Academic Support Resources|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Academic Support Resources|4|pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|5                  |pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | How Do You Define Success?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|How Do You Define Success?|2|resume|
      | Achieving Success in the Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Achieving Success in the Classroom|3|resume|
      | Academic Support Resources|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Academic Support Resources|4|resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|5                  |resume|

  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | How Do You Define Success?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|How Do You Define Success?|2|restart|
      | Achieving Success in the Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Achieving Success in the Classroom|3|restart|
      | Academic Support Resources|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Academic Support Resources|4|restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|5                  |restart|

  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | How Do You Define Success?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|How Do You Define Success?|2|forward|
      | Achieving Success in the Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Achieving Success in the Classroom|3|forward|
      | Academic Support Resources|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Academic Support Resources|4|forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|5                  |forward|

  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | How Do You Define Success?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|How Do You Define Success?|2|rewind|
      | Achieving Success in the Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Achieving Success in the Classroom|3|rewind|
      | Academic Support Resources|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Academic Support Resources|4|rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|5                  |rewind|

  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | How Do You Define Success?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|How Do You Define Success?|2|slower|
      | Achieving Success in the Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Achieving Success in the Classroom|3|slower|
      | Academic Support Resources|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Academic Support Resources|4|slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|5                  |slower|

  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | How Do You Define Success?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|How Do You Define Success?|2|faster|
      | Achieving Success in the Classroom|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Achieving Success in the Classroom|3|faster|
      | Academic Support Resources|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Academic Support Resources|4|faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|5                  |faster|

  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application