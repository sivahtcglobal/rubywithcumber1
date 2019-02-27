@moodle
Feature: Moodle.User Story 11816 - Remove Tag: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC 11816 Remove the Tag
    Given Login as valid instructor
    Then Click on the Edit setting page and Create new Tag
    Then Add Tag for the Instructor and Save the Changes
    Then Remove Tag for the Instructor and Save the Changes

