@essentials
Feature: Intellify Essential login
  Scenario: Verify the Login page for Intellify Essential
    Given login with Valid username and password for login page
    Then Verify the all element in homepage is displayed
  Scenario: Verify the Invalid Login page for Intellify Essential
    Given login with Invalid iusername and ipassword for login page
    Then Verify the error message in login page