@essentials @canvas @smoketest
Feature: Essential UI User Deletion
  Scenario: User Deletion in Account setting tab
      Given login to with Valid credentials-User Deletion
      And Verify element Present in the home page -User Deletion
      Then click Account setting tab-user Deletion
      Then Delete the Created Non Admin User
