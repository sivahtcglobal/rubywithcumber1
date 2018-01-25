@essentials @canvas @smoketest
Feature: Essential UI Delete the Created Canvas Data Source
  Scenario: Delete created Essential DataSource
    Given Login with valid Liass Admin User-Delete Datasource
    And Verify the Created Data Source
    Then Click on the Delete Icon to Delete the Data Source
