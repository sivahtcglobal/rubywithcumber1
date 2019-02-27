@moodle
Feature: Moodle.User Story 9129 - Delete A Wiki Page Comment

  @IntegrationTest
  Scenario: TC Delete A Wiki Page Comment for a course
    Given Deleted a Wiki Page Comment for a course
    When The Wiki Page Comment got successfully deleted
    Then An Event for Delete Wiki Page Comment should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Deleted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'wiki_comment'
    And The ['event'].['object'].['extensions'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['object'].['extensions'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['assignable'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Delete A Wiki Page Comment for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Deleted a Wiki Page Comment for a course
    When The Wiki Page Comment got successfully deleted
    Then An Event for Delete Wiki Page Comment should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Deleted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'wiki_comment'
    And The ['event'].['object'].['extensions'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['object'].['extensions'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['assignable'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Delete Wiki Page Comment should get generated and sent to CSV.
    And Delete Wiki Page Comment CSV ['Action'] Column Value = 'Deleted'
    And Delete Wiki Page Comment CSV ['Page'] Column Value = 'wiki_comment'
    And Delete Wiki Page Comment CSV ['Activity Type'] Column Value = 'wiki'
    And Delete Wiki Page Comment CSV ['Activity Name'] Column Value = Provided Wiki Name
    And Delete Wiki Page Comment CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Delete Wiki Page Comment should get generated and sent to Tableau.
    And Delete Wiki Page Comment Tableau ['Action'] Column Value = 'Deleted'
    And Delete Wiki Page Comment Tableau ['Page'] Column Value = 'wiki_comment'
    And Delete Wiki Page Comment Tableau ['Activity Type'] Column Value = 'wiki'
    And Delete Wiki Page Comment Tableau ['Activity Name'] Column Value = Provided Wiki Name
    And Delete Wiki Page Comment Tableau ['Data Source'] Column Value = 'Moodle'
