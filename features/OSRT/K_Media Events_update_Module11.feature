@osrt
Feature: OSRT Module11 Media Events
  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/453|Financial Planning - about 5 minutes|financial|

  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      | Title|Title|1|
      | About the Money|About the Money|2|
      | Quick Test|Quick Test|3|
      | Answer|Answer|4|
      | CCC Student|CCC Student|5|
      | ICanAffordCollege.com|ICanAffordCollege.com|6|
      | Additional Costs|Additional Costs|7|
      | CashCourse.org|CashCourse.org|8|
      | The Bottom Line|The Bottom Line|9|
      | Conclusion|Conclusion|10|

  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      | About the Money|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|About the Money|2|pause|
      | Quick Test|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Quick Test|3|pause|
      | Answer|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Answer|4|pause|
      | CCC Student|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|CCC Student|5                  |pause|
      | ICanAffordCollege.com|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|ICanAffordCollege.com|6|pause|
      | Additional Costs|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Additional Costs|7|pause|
      | CashCourse.org|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|CashCourse.org|8              |pause|
      | The Bottom Line|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|The Bottom Line|9    |pause|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|10       |pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      | About the Money|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|About the Money|2|resume|
      | Quick Test|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Quick Test|3|resume|
      | Answer|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Answer|4|resume|
      | CCC Student|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|CCC Student|5                  |resume|
      | ICanAffordCollege.com|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|ICanAffordCollege.com|6|resume|
      | Additional Costs|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Additional Costs|7|resume|
      | CashCourse.org|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|CashCourse.org|8              |resume|
      | The Bottom Line|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|The Bottom Line|9    |resume|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|10       |resume|

  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      | About the Money|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|About the Money|2|restart|
      | Quick Test|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Quick Test|3|restart|
      | Answer|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Answer|4|restart|
      | CCC Student|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|CCC Student|5                  |restart|
      | ICanAffordCollege.com|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|ICanAffordCollege.com|6|restart|
      | Additional Costs|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Additional Costs|7|restart|
      | CashCourse.org|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|CashCourse.org|8              |restart|
      | The Bottom Line|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|The Bottom Line|9    |restart|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|10       |restart|

  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      | About the Money|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|About the Money|2|forward|
      | Quick Test|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Quick Test|3|forward|
      | Answer|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Answer|4|forward|
      | CCC Student|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|CCC Student|5                  |forward|
      | ICanAffordCollege.com|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|ICanAffordCollege.com|6|forward|
      | Additional Costs|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Additional Costs|7|forward|
      | CashCourse.org|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|CashCourse.org|8              |forward|
      | The Bottom Line|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|The Bottom Line|9    |forward|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|10       |forward|

  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      | About the Money|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|About the Money|2|rewind|
      | Quick Test|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Quick Test|3|rewind|
      | Answer|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Answer|4|rewind|
      | CCC Student|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|CCC Student|5                  |rewind|
      | ICanAffordCollege.com|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|ICanAffordCollege.com|6|rewind|
      | Additional Costs|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Additional Costs|7|rewind|
      | CashCourse.org|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|CashCourse.org|8              |rewind|
      | The Bottom Line|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|The Bottom Line|9    |rewind|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|10       |rewind|

  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      | About the Money|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|About the Money|2|slower|
      | Quick Test|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Quick Test|3|slower|
      | Answer|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Answer|4|slower|
      | CCC Student|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|CCC Student|5                  |slower|
      | ICanAffordCollege.com|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|ICanAffordCollege.com|6|slower|
      | Additional Costs|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Additional Costs|7|slower|
      | CashCourse.org|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|CashCourse.org|8              |slower|
      | The Bottom Line|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|The Bottom Line|9    |slower|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|10       |slower|

  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      | Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      | About the Money|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|About the Money|2|faster|
      | Quick Test|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Quick Test|3|faster|
      | Answer|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Answer|4|faster|
      | CCC Student|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|CCC Student|5                  |faster|
      | ICanAffordCollege.com|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|ICanAffordCollege.com|6|faster|
      | Additional Costs|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Additional Costs|7|faster|
      | CashCourse.org|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|CashCourse.org|8              |faster|
      | The Bottom Line|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|The Bottom Line|9    |faster|
      | Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|10       |faster|

  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application