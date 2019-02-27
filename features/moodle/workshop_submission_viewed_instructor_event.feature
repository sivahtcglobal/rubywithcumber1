@moodle
Feature: Moodle.User Story 9557 - Workshop Submission Viewed: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC Workshop Submission Viewed for a course
    Given Workshop Submission Viewed for a course
    When The Workshop Submission got successfully viewed by instructor
    Then An Event for Workshop Submission Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['extensions'].['moduleType'] = 'workshop_submission'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
