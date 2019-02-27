@moodle
Feature: Moodle.User Story 9120 - Add A Wiki Page Comment

  @IntegrationTest
  Scenario: TC Add A Wiki Page Comment for a course
    Given Added a Wiki Page Comment for a course
    When The Wiki Page Comment got successfully added
    Then An Event for Wiki Page Comment should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
    And ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'wiki_comment'
    And The ['event'].['object'].['extensions'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['object'].['extensions'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['assignable'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['object'].['body'] = Provided Wiki Page Comment
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Add A Wiki Page Comment for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Added a Wiki Page Comment for a course
    When The Wiki Page Comment got successfully added
    Then An Event for Wiki Page Comment should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
    And ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Message'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'wiki_comment'
    And The ['event'].['object'].['extensions'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['object'].['extensions'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['assignable'].['extensions'].['moduleType'] = 'wiki'
    And ['event'].['object'].['body'] = Provided Wiki Page Comment
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Wiki Page Comment should get generated and sent to CSV.
    And Wiki Page Comment CSV ['Action'] Column Value = 'Posted'
    And Wiki Page Comment CSV ['Page'] Column Value = 'wiki_comment'
    And Wiki Page Comment CSV ['Activity Type'] Column Value = 'wiki'
    And Wiki Page Comment CSV ['Activity Name'] Column Value = Provided Wiki Name
    And Wiki Page Comment CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Wiki Page Comment should get generated and sent to Tableau.
    And Wiki Page Comment Tableau ['Action'] Column Value = 'Posted'
    And Wiki Page Comment Tableau ['Page'] Column Value = 'wiki_comment'
    And Wiki Page Comment Tableau ['Activity Type'] Column Value = 'wiki'
    And Wiki Page Comment Tableau ['Activity Name'] Column Value = Provided Wiki Name
    And Wiki Page Comment Tableau ['Data Source'] Column Value = 'Moodle'
