@workbench
Feature: Workbench.User Story 6566/6586 - Create New Datasource and Update an Existing Datasource

  Scenario: Creation of a New Datasource
    Given Create a New Datasource
    When New Datasource got created Successfully
    Then Verify the created Datasource Active Status,Parent Org,Parent Data collection and UUID

  Scenario: To Update an Existing Datasource
    Given Update an Existing Datasource
    When Existing Datasource got updated successfully
    Then Verify the Datasource updated values
