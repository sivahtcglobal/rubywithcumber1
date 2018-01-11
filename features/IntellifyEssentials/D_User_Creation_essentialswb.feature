@essentials @canvas
Feature: Intellify Essential New User Creation
  Scenario: User Creation in Account setting tab
      Given login to with Valid credentials-User Creation
      And Verify element Present in the home page -User Creation
      Then click Account setting tab-user creation
      Then Create new User role as Non Admin User