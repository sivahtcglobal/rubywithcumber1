@osrt
Feature: OSRT Module4 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/268 |Online Study Skills and Managing Time - about 12 minutes|study-time|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | Study Challenges|Study Challenges|2|
      | Step 1 - Time Management|Step 1 - Time Management|3|
      | Personality Profile|Personality Profile|4|
      | Identify Your Style|Identify Your Style|5                  |
      | Step 2 - Create a Schedule|Step 2 - Create a Schedule|6|
      | Q & A|Q & A|7|
      | Step 3 - Prioritizing Time|Step 3 - Prioritizing Time|8              |
      | Procrastination Checklist|Procrastination Checklist|9    |
      | Procrastination Pie|Procrastination Pie|10       |
      | Conclusion|Conclusion|11           |

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | Study Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Study Challenges|2|pause|
      | Step 1 - Time Management|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 1 - Time Management|3|pause|
      | Personality Profile|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Personality Profile|4|pause|
      | Identify Your Style|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Identify Your Style|5                  |pause|
      | Step 2 - Create a Schedule|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 2 - Create a Schedule|6|pause|
      | Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Q & A|7|pause|
      | Step 3 - Prioritizing Time|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Step 3 - Prioritizing Time|8              |pause|
      | Procrastination Checklist|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Procrastination Checklist|9    |pause|
      | Procrastination Pie|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Procrastination Pie|10       |pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|11           |pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | Study Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Study Challenges|2|resume|
      | Step 1 - Time Management|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 1 - Time Management|3|resume|
      | Personality Profile|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Personality Profile|4|resume|
      | Identify Your Style|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Identify Your Style|5                  |resume|
      | Step 2 - Create a Schedule|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 2 - Create a Schedule|6|resume|
      | Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Q & A|7|resume|
      | Step 3 - Prioritizing Time|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Step 3 - Prioritizing Time|8              |resume|
      | Procrastination Checklist|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Procrastination Checklist|9    |resume|
      | Procrastination Pie|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Procrastination Pie|10       |resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|11           |resume|

  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | Study Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Study Challenges|2|restart|
      | Step 1 - Time Management|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 1 - Time Management|3|restart|
      | Personality Profile|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Personality Profile|4|restart|
      | Identify Your Style|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Identify Your Style|5                  |restart|
      | Step 2 - Create a Schedule|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 2 - Create a Schedule|6|restart|
      | Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Q & A|7|restart|
      | Step 3 - Prioritizing Time|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Step 3 - Prioritizing Time|8              |restart|
      | Procrastination Checklist|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Procrastination Checklist|9    |restart|
      | Procrastination Pie|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Procrastination Pie|10       |restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|11           |restart|

  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | Study Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Study Challenges|2|forward|
      | Step 1 - Time Management|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 1 - Time Management|3|forward|
      | Personality Profile|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Personality Profile|4|forward|
      | Identify Your Style|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Identify Your Style|5                  |forward|
      | Step 2 - Create a Schedule|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 2 - Create a Schedule|6|forward|
      | Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Q & A|7|forward|
      | Step 3 - Prioritizing Time|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Step 3 - Prioritizing Time|8              |forward|
      | Procrastination Checklist|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Procrastination Checklist|9    |forward|
      | Procrastination Pie|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Procrastination Pie|10       |forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|11           |forward|

  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | Study Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Study Challenges|2|rewind|
      | Step 1 - Time Management|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 1 - Time Management|3|rewind|
      | Personality Profile|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Personality Profile|4|rewind|
      | Identify Your Style|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Identify Your Style|5                  |rewind|
      | Step 2 - Create a Schedule|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 2 - Create a Schedule|6|rewind|
      | Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Q & A|7|rewind|
      | Step 3 - Prioritizing Time|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Step 3 - Prioritizing Time|8              |rewind|
      | Procrastination Checklist|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Procrastination Checklist|9    |rewind|
      | Procrastination Pie|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Procrastination Pie|10       |rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|11           |rewind|

  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | Study Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Study Challenges|2|slower|
      | Step 1 - Time Management|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 1 - Time Management|3|slower|
      | Personality Profile|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Personality Profile|4|slower|
      | Identify Your Style|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Identify Your Style|5                  |slower|
      | Step 2 - Create a Schedule|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 2 - Create a Schedule|6|slower|
      | Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Q & A|7|slower|
      | Step 3 - Prioritizing Time|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 3 - Prioritizing Time|8              |slower|
      | Procrastination Checklist|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Procrastination Checklist|9    |slower|
      | Procrastination Pie|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Procrastination Pie|10       |slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|11           |slower|

  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | Study Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Study Challenges|2|faster|
      | Step 1 - Time Management|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 1 - Time Management|3|faster|
      | Personality Profile|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Personality Profile|4|faster|
      | Identify Your Style|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Identify Your Style|5                  |faster|
      | Step 2 - Create a Schedule|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 2 - Create a Schedule|6|faster|
      | Q & A|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Q & A|7|faster|
      | Step 3 - Prioritizing Time|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Step 3 - Prioritizing Time|8              |faster|
      | Procrastination Checklist|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Procrastination Checklist|9    |faster|
      | Procrastination Pie|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Procrastination Pie|10       |faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|11           |faster|

  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application