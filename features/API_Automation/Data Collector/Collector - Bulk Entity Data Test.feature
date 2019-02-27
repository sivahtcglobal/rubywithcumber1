@commonAPI @collectorAPITest @ignoreInK12
Feature: Collector - Bulk Entity Data Test

  Scenario: Send Bulk Event data array of 5 events to the raw stream
* Send Bulk Event data array of 5 events to the raw stream
  Scenario: Verify that the Bulk Event Raw stream Attribute data
* Verify that the Bulk Event Raw stream Attribute data
  Scenario: Send Bulk Event data array of 3 events  to the raw stream
* Send Bulk Event data array of 3 events  to the raw stream
  Scenario: Verify again that the Bulk Event Raw stream Attribute data
* Verify again that the Bulk Event Raw stream Attribute data
  @ignoreInClient
  Scenario: Send Bulk Event data array of 2 events with bad sensorID in all events - expect fail
* Send Bulk Event data array of 2 events with bad sensorID in all events - expect fail
  @ignoreInClient
  Scenario: Send Bulk Event data array of 2 events with bad sensorID in one out of two events - expect fail
* Send Bulk Event data array of 2 events with bad sensorID in one out of two events - expect fail
  Scenario: Send raw Bulk Event array instead of object with array in it
* Send raw Bulk Event array instead of object with array in it
  Scenario: Send Bulk Entity data array of 6 entities to the raw stream
* Send Bulk Entity data array of 6 entities to the raw stream
  Scenario: Verify that the Bulk Entity Raw stream Attribute data
* Verify that the Bulk Entity Raw stream Attribute data
  Scenario: Again Send Bulk Entity data array of 6 entities to the raw stream
* Again Send Bulk Entity data array of 6 entities to the raw stream
  Scenario: Again Verify that the Entity Raw stream Attribute data
* Again Verify that the Bulk Entity Raw stream Attribute data
  @ignoreInClient
  Scenario: Send Bulk Entity data array of 2 entities with bad sensorID in all entities - expect fail
* Send Bulk Entity data array of 2 entities with bad sensorID in all entities - expect fail
  @ignoreInClient
  Scenario: Send Bulk Entity data array of 2 entities with bad sensorID in one out of two entities - expect fail
* Send Bulk Entity data array of 2 entities with bad sensorID in one out of two entities - expect fail
  Scenario: Send raw Bulk Entity array instead of object with array in it
* Send raw Bulk Entity array instead of object with array in it
