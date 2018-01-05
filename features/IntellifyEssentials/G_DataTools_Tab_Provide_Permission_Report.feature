@essentials @canvas
Feature: Intellify Essential DataTools page element verification and provide permission to users
  Scenario:Data tools page Permission Providing
      Given Data Tools tab login to with Valid credentials
      And Verify element in the home page-data tools
      Then click Data Tools tab
      And Verify the Tools added Tableau and CSV
      And Verify the Elements in Tableau and CSV Tools
      Then Click on Permission in data tools tab and provide permission to users