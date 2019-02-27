@osrt
Feature: OSRT Module3 Media Events

  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/267 |Organizing for Online Success - about 12 minutes|organizing|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | Introduction|Introduction|2|
      | Organize Your Environment|Organize Your Environment|3|
      | Tip #1 - Know your constraints|Tip #1 - Know your constraints|4|
      | Tip #2 - Find a plug!|Tip #2 - Find a plug!|5                  |
      | Organize Your Course Materials|Organize Your Course Materials|6|
      | Create an Organizational Style|Create an Organizational Style|7|
      | Tip #3 - Cloud services|Tip #3 - Cloud services|8              |
      | Tip #4 - Organize e-learning|Tip #4 - Organize e-learning|9    |
      | Tip #5 - Naming your files|Tip #5 - Naming your files|10       |
      | Tip #6 - Version control|Tip #6 - Version control|11           |
      | Tip #7 - Back up your files!|Tip #7 - Back up your files!|12   |
      | Organize Your Time|Organize Your Time|13                       |
      | Tip #8 - Create a calendar|Tip #8 - Create a calendar|14       |
      | Tip #9 - Break it up!|Tip #9 - Break it up!|15                 |
      | Tip #10 - Use an alert/alarm|Tip #10 - Use an alert/alarm|16|
      | Conclusion|Conclusion|17|

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Introduction|2|pause|
      | Organize Your Environment|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Organize Your Environment|3|pause|
      | Tip #1 - Know your constraints|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #1 - Know your constraints|4|pause|
      | Tip #2 - Find a plug!|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #2 - Find a plug!|5                  |pause|
      | Organize Your Course Materials|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Organize Your Course Materials|6|pause|
      | Create an Organizational Style|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Create an Organizational Style|7|pause|
      | Tip #3 - Cloud services|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #3 - Cloud services|8              |pause|
      | Tip #4 - Organize e-learning|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #4 - Organize e-learning|9    |pause|
      | Tip #5 - Naming your files|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #5 - Naming your files|10       |pause|
      | Tip #6 - Version control|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #6 - Version control|11           |pause|
      | Tip #7 - Back up your files!|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #7 - Back up your files!|12   |pause|
      | Organize Your Time|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Organize Your Time|13                       |pause|
      | Tip #8 - Create a calendar|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #8 - Create a calendar|14       |pause|
      | Tip #9 - Break it up!|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #9 - Break it up!|15                 |pause|
      | Tip #10 - Use an alert/alarm|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Tip #10 - Use an alert/alarm|16|pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|17|pause|
  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Introduction|2|resume|
      | Organize Your Environment|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Organize Your Environment|3|resume|
      | Tip #1 - Know your constraints|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #1 - Know your constraints|4|resume|
      | Tip #2 - Find a plug!|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #2 - Find a plug!|5                  |resume|
      | Organize Your Course Materials|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Organize Your Course Materials|6|resume|
      | Create an Organizational Style|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Create an Organizational Style|7|resume|
      | Tip #3 - Cloud services|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #3 - Cloud services|8              |resume|
      | Tip #4 - Organize e-learning|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #4 - Organize e-learning|9    |resume|
      | Tip #5 - Naming your files|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #5 - Naming your files|10       |resume|
      | Tip #6 - Version control|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #6 - Version control|11           |resume|
      | Tip #7 - Back up your files!|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #7 - Back up your files!|12   |resume|
      | Organize Your Time|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Organize Your Time|13                       |resume|
      | Tip #8 - Create a calendar|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #8 - Create a calendar|14       |resume|
      | Tip #9 - Break it up!|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #9 - Break it up!|15                 |resume|
      | Tip #10 - Use an alert/alarm|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Tip #10 - Use an alert/alarm|16|resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|17|resume|
  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Introduction|2|restart|
      | Organize Your Environment|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Organize Your Environment|3|restart|
      | Tip #1 - Know your constraints|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #1 - Know your constraints|4|restart|
      | Tip #2 - Find a plug!|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #2 - Find a plug!|5                  |restart|
      | Organize Your Course Materials|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Organize Your Course Materials|6|restart|
      | Create an Organizational Style|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Create an Organizational Style|7|restart|
      | Tip #3 - Cloud services|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #3 - Cloud services|8              |restart|
      | Tip #4 - Organize e-learning|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #4 - Organize e-learning|9    |restart|
      | Tip #5 - Naming your files|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #5 - Naming your files|10       |restart|
      | Tip #6 - Version control|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #6 - Version control|11           |restart|
      | Tip #7 - Back up your files!|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #7 - Back up your files!|12   |restart|
      | Organize Your Time|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Organize Your Time|13                       |restart|
      | Tip #8 - Create a calendar|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #8 - Create a calendar|14       |restart|
      | Tip #9 - Break it up!|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #9 - Break it up!|15                 |restart|
      | Tip #10 - Use an alert/alarm|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Tip #10 - Use an alert/alarm|16|restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|17|restart|
  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Introduction|2|forward|
      | Organize Your Environment|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Organize Your Environment|3|forward|
      | Tip #1 - Know your constraints|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #1 - Know your constraints|4|forward|
      | Tip #2 - Find a plug!|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #2 - Find a plug!|5                  |forward|
      | Organize Your Course Materials|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Organize Your Course Materials|6|forward|
      | Create an Organizational Style|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Create an Organizational Style|7|forward|
      | Tip #3 - Cloud services|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #3 - Cloud services|8              |forward|
      | Tip #4 - Organize e-learning|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #4 - Organize e-learning|9    |forward|
      | Tip #5 - Naming your files|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #5 - Naming your files|10       |forward|
      | Tip #6 - Version control|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #6 - Version control|11           |forward|
      | Tip #7 - Back up your files!|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #7 - Back up your files!|12   |forward|
      | Organize Your Time|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Organize Your Time|13                       |forward|
      | Tip #8 - Create a calendar|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #8 - Create a calendar|14       |forward|
      | Tip #9 - Break it up!|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #9 - Break it up!|15                 |forward|
      | Tip #10 - Use an alert/alarm|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Tip #10 - Use an alert/alarm|16|forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|17|forward|
  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Introduction|2|rewind|
      | Organize Your Environment|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Organize Your Environment|3|rewind|
      | Tip #1 - Know your constraints|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #1 - Know your constraints|4|rewind|
      | Tip #2 - Find a plug!|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #2 - Find a plug!|5                  |rewind|
      | Organize Your Course Materials|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Organize Your Course Materials|6|rewind|
      | Create an Organizational Style|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Create an Organizational Style|7|rewind|
      | Tip #3 - Cloud services|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #3 - Cloud services|8              |rewind|
      | Tip #4 - Organize e-learning|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #4 - Organize e-learning|9    |rewind|
      | Tip #5 - Naming your files|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #5 - Naming your files|10       |rewind|
      | Tip #6 - Version control|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #6 - Version control|11           |rewind|
      | Tip #7 - Back up your files!|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #7 - Back up your files!|12   |rewind|
      | Organize Your Time|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Organize Your Time|13                       |rewind|
      | Tip #8 - Create a calendar|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #8 - Create a calendar|14       |rewind|
      | Tip #9 - Break it up!|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #9 - Break it up!|15                 |rewind|
      | Tip #10 - Use an alert/alarm|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Tip #10 - Use an alert/alarm|16|rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|17|rewind|
  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Introduction|2|slower|
      | Organize Your Environment|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Organize Your Environment|3|slower|
      | Tip #1 - Know your constraints|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #1 - Know your constraints|4|slower|
      | Tip #2 - Find a plug!|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #2 - Find a plug!|5                  |slower|
      | Organize Your Course Materials|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Organize Your Course Materials|6|slower|
      | Create an Organizational Style|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Create an Organizational Style|7|slower|
      | Tip #3 - Cloud services|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #3 - Cloud services|8              |slower|
      | Tip #4 - Organize e-learning|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #4 - Organize e-learning|9    |slower|
      | Tip #5 - Naming your files|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #5 - Naming your files|10       |slower|
      | Tip #6 - Version control|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #6 - Version control|11           |slower|
      | Tip #7 - Back up your files!|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #7 - Back up your files!|12   |slower|
      | Organize Your Time|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Organize Your Time|13                       |slower|
      | Tip #8 - Create a calendar|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #8 - Create a calendar|14       |slower|
      | Tip #9 - Break it up!|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #9 - Break it up!|15                 |slower|
      | Tip #10 - Use an alert/alarm|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #10 - Use an alert/alarm|16|slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|17|slower|
  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | Introduction|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Introduction|2|faster|
      | Organize Your Environment|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Organize Your Environment|3|faster|
      | Tip #1 - Know your constraints|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #1 - Know your constraints|4|faster|
      | Tip #2 - Find a plug!|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #2 - Find a plug!|5                  |faster|
      | Organize Your Course Materials|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Organize Your Course Materials|6|faster|
      | Create an Organizational Style|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Create an Organizational Style|7|faster|
      | Tip #3 - Cloud services|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #3 - Cloud services|8              |faster|
      | Tip #4 - Organize e-learning|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #4 - Organize e-learning|9    |faster|
      | Tip #5 - Naming your files|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #5 - Naming your files|10       |faster|
      | Tip #6 - Version control|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #6 - Version control|11           |faster|
      | Tip #7 - Back up your files!|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #7 - Back up your files!|12   |faster|
      | Organize Your Time|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Organize Your Time|13                       |faster|
      | Tip #8 - Create a calendar|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #8 - Create a calendar|14       |faster|
      | Tip #9 - Break it up!|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #9 - Break it up!|15                 |faster|
      | Tip #10 - Use an alert/alarm|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Tip #10 - Use an alert/alarm|16|faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|17|faster|
  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application