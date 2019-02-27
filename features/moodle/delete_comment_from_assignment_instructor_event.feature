@moodle
Feature: Moodle.User Story 5329 Instructor Event - Delete Comment From Assignment.

  @IntegrationTest @EndToEndTest
  Scenario: TC 5946 Delete comment from assignment for a course
    Given Deleted Comment from Assignment for a course
    When The Comment got successfully deleted by instructor
    Then An Event for Delete Comment should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Deleted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign_comment'
    And The ['event'].['object'].['extensions'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['object'].['extensions'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
