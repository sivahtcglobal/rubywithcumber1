@moodle
Feature: Moodle.User Story 9118: Navigate To Wiki - Student Event and User Story 9124: Navigate To Wiki Page - Student Event

  @IntegrationTest
  Scenario: TC Navigate to Wiki for a course
    Given Navigated to Wiki for a course
    When The Wiki successfully navigated by student
    Then An Event for Navigate to Wiki should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Navigate to Wiki Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Navigated Page Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'wiki_page'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Navigate to Wiki for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Navigated to Wiki for a course
    When The Wiki successfully navigated by student
    Then An Event for Navigate to Wiki should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Navigate to Wiki should get generated and sent to CSV.
    And Navigate to Wiki CSV ['Action'] Column Value = 'Navigated To'
    And Navigate to Wiki CSV ['Page'] Column Value = 'wiki'
    And Navigate to Wiki CSV ['Activity Type'] Column Value = 'wiki'
    And Navigate to Wiki CSV ['Activity Name'] Column Value = Provided Wiki Name
    And Navigate to Wiki CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Navigate to Wiki should get generated and sent to Tableau.
    And Navigate to Wiki Tableau ['Action'] Column Value = 'Navigated To'
    And Navigate to Wiki Tableau ['Page'] Column Value = 'wiki'
    And Navigate to Wiki Tableau ['Activity Type'] Column Value = 'wiki'
    And Navigate to Wiki Tableau ['Activity Name'] Column Value = Provided Wiki Name
    And Navigate to Wiki Tableau ['Data Source'] Column Value = 'Moodle'
    Then An Event for Navigate to Wiki Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Navigated Page Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'wiki_page'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
