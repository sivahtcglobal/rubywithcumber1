@moodle
Feature: Moodle.User Story 8590 - Lesson Essay Attempt Viewed: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC Lesson Essay Attempt Viewed for a course
    Given Lesson Essay Attempt Viewed for a course
    When The Essay Attempt got successfully viewed by instructor
    Then An Event for Essay Attempt Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Provided Essay Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'lesson_essay_attempt'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
