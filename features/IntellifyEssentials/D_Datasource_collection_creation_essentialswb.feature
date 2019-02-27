@essentials
Feature: Intellify Essential home page Data sources & data collection creation
  Scenario: Data source & data collection creation for Intellify Essential
      Given login to with Valid credentials-datasource creation
      When Verify element Present in the home page
      Then click data source tab
      And Verify element in data source Page
      And Add new DataSource for organization