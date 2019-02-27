@workbench
Feature: 6577 - Deleting a Workbench Data Source


  Scenario: Cancelling a Data Source Deletion
    Given Cancelling a Data Source Deletion
    Then Data Source should not get Deleted
    Then Verify Data Source is not Deleted

  Scenario: Deleting a Data Source
    Given Deleting a Data Source
    Then Data Source should get Deleted Successfully
    Then Verify Data Source is not present