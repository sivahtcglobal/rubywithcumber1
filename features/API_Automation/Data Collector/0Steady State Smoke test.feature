@commonAPI @smoketest
Feature: Smoke Test - Environment Steady State Test
  This test is to make a quick check on the environments data collector state.
  - Sends an Event and Entity to a existing ORG/DC/DS and Compute Stream
  - Verifies it on ES Raw Stream
  - Verifies If DS2 compute Streams Job is running. State: RUNNING
  - Verifies if compute streams processed the Event Data.

  Scenario: Send one Entity data to Data Source Raw Stream
    * Send one Entity data to Data Source Raw Stream
  Scenario: Send one Event data to Data Source Raw Stream
    * Send one Event data to Data Source Raw Stream
  Scenario: Verify if the Event data got received in ES Raw Stream
    * Verify if the Event data got received in ES Raw Stream
  Scenario: Verify if the Entity data got received in ES Raw Stream
    * Verify if the Entity data got received in ES Raw Stream
  Scenario: Verify the Existing DS2.0 Compute Stream Job Status is running
    * Verify the Existing DS2.0 Compute Stream Job Status is running
  Scenario: Verify if Event Data got Processed by the Compute Stream
    * Verify if Event Data got Processed by the Compute Stream

