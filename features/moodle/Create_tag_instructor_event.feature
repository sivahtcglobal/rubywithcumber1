@moodle
Feature: Moodle.User Story 11816 - Create Tag: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC 11816 Create the Tag
    Given Login as valid instructor
    Then Click on the Edit setting page and Create new Tag
    Then Add Tag for the Instructor and Save the Changes
    And ['entity' ].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity' ].['@type'] == 'http://purl.imsglobal.org/caliper/v1/Entity'
    And ['entity' ].['extensions' ].['edApp' ].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity' ].['extensions' ].['edApp' ].['@id'] == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
    And ['entity' ].['extensions' ].['edApp' ].['@type'] == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity' ].['extensions' ].['edApp' ].['name'] == 'IntellifyLearning'
    And ['entity' ].['extensions' ].['moduleType'] == 'tag'
    And ['entity' ].['extensions' ].['rawname'] == 'tag'
    And ['entity' ].['name'] == 'tag'
