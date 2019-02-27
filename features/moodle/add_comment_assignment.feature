@nightly @moodle
Feature: Moodle.User Story 3968 - Instructor Event - Add Comment to Assignment for a Given Course

  @IntegrationTest @EndToEndTest
  Scenario: TC Add Comment to Assignment for a Given Course
    Given Add Comment to Assignment for a Given Course
    When Comment Got successfully Added to the Assignment for a Given Course
    Then A Assignment Comment Event should get generated and sent to our Raw Event Index
    And Assignment Comment Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Comment Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And Assignment Comment Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Comment Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Assignment Comment Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
    And Assignment Comment Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Comment Event ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And Assignment Comment Event ['event'].['object'].['body'] = Provided Comment
    And The ['event'].['object'].['extensions'].['moduleType'] = 'assign_comment'
    And The ['event'].['object'].['extensions'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['object'].['extensions'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
