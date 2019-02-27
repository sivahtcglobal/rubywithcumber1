@nightly @moodle
Feature: Moodle.User Story   and  - Create and Update A Question Page (DEFERRED)

  Scenario Outline: TC Create a New Question Page for a Lesson
    Given Created a New  <type> type Question Page for a Lesson
    When The New Question Pag Got successfully created
    Then A Entity for New Question Page should get generated and sent to our Raw Entity Index.

    And pending
    Examples:
      |type|
      |Essay|
      |Matching|
      |Multichoice|
      |Numerical|
      |Short answer|
      |True/false|

  Scenario Outline: TC  Update the created Question Page for the Lesson
    Given Updated the <types> type Created Question Page for the Lesson
    When The Question Page Got successfully Updated
    Then A Entity for Update Question Page should get generated and sent to our Raw Entity Index.

    And pending

  Examples:
  |types|
  |Essay|
  |Matching|
  |Multichoice|
  |Numerical|
  |Short answer|
  |True/false|