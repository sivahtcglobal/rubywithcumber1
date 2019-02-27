@commonAPI @collectorAPITest @ignoreInK12
Feature: Collector - ISO 8601 Date Format

  Scenario: Sent Entity with entity.dateModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Future ISO Date Time)
    * Sent Entity with entity.dateModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Future ISO Date Time)
  Scenario: Sent Entity with entity.dateModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
    * Sent Entity with entity.dateModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
  Scenario: Sent Entity with entity.lastModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
    * Sent Entity with entity.lastModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
  Scenario: Sent Entity with entity.dateModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Before Five Years)
    * Sent Entity with entity.dateModified mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Before Five Years)
  Scenario: Sent Entity with entity.dateModified mentioned as null
    * Sent Entity with entity.dateModified mentioned as null
  Scenario: Sent Entity with entity.dateModified field missing
    * Sent Entity with entity.dateModified field missing
  Scenario: Sent Entity with entity.dateModified mentioned as epoch time
    * Sent Entity with entity.dateModified mentioned as epoch time
  Scenario: Sent Event with event.startedAtTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Future ISO Date Time)
    * Sent Event with event.startedAtTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Future ISO Date Time)
  Scenario: Sent Event with event.startedAtTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
    *  Sent Event with event.startedAtTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
  Scenario: Sent Event with event.eventTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
    * Sent Event with event.eventTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Within Five Years)
  Scenario: Sent Event with event.startedAtTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Before Five Years)
    * Sent Event with event.startedAtTime mentioned as YYYY-MM-DDThh:mm:ss.SSSZ (Past ISO Date Time Before Five Years)
  Scenario: Sent Event with event.startedAtTime mentioned as null
    * Sent Event with event.startedAtTime mentioned as null
  Scenario: Sent Event with event.startedAtTime field missing
    * Sent Event with event.startedAtTime field missing
  Scenario: Sent Event with event.startedAtTime mentioned as epoch time
    * Sent Event with event.startedAtTime mentioned as epoch time
  Scenario: Verify that all the Event Raw stream Attribute data
    * Verify that all the Event Raw stream Attribute data
  Scenario: Verify that the Entity Raw stream Attribute data
    * Verify that the Entity Raw stream Attribute data