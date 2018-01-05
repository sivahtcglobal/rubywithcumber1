@essentials @canvas
Feature: Intellify Essential DataSource Config and DataTools page element verification
  Scenario:Data tools page element verification
      Given Data Tools-login to with Valid credentials
      And Verify element Present in the home page-data tools
      Then Click on Data Source tab Verify the created Canvas Data Source
      Then click data tools tab
      And Verify the tools added Tableau and CSV
      And Verify the elements in Tableau and CSV Tools
