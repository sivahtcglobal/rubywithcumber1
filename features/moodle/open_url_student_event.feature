@moodle
Feature: Moodle.User Story 3992 - Student Event: Open URL

  @IntegrationTest
  Scenario: TC 5161 Open a URL for a course
    Given Opened a URL for a course
    When The URL got successfully opened
    Then An Event for Open URL should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/WebPage'
    And ['event'].['object'].['extensions'].['moduleType'] = 'url'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5161 Open a URL for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Opened a URL for a course
    When The URL got successfully opened
    Then An Event for Open URL should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/WebPage'
    And ['event'].['object'].['extensions'].['moduleType'] = 'url'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Open URL should get generated and sent to CSV.
    And Open URL CSV ['Action'] Column Value = 'Navigated To'
    And Open URL CSV ['Page'] Column Value = 'url'
    And Open URL CSV ['Activity Type'] Column Value = 'url'
    And Open URL CSV ['Activity Name'] Column Value = Provided URL Name
    And Open URL CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Open URL should get generated and sent to Tableau.
    And Open URL Tableau ['Action'] Column Value = 'Navigated To'
    And Open URL Tableau ['Page'] Column Value = 'url'
    And Open URL Tableau ['Activity Type'] Column Value = 'url'
    And Open URL Tableau ['Activity Name'] Column Value = Provided URL Name
    And Open URL Tableau ['Data Source'] Column Value = 'Moodle'
