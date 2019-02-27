@moodle
Feature: Moodle.User Story 3987 and 8589 - Complete A Lesson: Student Event and Lesson Question Answered: Student Event

  @IntegrationTest
  Scenario: TC 5289 Complete a Lesson for a course and Lesson Question Answered
    Given Completed a Lesson for a course
    When The Lesson got successfully completed by student
    Then An Event for Complete Lesson should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['count'] = 2
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Lesson Question Answered should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['name'] = Provided Name
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson_question'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5289 Complete a Lesson for a course and Lesson Question Answered
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Completed a Lesson for a course
    When The Lesson got successfully completed by student
    Then An Event for Complete Lesson should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['count'] = 2
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Complete Lesson should get generated and sent to CSV.
    And Complete Lesson CSV ['Action'] Column Value = 'Submitted'
    And Complete Lesson CSV ['Page'] Column Value = 'lesson_timer'
    And Complete Lesson CSV ['Activity Type'] Column Value = 'lesson'
    And Complete Lesson CSV ['Activity Name'] Column Value = Provided Lesson Name
    And Complete Lesson CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Complete Lesson should get generated and sent to Tableau.
    And Complete Lesson Tableau ['Action'] Column Value = 'Submitted'
    And Complete Lesson Tableau ['Page'] Column Value = 'lesson_timer'
    And Complete Lesson Tableau ['Activity Type'] Column Value = 'lesson'
    And Complete Lesson Tableau ['Activity Name'] Column Value = Provided Lesson Name
    And Complete Lesson Tableau ['Data Source'] Column Value = 'Moodle'
    Then An Event for Lesson Question Answered should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['name'] = Provided Name
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson_question'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Lesson Question Answered should get generated and sent to CSV.
    And Lesson Question Answered CSV ['Action'] Column Value = 'Completed'
    And Lesson Question Answered CSV ['Page'] Column Value = 'lesson_question'
    And Lesson Question Answered CSV ['Activity Type'] Column Value = 'lesson'
    And Lesson Question Answered CSV ['Activity Name'] Column Value = Provided Lesson Name
    And Lesson Question Answered CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Lesson Question Answered should get generated and sent to Tableau.
    And Lesson Question Answered Tableau ['Action'] Column Value = 'Completed'
    And Lesson Question Answered Tableau ['Page'] Column Value = 'lesson_question'
    And Lesson Question Answered Tableau ['Activity Type'] Column Value = 'lesson'
    And Lesson Question Answered Tableau ['Activity Name'] Column Value = Provided Lesson Name
    And Lesson Question Answered Tableau ['Data Source'] Column Value = 'Moodle'
