@moodle
Feature: Moodle.User Story 11816 - Add Tag: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC 11816 Add the Tag
    Given Login as valid instructor
    Then Click on the Edit setting page and Create new Tag
    Then Add Tag for the Instructor and Save the Changes
    And ['event'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/Event'
    And ['event'].['action'] == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Added'
    And ['event'].['actor'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['actor'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['edApp'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['edApp'].['@id'] == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
    And ['event'].['edApp'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] == 'IntellifyLearning'
    And ['event'].['extensions'].['entity'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['extensions'].['entity'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['extensions'].['moduleType'] == 'course'
    And ['event'].['object'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['object'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] == 'tab'
    And ['event'].['object'].['extensions'].['name'] == 'tag'
