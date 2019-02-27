@moodle
Feature: Moodle.User Story 9121: Navigate To Wiki History - Student Event, User Story 9122: Navigate To Wiki Map - Student Event and User Story 9125: Navigate To Wiki Comments - Student Event

  @IntegrationTest @EndToEndTest
  Scenario: TC Navigate to Wiki History for a course
    Given Navigated to Wiki History for a course
    When The Wiki History successfully navigated by student
    Then An Event for Navigate to Wiki History should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Navigated Page Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'wiki_page_history'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC Navigate to Wiki Map for a course
    Given Navigated to Wiki Map for a course
    When The Wiki Map successfully navigated by student
    Then An Event for Navigate to Wiki Map should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Navigated Page Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'wiki_page_map'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC Navigate to Wiki Comments for a course
    Given Navigated to Wiki Comment for a course
    When The Wiki Comment successfully navigated by student
    Then An Event for Navigate to Wiki Comment should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Navigated Page Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'wiki_comments'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
