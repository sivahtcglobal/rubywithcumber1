@essentials @canvas
Feature: Non Admin User Essential Valid & invalid login
  Scenario: Verify the Valid Login for NonAdmin user
    Given login with Valid username and password for NonAdmin user
    And Verify the all element in homepage for NonAdmin user
  Scenario: Verify the Invalid Login for NonAdmin user
    Given login with Invalid iusername and ipassword for NonAdmin user
    And Verify the error message for NonAdmin user