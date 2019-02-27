@moodle
Feature: Moodle.User Story 9663 - Create Entry for Database Course Module.

  @IntegrationTest @EndToEndTest
  Scenario: TC  Create a New Entry for Database Course Module
    Given Created a New Entry for Database Page for a Course
    When The New Entry for Database Page Got successfully created
    Then An Event for New Entry for Database Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'data'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'data_record'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'data'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
