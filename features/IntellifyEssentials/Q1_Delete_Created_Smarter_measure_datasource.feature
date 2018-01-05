@essentials @smartermeasure
Feature: Delete the Created Smarter Measure Data Source
  Scenario: Delete the Created Smarter Measure Data Source
    Given Login with valid LDAP User-Delete Smarter Measure DS
    And Verify the Created Smarter Measure Data Source
    Then Click on the Delete Icon to Delete the Smarter Measure Data Source
