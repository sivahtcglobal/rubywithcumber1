@moodle
Feature: Moodle.User Story 11245 - Create and Update Database Field

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a Database Field under Database for a course
    Given Create a New Database Field under Database for a course
    When The New Database Field got successfully created
    Then An Event for New Database Field should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'data'
    And The ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['extensions'].['moduleType'] = 'data_field'
    And The ['event'].['generated'].['extensions'].['fieldType'] = 'data_fields'
    And The ['event'].['generated'].['extensions'].['fieldName'] = Provided Field Name
    And The ['event'].['generated'].['extensions'].['fieldDescription'] = Provided Field Description
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'data'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC Update a Database Field under Database for a course
    Given Update an Existing Database Field under Database for a course
    When The Existing Database Field got successfully updated
    Then An Event for Update Database Field should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'data'
    And The ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['extensions'].['moduleType'] = 'data_field'
    And The ['event'].['generated'].['extensions'].['fieldType'] = 'data_fields'
    And The ['event'].['generated'].['extensions'].['fieldName'] = Updated Field Name
    And The ['event'].['generated'].['extensions'].['fieldDescription'] = Updated Field Description
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'data'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
