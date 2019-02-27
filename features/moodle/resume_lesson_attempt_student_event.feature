@moodle
Feature: Moodle.User Story 8588 - Resume A Lesson Attempt - Student Event

  @IntegrationTest
  Scenario: TC Resume a Lesson Attempt for a course
    Given Resumed a Lesson Attempt for a course
    When The Lesson attempt got successfully resumed by student
    Then An Event for Resume Lesson Attempt should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['count'] = 2
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Resume a Lesson Attempt for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Resumed a Lesson Attempt for a course
    When The Lesson attempt got successfully resumed by student
    Then An Event for Resume Lesson Attempt should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Resumed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['count'] = 2
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Resume Lesson Attempt should get generated and sent to CSV.
    And Resume Lesson Attempt CSV ['Action'] Column Value = 'Resumed'
    And Resume Lesson Attempt CSV ['Page'] Column Value = 'lesson_timer'
    And Resume Lesson Attempt CSV ['Activity Type'] Column Value = 'lesson'
    And Resume Lesson Attempt CSV ['Activity Name'] Column Value = Provided Lesson Name
    And Resume Lesson Attempt CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Resume Lesson Attempt should get generated and sent to Tableau.
    And Resume Lesson Attempt Tableau ['Action'] Column Value = 'Resumed'
    And Resume Lesson Attempt Tableau ['Page'] Column Value = 'lesson_timer'
    And Resume Lesson Attempt Tableau ['Activity Type'] Column Value = 'lesson'
    And Resume Lesson Attempt Tableau ['Activity Name'] Column Value = Provided Lesson Name
    And Resume Lesson Attempt Tableau ['Data Source'] Column Value = 'Moodle'
