@osrt
Feature: OSRT Module10 Media Events
  Scenario Outline: OSRT Media Events
    Given I am logging in as an Student in Canvas Instance
    When I am Successfully logged in to the Canvas Instance and Launched the URL <url> and header name <header> for the Module <modul>
    Examples:
      |url|header|modul|
      |https://intellify.instructure.com/courses/21/modules/items/452|Personal Support - about 5 minutes|personal|
  Scenario Outline: Verify Event gets generated for all the Media Actions
    When I Clicked the Section <sections> for the chaptername <chaptername> and chapternumber <chapternumber> an event should get successfully sent to the Raw Index
    Examples:
      |sections|chaptername|chapternumber|
      |Title|Title         |1            |
      |Problems?|Problems?|2|
      |Challenges|Challenges |3|
      |1 - Life Roles|1 - Life Roles   |4|
      |2 - Alcohol/Drug Use|2 - Alcohol/Drug Use|5|
      |3 - Relationships|3 - Relationships      |6|
      |4 - Cultural Conflicts|4 - Cultural Conflicts|7|
      |5 - Mental Health Issues|5 - Mental Health Issues|8|
      |6 - Imposter Syndrome|6 - Imposter Syndrome|9|
      |7 - Test Anxiety|7 - Test Anxiety    |10|
      |8 - Poor Habits|8 - Poor Habits|11|
      |9 - Too Much Independence Too Soon|9 - Too Much Independence Too Soon |12|
      |10 - Long Absence|10 - Long Absence|13|
      |Conclusion|Conclusion|14|
  Scenario Outline: Verify Event gets generated for Pause Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Title|1|pause|
      |Problems?|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Problems?|2|pause|
      |Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Challenges      |3|pause|
      |1 - Life Roles|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|1 - Life Roles          |4|pause|
      |2 - Alcohol/Drug Use|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|2 - Alcohol/Drug Use                |5|pause|
      |3 - Relationships|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|3 - Relationships          |6|pause|
      |4 - Cultural Conflicts|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|4 - Cultural Conflicts  |7|pause|
      |5 - Mental Health Issues|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|5 - Mental Health Issues        |8|pause|
      |6 - Imposter Syndrome|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|6 - Imposter Syndrome|9|pause|
      |7 - Test Anxiety|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|7 - Test Anxiety    |10|pause|
      |8 - Poor Habits|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|8 - Poor Habits|11|pause|
      |9 - Too Much Independence Too Soon|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|9 - Too Much Independence Too Soon|12|pause|
      |10 - Long Absence|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|10 - Long Absence |13|pause|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Paused|Conclusion|14|pause|

  Scenario Outline: Verify Event gets generated for Play Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Title|1|resume|
      |Problems?|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Problems?|2|resume|
      |Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Challenges     |3|resume|
      |1 - Life Roles|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|1 - Life Roles          |4|resume|
      |2 - Alcohol/Drug Use|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|2 - Alcohol/Drug Use                |5|resume|
      |3 - Relationships|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|3 - Relationships          |6|resume|
      |4 - Cultural Conflicts|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|4 - Cultural Conflicts  |7|resume|
      |5 - Mental Health Issues|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|5 - Mental Health Issues        |8|resume|
      |6 - Imposter Syndrome|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|6 - Imposter Syndrome|9|resume|
      |7 - Test Anxiety|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|7 - Test Anxiety    |10|resume|
      |8 - Poor Habits|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|8 - Poor Habits|11|resume|
      |9 - Too Much Independence Too Soon|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|9 - Too Much Independence Too Soon                          |12|resume|
      |10 - Long Absence|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|10 - Long Absence                                      |13|resume|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed|Conclusion|14|pause|
  Scenario Outline: Verify Event gets generated for Restart Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Title|1|restart|
      |Problems?|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Problems?|2|restart|
      |Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Challenges      |3|restart|
      |1 - Life Roles|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|1 - Life Roles          |4|restart|
      |2 - Alcohol/Drug Use|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|2 - Alcohol/Drug Use                |5|restart|
      |3 - Relationships|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|3 - Relationships          |6|restart|
      |4 - Cultural Conflicts|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|4 - Cultural Conflicts  |7|restart|
      |5 - Mental Health Issues|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|5 - Mental Health Issues        |8|restart|
      |6 - Imposter Syndrome|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|6 - Imposter Syndrome|9|restart|
      |7 - Test Anxiety|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|7 - Test Anxiety    |10|restart|
      |8 - Poor Habits|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|8 - Poor Habits|11|restart|
      |9 - Too Much Independence Too Soon|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|9 - Too Much Independence Too Soon|12|restart|
      |10 - Long Absence|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|10 - Long Absence|13|restart|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#Restarted|Conclusion|14|restart|
  Scenario Outline: Verify Event gets generated for Forward Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Title|1|forward|
      |Problems?|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Problems?|2|forward|
      |Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Challenges      |3|forward|
      |1 - Life Roles|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|1 - Life Roles          |4|forward|
      |2 - Alcohol/Drug Use|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|2 - Alcohol/Drug Use                |5|forward|
      |3 - Relationships|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|3 - Relationships          |6|forward|
      |4 - Cultural Conflicts|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|4 - Cultural Conflicts  |7|forward|
      |5 - Mental Health Issues|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|5 - Mental Health Issues        |8|forward|
      |6 - Imposter Syndrome|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|6 - Imposter Syndrome|9|forward|
      |7 - Test Anxiety|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|7 - Test Anxiety    |10|forward|
      |8 - Poor Habits|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|8 - Poor Habits|11|forward|
      |9 - Too Much Independence Too Soon|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|9 - Too Much Independence Too Soon|12|forward|
      |10 - Long Absence|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|10 - Long Absence|13|forward|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ForwardedTo|Conclusion|14|forward|
  Scenario Outline: Verify Event gets generated for Rewind Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Title|1|rewind|
      |Problems?|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Problems?|2|rewind|
      |Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Challenges     |3|rewind|
      |1 - Life Roles|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|1 - Life Roles          |4|rewind|
      |2 - Alcohol/Drug Use|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|2 - Alcohol/Drug Use                |5|rewind|
      |3 - Relationships|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|3 - Relationships          |6|rewind|
      |4 - Cultural Conflicts|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|4 - Cultural Conflicts  |7|rewind|
      |5 - Mental Health Issues|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|5 - Mental Health Issues        |8|rewind|
      |6 - Imposter Syndrome|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|6 - Imposter Syndrome|9|rewind|
      |7 - Test Anxiety|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|7 - Test Anxiety    |10|rewind|
      |8 - Poor Habits|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|8 - Poor Habits|11|rewind|
      |9 - Too Much Independence Too Soon|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|9 - Too Much Independence Too Soon|12|rewind|
      |10 - Long Absence|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|10 - Long Absence|13|rewind|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#JumpedTo|Conclusion|14|rewind|
  Scenario Outline: Verify Event gets generated for Slower Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|slower|
      |Problems?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Problems?|2|slower|
      |Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Challenges      |3|slower|
      |1 - Life Roles|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|1 - Life Roles          |4|slower|
      |2 - Alcohol/Drug Use|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|2 - Alcohol/Drug Use                |5|slower|
      |3 - Relationships|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|3 - Relationships          |6|slower|
      |4 - Cultural Conflicts|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|4 - Cultural Conflicts  |7|slower|
      |5 - Mental Health Issues|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|5 - Mental Health Issues        |8|slower|
      |6 - Imposter Syndrome|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|6 - Imposter Syndrome|9|slower|
      |7 - Test Anxiety|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|7 - Test Anxiety    |10|slower|
      |8 - Poor Habits|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|8 - Poor Habits|11|slower|
      |9 - Too Much Independence Too Soon|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|9 - Too Much Independence Too Soon|12|slower|
      |10 - Long Absence|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|10 - Long Absence|13|slower|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|14|slower|
  Scenario Outline: Verify Event gets generated for Faster Actions
    When Action for <sections> for the <action> and <chaptername> and <chapternumber> and <itemname>, an event should get generated successfully and sent to the Raw Index
    Examples:
      |sections|action|chaptername|chapternumber|itemname|
      |Title|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Title|1|faster|
      |Problems?|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Problems?|2|faster|
      |Challenges|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Challenges      |3|faster|
      |1 - Life Roles|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|1 - Life Roles          |4|faster|
      |2 - Alcohol/Drug Use|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|2 - Alcohol/Drug Use                |5|faster|
      |3 - Relationships|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|3 - Relationships          |6|faster|
      |4 - Cultural Conflicts|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|4 - Cultural Conflicts  |7|faster|
      |5 - Mental Health Issues|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|5 - Mental Health Issues        |8|faster|
      |6 - Imposter Syndrome|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|6 - Imposter Syndrome|9|faster|
      |7 - Test Anxiety|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|7 - Test Anxiety    |10|faster|
      |8 - Poor Habits|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|8 - Poor Habits|11|faster|
      |9 - Too Much Independence Too Soon|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|9 - Too Much Independence Too Soon|12|faster|
      |10 - Long Absence|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|10 - Long Absence|13|faster|
      |Conclusion|http://purl.imsglobal.org/vocab/caliper/v1/action#ChangedSpeed|Conclusion|14|faster|
  Scenario: Verify Event gets generated for all Tabs
    When I Clicked the Transcript tab an event should get successfully sent to the Raw Index
    When I Clicked the Menu tab an event should get successfully sent to the Raw Index
    When I Clicked the Resource tab an event should get successfully sent to the Raw Index
    When I Clicked the Help tab an event should get successfully sent to the Raw Index
    Then Logout Application