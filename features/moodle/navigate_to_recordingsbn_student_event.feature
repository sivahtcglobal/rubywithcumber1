@moodle
Feature: Moodle.User Story 11079: Navigate To RecordingsBN - Student Event

  @IntegrationTest
  Scenario: TC Navigate to RecordingsBN for a course
    Given Navigated to RecordingsBN for a course
    When The RecordingsBN successfully navigated by student
    Then An Event for Navigate to RecordingsBN should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'recordingsbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Navigate to RecordingsBN for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Navigated to RecordingsBN for a course
    When The RecordingsBN successfully navigated by student
    Then An Event for Navigate to RecordingsBN should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'recordingsbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Navigate to RecordingsBN should get generated and sent to CSV.
    And Navigate to RecordingsBN CSV ['Action'] Column Value = 'Navigated To'
    And Navigate to RecordingsBN CSV ['Page'] Column Value = 'recordingsbn'
    And Navigate to RecordingsBN CSV ['Activity Type'] Column Value = 'recordingsbn'
    And Navigate to RecordingsBN CSV ['Activity Name'] Column Value = Provided RecordingsBN Name
    And Navigate to RecordingsBN CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Navigate to RecordingsBN should get generated and sent to Tableau.
    And Navigate to RecordingsBN Tableau ['Action'] Column Value = 'Navigated To'
    And Navigate to RecordingsBN Tableau ['Page'] Column Value = 'recordingsbn'
    And Navigate to RecordingsBN Tableau ['Activity Type'] Column Value = 'recordingsbn'
    And Navigate to RecordingsBN Tableau ['Activity Name'] Column Value = Provided RecordingsBN Name
    And Navigate to RecordingsBN Tableau ['Data Source'] Column Value = 'Moodle'
