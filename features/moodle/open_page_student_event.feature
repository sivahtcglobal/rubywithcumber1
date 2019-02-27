@moodle
Feature: Moodle.User Story 3976 - Student Event: Open a Page

  @IntegrationTest
  Scenario: TC 5163 Open a Page for a course
    Given Opened a Page for a course
    When The Page got successfully opened
    Then An Event for Open Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/WebPage'
    And ['event'].['object'].['extensions'].['moduleType'] = 'page'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5163 Open a Page for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Opened a Page for a course
    When The Page got successfully opened
    Then An Event for Open Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/WebPage'
    And ['event'].['object'].['extensions'].['moduleType'] = 'page'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Open Page should get generated and sent to CSV.
    And Open Page CSV ['Action'] Column Value = 'Navigated To'
    And Open Page CSV ['Page'] Column Value = 'page'
    And Open Page CSV ['Activity Type'] Column Value = 'page'
    And Open Page CSV ['Activity Name'] Column Value = Provided Page Name
    And Open Page CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Open Page should get generated and sent to Tableau.
    And Open Page Tableau ['Action'] Column Value = 'Navigated To'
    And Open Page Tableau ['Page'] Column Value = 'page'
    And Open Page Tableau ['Activity Type'] Column Value = 'page'
    And Open Page Tableau ['Activity Name'] Column Value = Provided Page Name
    And Open Page Tableau ['Data Source'] Column Value = 'Moodle'
