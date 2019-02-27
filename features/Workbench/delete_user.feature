@workbench
Feature: Workbench.User Story 6580 - Deleting an user

  Scenario: Cancelling a user Deletion
    Given Cancelling a user Deletion
    When User should not get Deleted
    Then Verify Designer user is present

  Scenario: Deleting a user
    Given Deleting a user
    When User should get Deleted Successfully
    Then Verify user is not present
    Then Verify deleted user is not allowed to login