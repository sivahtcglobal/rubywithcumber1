@essentials @canvas
Feature: Intellify Essential User Update & Password Change
  Scenario: User Update & Password Change in Account setting tab
      Given login to with Valid credentials-User Update
      And Verify element Present in the home page -User Update
      Then click Account setting tab-User Update
      Then Update Create Non Admin User as Admin user
      Then Change User Role as Non Admin user