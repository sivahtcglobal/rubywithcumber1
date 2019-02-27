@moodle
Feature: Moodle.User Story 3973 - Quiz Attempt Started: Student Event and User Story 3974 - Quiz Attempt Submitted: Student Event

  @IntegrationTest
  Scenario: TC 5290 Start a Quiz Attempt for a course
    Given Started a Quiz Attempt for a course
    When The Quiz Attempt got successfully started by student
    Then An Event for Quiz Attempt Started should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Started'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'quiz_attempt'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest
  Scenario: TC 5291 Submit a Quiz Attempt for a course
    Given Submitted a Quiz Attempt for a course
    When The Quiz Attempt got successfully submitted by student
    Then An Event for Quiz Attempt Submitted should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'quiz_attempt'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5290 Start a Quiz Attempt for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Started a Quiz Attempt for a course
    When The Quiz Attempt got successfully started by student
    Then An Event for Quiz Attempt Started should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Started'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'quiz_attempt'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Quiz Attempt Started should get generated and sent to CSV.
    And Quiz Attempt Started CSV ['Action'] Column Value = 'Started'
    And Quiz Attempt Started CSV ['Page'] Column Value = 'quiz_attempt'
    And Quiz Attempt Started CSV ['Activity Type'] Column Value = 'quiz'
    And Quiz Attempt Started CSV ['Activity Name'] Column Value = Provided Quiz Name
    And Quiz Attempt Started CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Quiz Attempt Started should get generated and sent to Tableau.
    And Quiz Attempt Started Tableau ['Action'] Column Value = 'Started'
    And Quiz Attempt Started Tableau ['Page'] Column Value = 'quiz_attempt'
    And Quiz Attempt Started Tableau ['Activity Type'] Column Value = 'quiz'
    And Quiz Attempt Started Tableau ['Activity Name'] Column Value = Provided Quiz Name
    And Quiz Attempt Started Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC 5291 Submit a Quiz Attempt for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submitted a Quiz Attempt for a course
    When The Quiz Attempt got successfully submitted by student
    Then An Event for Quiz Attempt Submitted should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'quiz_attempt'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Quiz Attempt Submitted should get generated and sent to CSV.
    And Quiz Attempt Submitted CSV ['Action'] Column Value = 'Submitted'
    And Quiz Attempt Submitted CSV ['Page'] Column Value = 'quiz_attempt'
    And Quiz Attempt Submitted CSV ['Activity Type'] Column Value = 'quiz'
    And Quiz Attempt Submitted CSV ['Activity Name'] Column Value = Provided Quiz Name
    And Quiz Attempt Submitted CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Quiz Attempt Submitted should get generated and sent to Tableau.
    And Quiz Attempt Submitted Tableau ['Action'] Column Value = 'Submitted'
    And Quiz Attempt Submitted Tableau ['Page'] Column Value = 'quiz_attempt'
    And Quiz Attempt Submitted Tableau ['Activity Type'] Column Value = 'quiz'
    And Quiz Attempt Submitted Tableau ['Activity Name'] Column Value = Provided Quiz Name
    And Quiz Attempt Submitted Tableau ['Data Source'] Column Value = 'Moodle'
