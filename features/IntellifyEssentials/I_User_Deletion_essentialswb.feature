@essentials
Feature: Intellify Essential User Deletion
  Scenario: User Deletion in Account setting tab
      Given login to with Valid credentials-User Deletion
      When Verify element Present in the home page -User Deletion
      Then click Account setting tab-user Deletion
      Then Delete the Created Non Admin User
