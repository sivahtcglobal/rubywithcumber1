@nightly @moodle
Feature: Moodle.User Story 11802 - Instructor Event - Add Block a Comment for a Given Course

  @IntegrationTest @EndToEndTest
  Scenario: Add Block a Comment for a Given Course
    Given Add Block a Comment for a Given Course
    When Block Comment Got successfully Added for a Given Course
    Then A Block Comment Event for the Given Course should get generated and sent to our Raw Event Index
    And Block Comment Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Block Comment Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And Block Comment Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Block Comment Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Block Comment Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
    And Block Comment Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Block Comment Event ['event'].['object'].['@type'] = 'h ttp://purl.imsglobal.org/caliper/v1/Message'
    And Block Comment Event ['event'].['object'].['body'] = Provided Block Comment
    And Block Comment Event ['event'].['object'].['extensions'].['moduleType'] = 'block_comments'
    And Block Comment Event ['event'].['object'].['extensions'].['courseSection'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Block Comment Event ['event'].['object'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And Block Comment Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Block Comment Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And Block Comment Event ['event'].['object'].['extensions'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Block Comment Event ['event'].['object'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Block Comment Event ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Block Comment Event ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Block Comment Event ['event'].['edApp'].['name'] = 'IntellifyLearning'
