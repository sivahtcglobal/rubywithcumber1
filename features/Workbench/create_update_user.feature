@workbench
Feature: Workbench.User Story 6563/6581 - Create as new Designer user and Update an existing Designer user

  Scenario: Create new user with organization designer role
    Given Create new Designer user with organization designer role
    When New Designer user created successfully
    Then Verify the created user gets displayed in the tree view user list

  Scenario: Update an existing User profile as a different user.
    Given Update Created user profile as a different user
    When Very that user profile was not allowed to get updated by a different user

  Scenario: Update an existing User profile as a the same user.
    Given Update Created user profile as the same user
    When Very that user profile was allowed to get updated by the same user
    Then Verify the updated user profile information
