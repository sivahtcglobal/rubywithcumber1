@nightly @moodle @smoketest
Feature: Moodle.User Story 3981 and 3982 Login and Logout Event

  @IntegrationTest @EndToEndTest
  Scenario: TC 5159 Verify that a logging in to moodle sends a event to index
    Given I am logging in as an Student in Moodle
    When I am Successfully logged in to the Moodle
    Then An login event should get successfully sent to the Raw Index
    And The event should have ['event.action'] value as ['http://purl.imsglobal.org/vocab/caliper/v1/action#LoggedIn']
    And The event should have ['event.@type'] value as ['http://purl.imsglobal.org/caliper/v1/SessionEvent']
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC 5160 Verify that a logging out from Moodle sends a event to index
    Given I am logging out of the Moodle
    When I am Successfully Logout from Moodle
    Then An logout event should get successfully sent to the Raw Index
    And The event should have ['event.action'] value as ['http://purl.imsglobal.org/vocab/caliper/v1/action#LoggedOut']
    And The event should have ['event.@type'] value as ['http://purl.imsglobal.org/caliper/v1/SessionEvent']
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
