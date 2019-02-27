@essentials
Feature: Delete the Created Data Source and Data Collection
  Scenario: Delete created DataSource & DataCollection
    Given valid API user-Delete DS&DC
    And Retreive the API Token-Delete DS&DC
    Then Use GET method to verify the created DataSource and retreive all data from created DataSource-Delete DS&DC
    Then Use Get method to Retreive the Created Data collection
    Then Use Get method to Retreive collection UUID
    Then Use Delete Method to delete the created DC and DS