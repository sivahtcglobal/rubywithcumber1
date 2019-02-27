@moodle
Feature: Moodle.User Story 9802 - Historical Data Check

  Scenario: TC Uninstall, Reinstall then Configure the Plugin
    Given Uninstall, Reinstall then Configure the Plugin
    When Configuration saved successfully
    Then Course Entities for Users, Courses and Course Categories should get generated and sent to our Raw Entity Index.
