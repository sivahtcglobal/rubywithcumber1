@essentials @canvas
Feature: Intellify Essential Data sources creation
  Scenario: Data source & data collection creation for Intellify Essential
      Given login to with Valid credentials-datasource creation
      And Verify element Present in the home page
      Then click data source tab
      And Verify element in data source Page
      Then Add new DataSource for organization