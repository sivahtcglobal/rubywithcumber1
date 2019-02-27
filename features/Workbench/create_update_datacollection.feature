@workbench
Feature: Workbench.User Story 6564/6584 - Create New Data collection and Update existing Data collection

  Scenario: Create New Data collection in workbench
    Given Create New Data Collection
    When Data collection got created successfully
    Then Verify and Collect the data collection UUID and Parent Org name

  Scenario: Update existing Data collection in workbench
    Given Update Created Data collection
    When Data collection name should get updated successfully
    Then Verify the data collection name got updated successfully