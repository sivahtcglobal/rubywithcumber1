@moodle
Feature: Moodle.User Story 8585 and 6347 - Student Event: Questionnaire Attempt Resumed and Submit a Questionnaire

  @IntegrationTest
  Scenario: TC Questionnaire Attempt Resumed as a Student
    Given Resume a Questionnaire Attempt as a Student
    When Questionnaire attempt resumed successfully by the Student
    Then Resume a Questionnaire attempt event should get generated and sent to our Raw Event Index
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'questionnaire_response'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest
  Scenario: TC 7200 Submit a Questionnaire as a Student
    Given Submit a Questionnaire as a Student
    When Questionnaire got submitted successfully by the Student
    Then Submit a Questionnaire event should get generated and sent to our Raw Event Index
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'questionnaire_response'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Questionnaire Attempt Resumed as a Student
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Resume a Questionnaire Attempt as a Student
    When Questionnaire attempt resumed successfully by the Student
    Then Resume a Questionnaire attempt event should get generated and sent to our Raw Event Index
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'questionnaire_response'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Questionnaire Attempt Resumed should get generated and sent to CSV.
    And Questionnaire Attempt Resumed CSV ['Action'] Column Value = 'Resumed'
    And Questionnaire Attempt Resumed CSV ['Page'] Column Value = 'questionnaire_response'
    And Questionnaire Attempt Resumed CSV ['Activity Type'] Column Value = 'questionnaire'
    And Questionnaire Attempt Resumed CSV ['Activity Name'] Column Value = Provided Questionnaire Name
    And Questionnaire Attempt Resumed CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Questionnaire Attempt Resumed should get generated and sent to Tableau.
    And Questionnaire Attempt Resumed Tableau ['Action'] Column Value = 'Resumed'
    And Questionnaire Attempt Resumed Tableau ['Page'] Column Value = 'questionnaire_response'
    And Questionnaire Attempt Resumed Tableau ['Activity Type'] Column Value = 'questionnaire'
    And Questionnaire Attempt Resumed Tableau ['Activity Name'] Column Value = Provided Questionnaire Name
    And Questionnaire Attempt Resumed Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC 7200 Submit a Questionnaire as a Student
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submit a Questionnaire as a Student
    When Questionnaire got submitted successfully by the Student
    Then Submit a Questionnaire event should get generated and sent to our Raw Event Index
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'questionnaire_response'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Submit a Questionnaire should get generated and sent to CSV.
    And Submit Questionnaire CSV ['Action'] Column Value = 'Submitted'
    And Submit Questionnaire CSV ['Page'] Column Value = 'questionnaire_response'
    And Submit Questionnaire CSV ['Activity Type'] Column Value = 'questionnaire'
    And Submit Questionnaire CSV ['Activity Name'] Column Value = Provided Questionnaire Name
    And Submit Questionnaire CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Submit a Questionnaire should get generated and sent to Tableau.
    And Submit Questionnaire Tableau ['Action'] Column Value = 'Submitted'
    And Submit Questionnaire Tableau ['Page'] Column Value = 'questionnaire_response'
    And Submit Questionnaire Tableau ['Activity Type'] Column Value = 'questionnaire'
    And Submit Questionnaire Tableau ['Activity Name'] Column Value = Provided Questionnaire Name
    And Submit Questionnaire Tableau ['Data Source'] Column Value = 'Moodle'
