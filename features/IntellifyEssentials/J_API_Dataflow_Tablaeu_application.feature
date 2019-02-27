@essentials
Feature: API GET Method for Retreive the sensorid,apikey,name of created Datasource to verify data flow in tableau
  Scenario: retreive all data from created Datasource
    Given valid API user-Tableau
    And Retreive the API Token-Tableau
    Then Use GET method to verify the created DataSource and retreive all data from created DataSource-Tableau
    And Use GET method to verify available report in Workbench-Tableau
    And Use GET method to verify the Schema for the Report-Tableau
    And Use GET method to Verify the Data available in the Tableau application