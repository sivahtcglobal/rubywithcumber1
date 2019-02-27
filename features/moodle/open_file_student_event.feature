@moodle
Feature: Moodle.User Story 3919 - Student Event: Open a File

  @IntegrationTest @EndToEndTest
  Scenario: TC 5284 Open a File for a course
    Given Opened a File for a course
    When The File got successfully opened
    Then An Event for Open File should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Document'
    And ['event'].['object'].['extensions'].['moduleType'] = 'resource'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
