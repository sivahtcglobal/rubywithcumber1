@workbench
Feature: Workbench 2.0 User Story 6559 - Login Page Validation with Valid and Invalid User Credentials

  Scenario: Verify login attempt with empty username and password
    Given Attempt to Login with empty Login credentials
    Then Verify Failed Login Alert Message gets displayed
    Then Should not get logged in to the Home Page

  Scenario: Verify login attempt with invalid login credentials
    Given Attempt to Login with Invalid Login credentials
    Then Verify Failed Login Alert Message gets displayed
    Then Should not get logged in to the Home Page

  Scenario: Verify login attempt with valid login credentials
    Given Attempt to Login as Valid Org Admin Credentials
    Then It should Successfully login to the Workbench


