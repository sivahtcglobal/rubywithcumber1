@workbench
Feature: Workbench.User Story - Create a Basic ComputeStream and Update the created ComputeStream

  Scenario: Creation of a Basic ComputeStream
    Given Create a New Basic ComputeStream
    Then The New ComputeStream should get Successfully created
    Then Verify the created ComputeStreams values


  Scenario: Updating the created ComputeStream
    Given Update a the ComputeStream
    Then The ComputeStream should get Successfully updated
    Then Verify the updated ComputeStreams updated values