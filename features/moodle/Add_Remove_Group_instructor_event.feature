@moodle
Feature: Moodle.User Story 11919 - Add and Remove Group: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC 11919 Add and Remove the Group
    Given Login as valid instructor-Group
    Then Create New Grouping name and Save grouping-group
    Then Add the Group for the Users
    Then Add Group in Grouping
    Then Group Event should generated and send to Raw index
    And ['GROUP'].['event'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/Event'
    And ['GROUP'].['event'].['action'] == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Added'
    And ['GROUP'].['event'].['actor'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['actor'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['GROUP'].['event'].['edApp'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['edApp'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['GROUP'].['event'].['edApp'].['name'] == 'IntellifyLearning'
    And ['GROUP'].['event'].['extensions'].['group'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['extensions'].['group'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['GROUP'].['event'].['extensions'].['group'].['extensions'].['moduleType'] == 'group'
    And ['GROUP'].['event'].['extensions'].['moduleType'] == 'grouping_group'
    And ['GROUP'].['event'].['object'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['object'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['GROUP'].['event'].['object'].['extensions'].['moduleType'] == 'grouping
    Then Remove added Group for the user
    Then Group Event should generated for Removed and send to Raw index
    And ['GROUP'].['event'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/Event'
    And ['GROUP'].['event'].['action'] == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Removed'
    And ['GROUP'].['event'].['actor'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['actor'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['GROUP'].['event'].['edApp'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['edApp'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['GROUP'].['event'].['edApp'].['name'] == 'IntellifyLearning'
    And ['GROUP'].['event'].['extensions'].['group'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['extensions'].['group'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['GROUP'].['event'].['extensions'].['group'].['extensions'].['moduleType'] == 'group'
    And ['GROUP'].['event'].['extensions'].['moduleType'] == 'grouping_group'
    And ['GROUP'].['event'].['object'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUP'].['event'].['object'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['GROUP'].['event'].['object'].['extensions'].['moduleType'] == 'grouping