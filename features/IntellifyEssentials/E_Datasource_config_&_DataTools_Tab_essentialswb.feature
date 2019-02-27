@essentials
Feature: Intellify Essential datatools page element verification
  Scenario:Data tools page element verification
      Given Data Tools-login to with Valid credentials
      When Verify element Present in the home page-data tools
      And Click on Data Source tab Verify the created Canvas Data Source
      Then click data tools tab
      And Verify the tools added Tableau and CSV
      And Verify the elements in Tableau and CSV Tools