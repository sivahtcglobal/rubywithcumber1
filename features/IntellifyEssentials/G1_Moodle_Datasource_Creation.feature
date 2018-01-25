@essentials @moodle @smoketest
Feature: Moodle Data source creation
    Scenario: Moodle Data source creation
      Given login to with Valid credentials as Essential Admin-Moodle
      And Verify element Present in the home page-Moodle
      Then click data source tab-Moodle
      Then Add new DataSource for organization-Moodle
      Then Verify element in data source Page-Moodle
