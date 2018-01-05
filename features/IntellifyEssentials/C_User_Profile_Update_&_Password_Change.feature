@essentials @canvas
Feature: User Profile Update and Password change
  Scenario: User Profile Update and Password change in Essential Home page
      Given login to Essential UI with Valid Essential Admin Credentials
      And Verify all element in the home page as Essential Admin
      Then Edit the User Profile for Essential Admin in home page
      And Change Password for Essential Admin
      When Login with Changed password and verify the User name in Home page
      Then Reset the Profile to original state for Essential Admin
