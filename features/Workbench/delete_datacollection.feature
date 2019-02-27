@workbench
Feature: Workbench.User Story 6578 - Deleting a Data Collection

  Scenario: Cancelling a Data Collection Deletion
    Given Cancelling a Data Collection Deletion
    Then Data Collection should not get Deleted

  Scenario: Delete the Data Collection
    Given Delete Data collection
    Then Data Collection Deleted Successfully
    Then Verify Data Collection is not present