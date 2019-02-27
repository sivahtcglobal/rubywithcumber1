@moodle
Feature: Moodle.User Story 9144: Create and Update A Journal Entry - Student Event

  @IntegrationTest
  Scenario: TC Create a New Student Journal Entry for a course
    Given Created a New Student Journal Entry for a course
    When The New Journal Entry got successfully created
    Then An Event for New Journal Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'journal_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest
  Scenario: TC Update the Existing Student Journal Entry for the course
    Given Updated the Existing Student Journal Entry for a course
    When The Existing Journal Entry got successfully updated
    Then An Event for Update Journal Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'journal_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Create a New Student Journal Entry for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Created a New Student Journal Entry for a course
    When The New Journal Entry got successfully created
    Then An Event for New Journal Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'journal_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for New Journal Entry should get generated and sent to CSV.
    And New Journal Entry CSV ['Action'] Column Value = 'Submitted'
    And New Journal Entry CSV ['Page'] Column Value = 'journal_entry'
    And New Journal Entry CSV ['Activity Type'] Column Value = 'journal'
    And New Journal Entry CSV ['Activity Name'] Column Value = Provided Journal Name
    And New Journal Entry CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for New Journal Entry should get generated and sent to Tableau.
    And New Journal Entry Tableau ['Action'] Column Value = 'Submitted'
    And New Journal Entry Tableau ['Page'] Column Value = 'journal_entry'
    And New Journal Entry Tableau ['Activity Type'] Column Value = 'journal'
    And New Journal Entry Tableau ['Activity Name'] Column Value = Provided Journal Name
    And New Journal Entry Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC Update the Existing Student Journal Entry for the course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Updated the Existing Student Journal Entry for a course
    When The Existing Journal Entry got successfully updated
    Then An Event for Update Journal Entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'journal_entry'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Update Journal Entry should get generated and sent to CSV.
    And Update Journal Entry CSV ['Action'] Column Value = 'Submitted'
    And Update Journal Entry CSV ['Page'] Column Value = 'journal_entry'
    And Update Journal Entry CSV ['Activity Type'] Column Value = 'journal'
    And Update Journal Entry CSV ['Activity Name'] Column Value = Provided Journal Name
    And Update Journal Entry CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Update Journal Entry should get generated and sent to Tableau.
    And Update Journal Entry Tableau ['Action'] Column Value = 'Submitted'
    And Update Journal Entry Tableau ['Page'] Column Value = 'journal_entry'
    And Update Journal Entry Tableau ['Activity Type'] Column Value = 'journal'
    And Update Journal Entry Tableau ['Activity Name'] Column Value = Provided Journal Name
    And Update Journal Entry Tableau ['Data Source'] Column Value = 'Moodle'
