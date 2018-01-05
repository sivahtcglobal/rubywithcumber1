@essentials @canvas
Feature: Login using valid essential WB Credentials
  Scenario Outline: Verify the Data flow to Streams
    Given Intellify workbench login Using Valid credentials
    And Retreive the API Token-Stream Data flow
    Then Use GET method to verify the created Datacollection and retreive all data from created Datacollection for Datatype <datatype> -Stream Data flow
    Then Use GET method to verify the created DataSource and retreive all data from created DataSource-Stream Data flow
    Then Verify the Data flow into the Streams
    Examples:
    |datatype|
    |data_collection_5909fb71afaba5518d3855a9|
    |data_collection_596cd5d9b7d7a9570f721701|