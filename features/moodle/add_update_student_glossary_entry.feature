@moodle
Feature: Moodle.User Story 5153 - Add and Update A Student Glossary Entry

  @IntegrationTest
  Scenario: TC 5401 Add a New Student Glossary Entry for a course
    Given Added a New Student Glossary Entry for a course
    When The New Glossary Entry got successfully added
    Then An Event for New Glossary Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'glossary_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest
  Scenario: TC 5401 Update the Existing Student Glossary Entry for the course
    Given Updated the Existing Student Glossary Entry for a course
    When The Existing Glossary Entry got successfully updated
    Then An Event for Update Glossary Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'glossary_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5401 Add a New Student Glossary Entry for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Added a New Student Glossary Entry for a course
    When The New Glossary Entry got successfully added
    Then An Event for New Glossary Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'glossary_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for New Student Glossary Entry should get generated and sent to CSV.
    And New Student Glossary Entry CSV ['Action'] Column Value = 'Submitted'
    And New Student Glossary Entry CSV ['Page'] Column Value = 'glossary_entry'
    And New Student Glossary Entry CSV ['Activity Type'] Column Value = 'glossary'
    And New Student Glossary Entry CSV ['Activity Name'] Column Value = Provided Glossary Name
    And New Student Glossary Entry CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for New Student Glossary Entry should get generated and sent to Tableau.
    And New Student Glossary Entry Tableau ['Action'] Column Value = 'Submitted'
    And New Student Glossary Entry Tableau ['Page'] Column Value = 'glossary_entry'
    And New Student Glossary Entry Tableau ['Activity Type'] Column Value = 'glossary'
    And New Student Glossary Entry Tableau ['Activity Name'] Column Value = Provided Glossary Name
    And New Student Glossary Entry Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC 5401 Update the Existing Student Glossary Entry for the course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Updated the Existing Student Glossary Entry for a course
    When The Existing Glossary Entry got successfully updated
    Then An Event for Update Glossary Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'glossary_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Update Student Glossary Entry should get generated and sent to CSV.
    And Update Student Glossary Entry CSV ['Action'] Column Value = 'Submitted'
    And Update Student Glossary Entry CSV ['Page'] Column Value = 'glossary_entry'
    And Update Student Glossary Entry CSV ['Activity Type'] Column Value = 'glossary'
    And Update Student Glossary Entry CSV ['Activity Name'] Column Value = Provided Glossary Name
    And Update Student Glossary Entry CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Update Student Glossary Entry should get generated and sent to Tableau.
    And Update Student Glossary Entry Tableau ['Action'] Column Value = 'Submitted'
    And Update Student Glossary Entry Tableau ['Page'] Column Value = 'glossary_entry'
    And Update Student Glossary Entry Tableau ['Activity Type'] Column Value = 'glossary'
    And Update Student Glossary Entry Tableau ['Activity Name'] Column Value = Provided Glossary Name
    And Update Student Glossary Entry Tableau ['Data Source'] Column Value = 'Moodle'
