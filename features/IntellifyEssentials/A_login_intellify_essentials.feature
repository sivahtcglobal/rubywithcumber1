@essentials @canvas @smoketest
Feature: Essential UI valid and Invalid login,Forgot Password link
  Scenario: Verify the Login page for Intellify Essential
    Given login with Valid username and password for login page
    And Verify the all element in homepage is displayed
  Scenario: Verify the Invalid Login page for Intellify Essential
    Given login with Invalid iusername and ipassword for login page
    And Verify the error message in login page
    And Verify the forgot password link