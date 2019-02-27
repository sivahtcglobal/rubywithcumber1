@workbench
Feature: Workbench.User Story 6565/6585 - Create New API key and Update New API key

  Scenario: Creation of New API key for The Data Collection
    Given Creation of New Api key to the Data collection
    When The New API KEY got created successfully
    Then Verify the New API KEY's API Key,Active Status,Parent Org,Parent Data collection and UUID

  Scenario: Update the name of the New API key
    Given Update the name of the New API key
    When Apikey Name got Updated successfully
    Then Verify the updated API KEY's Name