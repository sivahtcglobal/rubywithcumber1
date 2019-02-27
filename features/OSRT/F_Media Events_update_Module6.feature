@osrt
Feature: OSRT Module6 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/448|Online Reading Strategies - about 9 minutes|reading|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | Introduction|Introduction|2|
      | Print vs. Online|Print vs. Online|3|
      | Why, What, How?|Why, What, How?|4|
      | Explore a Webpage|Explore a Webpage|5                  |
      | Student Q & A|Student Q & A|6|
      | Conclusion|Conclusion|7|

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Introduction|2|pause|
      | Print vs. Online|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Print vs. Online|3|pause|
      | Why, What, How?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Why, What, How?|4|pause|
      | Explore a Webpage|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Explore a Webpage|5                  |pause|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Student Q & A|6|pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|7|pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Introduction|2|resume|
      | Print vs. Online|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Print vs. Online|3|resume|
      | Why, What, How?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Why, What, How?|4|resume|
      | Explore a Webpage|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Explore a Webpage|5                  |resume|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Student Q & A|6|resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|7|resume|

  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Introduction|2|restart|
      | Print vs. Online|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Print vs. Online|3|restart|
      | Why, What, How?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Why, What, How?|4|restart|
      | Explore a Webpage|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Explore a Webpage|5                  |restart|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Student Q & A|6|restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|7|restart|

  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Introduction|2|forward|
      | Print vs. Online|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Print vs. Online|3|forward|
      | Why, What, How?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Why, What, How?|4|forward|
      | Explore a Webpage|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Explore a Webpage|5                  |forward|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Student Q & A|6|forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|7|forward|

  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Introduction|2|rewind|
      | Print vs. Online|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Print vs. Online|3|rewind|
      | Why, What, How?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Why, What, How?|4|rewind|
      | Explore a Webpage|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Explore a Webpage|5                  |rewind|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Student Q & A|6|rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|7|rewind|

  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Introduction|2|slower|
      | Print vs. Online|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Print vs. Online|3|slower|
      | Why, What, How?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Why, What, How?|4|slower|
      | Explore a Webpage|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Explore a Webpage|5                  |slower|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Student Q & A|6|slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|7|slower|

  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Introduction|2|faster|
      | Print vs. Online|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Print vs. Online|3|faster|
      | Why, What, How?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Why, What, How?|4|faster|
      | Explore a Webpage|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Explore a Webpage|5                  |faster|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Student Q & A|6|faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|7|faster|

  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application