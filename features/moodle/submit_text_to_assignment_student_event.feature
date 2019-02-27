@moodle
Feature: Moodle.User Story 5331 - Submitted Text To Assignment - Student Event

  @IntegrationTest
  Scenario: TC 5883 Submit text to assignment for a course
    Given Submitted Text to Assignment for a course
    When The Text got successfully submitted by student
    Then An Event for Submitted Text should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign_text'
    And ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5883 Submit text to assignment for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submitted Text to Assignment for a course
    When The Text got successfully submitted by student
    Then An Event for Submitted Text should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign_text'
    And ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Submitted Text should get generated and sent to CSV.
    And Submitted Text CSV ['Action'] Column Value = 'Completed'
    And Submitted Text CSV ['Page'] Column Value = 'assign_text'
    And Submitted Text CSV ['Activity Type'] Column Value = 'assign'
    And Submitted Text CSV ['Activity Name'] Column Value = Provided Assignment Name
    And Submitted Text CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Submitted Text should get generated and sent to Tableau.
    And Submitted Text Tableau ['Action'] Column Value = 'Completed'
    And Submitted Text Tableau ['Page'] Column Value = 'assign_text'
    And Submitted Text Tableau ['Activity Type'] Column Value = 'assign'
    And Submitted Text Tableau ['Activity Name'] Column Value = Provided Assignment Name
    And Submitted Text Tableau ['Data Source'] Column Value = 'Moodle'
