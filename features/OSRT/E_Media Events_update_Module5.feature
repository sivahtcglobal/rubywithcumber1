@osrt
Feature: OSRT Module5 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/454 |Communication Skills for Online Learning - about 13 minutes|communication|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | Good Communication|Good Communication|2|
      | Definitions|Definitions|3|
      | Discussion Boards|Discussion Boards|4|
      | Blogs|Blogs|5                  |
      | Chat|Chat|6|
      | Video Calls|Video Calls|7|
      | Video Conferencing|Video Conferencing|8              |
      | Netiquette|Netiquette|9    |
      | Student Q & A|Student Q & A|10       |
      | Email Netiquette|Email Netiquette|11|
      | Conclusion|Conclusion|12           |

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | Good Communication|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Good Communication|2|pause|
      | Definitions|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Definitions|3|pause|
      | Discussion Boards|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Discussion Boards|4|pause|
      | Blogs|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Blogs|5                  |pause|
      | Chat|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Chat|6|pause|
      | Video Calls|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Video Calls|7|pause|
      | Video Conferencing|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Video Conferencing|8              |pause|
      | Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Netiquette|9    |pause|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Student Q & A|10       |pause|
      | Email Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Email Netiquette|11|pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|12           |pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | Good Communication|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Good Communication|2|resume|
      | Definitions|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Definitions|3|resume|
      | Discussion Boards|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Discussion Boards|4|resume|
      | Blogs|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Blogs|5                  |resume|
      | Chat|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Chat|6|resume|
      | Video Calls|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Video Calls|7|resume|
      | Video Conferencing|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Video Conferencing|8              |resume|
      | Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Netiquette|9    |resume|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Student Q & A|10       |resume|
      | Email Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Email Netiquette|11|resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|12           |resume|

  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | Good Communication|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Good Communication|2|restart|
      | Definitions|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Definitions|3|restart|
      | Discussion Boards|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Discussion Boards|4|restart|
      | Blogs|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Blogs|5                  |restart|
      | Chat|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Chat|6|restart|
      | Video Calls|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Video Calls|7|restart|
      | Video Conferencing|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Video Conferencing|8              |restart|
      | Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Netiquette|9    |restart|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Student Q & A|10       |restart|
      | Email Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Email Netiquette|11|restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|12           |restart|

  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | Good Communication|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Good Communication|2|forward|
      | Definitions|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Definitions|3|forward|
      | Discussion Boards|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Discussion Boards|4|forward|
      | Blogs|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Blogs|5                  |forward|
      | Chat|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Chat|6|forward|
      | Video Calls|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Video Calls|7|forward|
      | Video Conferencing|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Video Conferencing|8              |forward|
      | Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Netiquette|9    |forward|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Student Q & A|10       |forward|
      | Email Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Email Netiquette|11|forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|12           |forward|

  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | Good Communication|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Good Communication|2|rewind|
      | Definitions|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Definitions|3|rewind|
      | Discussion Boards|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Discussion Boards|4|rewind|
      | Blogs|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Blogs|5                  |rewind|
      | Chat|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Chat|6|rewind|
      | Video Calls|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Video Calls|7|rewind|
      | Video Conferencing|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Video Conferencing|8              |rewind|
      | Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Netiquette|9    |rewind|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Student Q & A|10       |rewind|
      | Email Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Email Netiquette|11|rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|12           |rewind|

  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | Good Communication|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Good Communication|2|slower|
      | Definitions|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Definitions|3|slower|
      | Discussion Boards|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Discussion Boards|4|slower|
      | Blogs|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Blogs|5                  |slower|
      | Chat|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Chat|6|slower|
      | Video Calls|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Video Calls|7|slower|
      | Video Conferencing|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Video Conferencing|8              |slower|
      | Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Netiquette|9    |slower|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Student Q & A|10       |slower|
      | Email Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Email Netiquette|11|slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|12           |slower|

  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | Good Communication|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Good Communication|2|faster|
      | Definitions|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Definitions|3|faster|
      | Discussion Boards|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Discussion Boards|4|faster|
      | Blogs|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Blogs|5                  |faster|
      | Chat|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Chat|6|faster|
      | Video Calls|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Video Calls|7|faster|
      | Video Conferencing|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Video Conferencing|8              |faster|
      | Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Netiquette|9    |faster|
      | Student Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Student Q & A|10       |faster|
      | Email Netiquette|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Email Netiquette|11|faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|12           |faster|

  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application