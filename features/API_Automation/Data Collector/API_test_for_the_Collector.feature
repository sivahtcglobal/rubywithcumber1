@commonAPI @collectorAPITest
Feature: API test for the Collector

  Scenario: Send Entity data to the raw stream
    * Send Entity data to the raw stream
  @ignoreInClient
  Scenario: Send Entity data with Bad SensorId - expect fail
    * Send Entity data with Bad SensorId - expect fail
  @ignoreInClient
  Scenario: Send Entity data with Bad API Key
    * Send Entity data with Bad API Key
  Scenario: Sent Entity with entity.dateModified type changed from long to String
    * Sent Entity with entity.dateModified type changed from long to String
  Scenario: Sent Event Data to the raw stream
    * Sent Event Data to the raw stream
  @ignoreInClient
  Scenario: Sent Event Data with Bad SensorId - expect fail
    * Sent Event Data with Bad SensorId - expect fail
  @ignoreInClient
  Scenario: Sent Event Data with Bad API Key
    * Sent Event Data with Bad API Key
  Scenario: Sent Event with event.actor.dateModified type changed from long to String
    * Sent Event with event.actor.dateModified type changed from long to String
  Scenario: Verify that the Event Raw stream Attribute data
    * Verify that the Sent Events in the Raw the stream
  Scenario: Verify that the Entities Raw stream Attribute data
    * Verify that the Sent Entities in the Raw the stream
