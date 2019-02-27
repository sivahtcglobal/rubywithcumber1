@moodle
Feature: Moodle.User Story 11803 - Create and Update A Blog Entry

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Blog Entry under a course
    Given Created a New Blog Entry under a course
    When The New Blog Entry got successfully created
    Then An Event for New Blog Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And ['event'].['object'].['body'] = Provided Description
    And ['event'].['object'].['extensions'].['moduleType'] = 'blog_entry'
    And ['event'].['object'].['extensions'].['publishTo'] = 'draft'
    And ['event'].['object'].['extensions'].['subject'] = Provided Blog Name
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Blog Entry under a course
    Given Updated the existing Blog Entry under a course
    When The existing Blog Entry got successfully updated
    Then An Event for Update Blog Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And Updated ['event'].['object'].['body'] = Provided Description
    And ['event'].['object'].['extensions'].['moduleType'] = 'blog_entry'
    And Updated ['event'].['object'].['extensions'].['publishTo'] = 'site'
    And Updated ['event'].['object'].['extensions'].['subject'] = Provided Blog Name
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
