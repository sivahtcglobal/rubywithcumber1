@osrt
Feature: OSRT Module7 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/449|Career Planning - about 5 minutes|career|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | Your Work Life|Your Work Life|2|
      | Think About This|Think About This|3|
      | Steps to Choosing|Steps to Choosing|4|
      | Step 1|Step 1|5|
      | Step 2|Step 2|6|
      | Step 3|Step 3|7|
      | Step 4|Step 4|8|
      | Step 5|Step 5|9|
      | Keep It In Check|Keep It In Check|10|
      | Conclusion|Conclusion|11|

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | Your Work Life|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Your Work Life|2|pause|
      | Think About This|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Think About This|3|pause|
      | Steps to Choosing|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Steps to Choosing|4|pause|
      | Step 1|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 1|5                  |pause|
      | Step 2|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 2|6|pause|
      | Step 3|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 3|7|pause|
      | Step 4|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 4|8              |pause|
      | Step 5|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 5|9    |pause|
      | Keep It In Check|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Keep It In Check|10       |pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|11           |pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | Your Work Life|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Your Work Life|2|resume|
      | Think About This|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Think About This|3|resume|
      | Steps to Choosing|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Steps to Choosing|4|resume|
      | Step 1|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 1|5                  |resume|
      | Step 2|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 2|6|resume|
      | Step 3|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 3|7|resume|
      | Step 4|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 4|8              |resume|
      | Step 5|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 5|9    |resume|
      | Keep It In Check|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Keep It In Check|10       |resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|11           |resume|

  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | Your Work Life|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Your Work Life|2|restart|
      | Think About This|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Think About This|3|restart|
      | Steps to Choosing|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Steps to Choosing|4|restart|
      | Step 1|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 1|5                  |restart|
      | Step 2|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 2|6|restart|
      | Step 3|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 3|7|restart|
      | Step 4|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 4|8              |restart|
      | Step 5|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 5|9    |restart|
      | Keep It In Check|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Keep It In Check|10       |restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|11           |restart|

  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | Your Work Life|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Your Work Life|2|forward|
      | Think About This|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Think About This|3|forward|
      | Steps to Choosing|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Steps to Choosing|4|forward|
      | Step 1|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 1|5                  |forward|
      | Step 2|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 2|6|forward|
      | Step 3|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 3|7|forward|
      | Step 4|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 4|8              |forward|
      | Step 5|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 5|9    |forward|
      | Keep It In Check|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Keep It In Check|10       |forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|11           |forward|

  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | Your Work Life|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Your Work Life|2|rewind|
      | Think About This|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Think About This|3|rewind|
      | Steps to Choosing|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Steps to Choosing|4|rewind|
      | Step 1|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 1|5                  |rewind|
      | Step 2|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 2|6|rewind|
      | Step 3|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 3|7|rewind|
      | Step 4|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 4|8              |rewind|
      | Step 5|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 5|9    |rewind|
      | Keep It In Check|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Keep It In Check|10       |rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|11           |rewind|

  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | Your Work Life|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Your Work Life|2|slower|
      | Think About This|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Think About This|3|slower|
      | Steps to Choosing|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Steps to Choosing|4|slower|
      | Step 1|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 1|5                  |slower|
      | Step 2|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 2|6|slower|
      | Step 3|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 3|7|slower|
      | Step 4|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 4|8              |slower|
      | Step 5|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 5|9    |slower|
      | Keep It In Check|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Keep It In Check|10       |slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|11           |slower|

  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | Your Work Life|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Your Work Life|2|faster|
      | Think About This|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Think About This|3|faster|
      | Steps to Choosing|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Steps to Choosing|4|faster|
      | Step 1|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 1|5                  |faster|
      | Step 2|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 2|6|faster|
      | Step 3|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 3|7|faster|
      | Step 4|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 4|8              |faster|
      | Step 5|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 5|9    |faster|
      | Keep It In Check|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Keep It In Check|10       |faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|11           |faster|

  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application