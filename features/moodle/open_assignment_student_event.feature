@moodle
Feature: Moodle.User Story 3971 - Student Event - Open an Assignment

  @IntegrationTest
  Scenario: TC  Open an Assignment for a course by a student
    Given Open an Assignment for a course by a student
    When The Assignment got Opened successfully by the student
    Then An Event for Open an Assignment should get generated and sent to our Raw Event Index.
    And Open an Assignment ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Open an Assignment ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And Open an Assignment ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Open an Assignment ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Open an Assignment ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And Open an Assignment ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Open an Assignment ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC  Open an Assignment for a course by a student
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Open an Assignment for a course by a student
    When The Assignment got Opened successfully by the student
    Then An Event for Open an Assignment should get generated and sent to our Raw Event Index.
    And Open an Assignment ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Open an Assignment ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And Open an Assignment ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Open an Assignment ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Open an Assignment ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And Open an Assignment ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Open an Assignment ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Open an Assignment should get generated and sent to CSV.
    And Open Assignment CSV ['Action'] Column Value = 'Navigated To'
    And Open Assignment CSV ['Page'] Column Value = 'assign'
    And Open Assignment CSV ['Activity Type'] Column Value = 'assign'
    And Open Assignment CSV ['Activity Name'] Column Value = Provided Assignment Name
    And Open Assignment CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Open an Assignment should get generated and sent to Tableau.
    And Open Assignment Tableau ['Action'] Column Value = 'Navigated To'
    And Open Assignment Tableau ['Page'] Column Value = 'assign'
    And Open Assignment Tableau ['Activity Type'] Column Value = 'assign'
    And Open Assignment Tableau ['Activity Name'] Column Value = Provided Assignment Name
    And Open Assignment Tableau ['Data Source'] Column Value = 'Moodle'
