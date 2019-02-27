@moodle
Feature: Moodle.User Story 3989 - Student Event: Create Topic

  @IntegrationTest
  Scenario: TC 5426 Create a Topic(Discussion) under Advanced Forum for a course
    Given Added a New Topic(Discussion) under Advanced Forum for a course
    When The New Topic got successfully added
    Then An Event for New Topic should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'hsuforum'
    And The ['event'].['generated'].['@id'] value includes the topic id created by student
    And The ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['name'] = Provided value
    And The ['event'].['generated'].['extensions'].['moduleType'] = 'hsuforum_discussion'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5426 Create a Topic(Discussion) under Advanced Forum for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Added a New Topic(Discussion) under Advanced Forum for a course
    When The New Topic got successfully added
    Then An Event for New Topic should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['object'].['extensions'].['moduleType'] = 'hsuforum'
    And The ['event'].['generated'].['@id'] value includes the topic id created by student
    And The ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['name'] = Provided value
    And The ['event'].['generated'].['extensions'].['moduleType'] = 'hsuforum_discussion'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for student create topic should get generated and sent to CSV.
    And Student Create Topic CSV ['Action'] Column Value = 'Submitted'
    And Student Create Topic CSV ['Page'] Column Value = 'hsuforum_discussion'
    And Student Create Topic CSV ['Activity Type'] Column Value = 'hsuforum'
    And Student Create Topic CSV ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Student Create Topic CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for student create topic should get generated and sent to Tableau.
    And Student Create Topic Tableau ['Action'] Column Value = 'Submitted'
    And Student Create Topic Tableau ['Page'] Column Value = 'hsuforum_discussion'
    And Student Create Topic Tableau ['Activity Type'] Column Value = 'hsuforum'
    And Student Create Topic Tableau ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Student Create Topic Tableau ['Data Source'] Column Value = 'Moodle'
