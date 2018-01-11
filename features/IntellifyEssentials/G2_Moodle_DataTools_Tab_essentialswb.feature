@essentials @moodle
Feature: Intellify Essential Moodle Report Validation
  Scenario:Data tools page element verification
    Given Data Tools-login to with Valid credentials
    Then click data tools tab
    And Verify the tools added Tableau and CSV
    And Verify the elements in Tableau and CSV Tools-Moodle
