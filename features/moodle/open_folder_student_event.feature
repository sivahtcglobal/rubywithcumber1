@moodle
Feature: Moodle.User Story 4253 - Student Event: Open a Folder

  @IntegrationTest
  Scenario: TC 7190 Open a Folder for a course
    Given Opened a Folder for a course
    When The Folder got successfully opened
    Then An Event for Open Folder should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@id'] value includes the folder id opened by student
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Entity'
    And ['event'].['object'].['extensions'].['moduleType'] = 'folder'
    And ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 7190 Open a Folder for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Opened a Folder for a course
    When The Folder got successfully opened
    Then An Event for Open Folder should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@id'] value includes the folder id opened by student
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Entity'
    And ['event'].['object'].['extensions'].['moduleType'] = 'folder'
    And ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Open Folder should get generated and sent to CSV.
    And Open Folder CSV ['Action'] Column Value = 'Navigated To'
    And Open Folder CSV ['Page'] Column Value = 'folder'
    And Open Folder CSV ['Activity Type'] Column Value = 'folder'
    And Open Folder CSV ['Activity Name'] Column Value = Provided Folder Name
    And Open Folder CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Open Folder should get generated and sent to Tableau.
    And Open Folder Tableau ['Action'] Column Value = 'Navigated To'
    And Open Folder Tableau ['Page'] Column Value = 'folder'
    And Open Folder Tableau ['Activity Type'] Column Value = 'folder'
    And Open Folder Tableau ['Activity Name'] Column Value = Provided Folder Name
    And Open Folder Tableau ['Data Source'] Column Value = 'Moodle'
