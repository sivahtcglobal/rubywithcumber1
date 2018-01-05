@essentials @canvas
Feature: Delete the Created Essential Data Source
  Scenario: Delete created Essential DataSource
    Given Login with valid LDAP User-Delete DS&DC
    And Verify the Created Data Source
    Then Click on the Delete Icon to Delete the Data Source
