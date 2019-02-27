@essentials
Feature: Intellify Essential User Creation
  Scenario: User Creation in Account setting tab
      Given login to with Valid credentials-User Creation
      When Verify element Present in the home page -User Creation
      Then click Account setting tab-user creation
      Then Create new User role as Admin and User