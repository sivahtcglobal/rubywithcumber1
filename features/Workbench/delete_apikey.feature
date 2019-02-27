@workbench
Feature: Workbench. 6579 - Deleting an API Key

  Scenario: Cancelling API Key Deletion
    Given Cancelling API Key Deletion
    Then API key should get not Deleted
    Then Verify API key is not Deleted

  Scenario: Deleting an API Key
    Given Deleting an API Key
    Then API key should get Deleted Successfully
    Then Verify API key is not present