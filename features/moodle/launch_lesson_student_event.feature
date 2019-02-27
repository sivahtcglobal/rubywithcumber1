@moodle
Feature: Moodle.User Story 3985 and 8587 - Launch A Lesson: Student Event and Lesson Question Viewed: Student Event

  @IntegrationTest
  Scenario: TC 5285 Launch a Lesson for a course and Lesson Question Viewed
    Given Launched a Lesson for a course
    When The Lesson got successfully launched by student
    Then An Event for Launch Lesson should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Started'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Lesson Question Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Provided Question Title
    And ['event'].['target'].['extensions'].['moduleType'] = 'lesson_question'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5285 Launch a Lesson for a course and Lesson Question Viewed
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Launched a Lesson for a course
    When The Lesson got successfully launched by student
    Then An Event for Launch Lesson should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Started'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Launch a Lesson should get generated and sent to CSV.
    And Launch Lesson CSV ['Action'] Column Value = 'Started'
    And Launch Lesson CSV ['Page'] Column Value = 'lesson_timer'
    And Launch Lesson CSV ['Activity Type'] Column Value = 'lesson'
    And Launch Lesson CSV ['Activity Name'] Column Value = Provided Lesson Name
    And Launch Lesson CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Launch a Lesson should get generated and sent to Tableau.
    And Launch Lesson Tableau ['Action'] Column Value = 'Started'
    And Launch Lesson Tableau ['Page'] Column Value = 'lesson_timer'
    And Launch Lesson Tableau ['Activity Type'] Column Value = 'lesson'
    And Launch Lesson Tableau ['Activity Name'] Column Value = Provided Lesson Name
    And Launch Lesson Tableau ['Data Source'] Column Value = 'Moodle'
    Then An Event for Lesson Question Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Provided Question Title
    And ['event'].['target'].['extensions'].['moduleType'] = 'lesson_question'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Lesson Question Viewed should get generated and sent to CSV.
    And Lesson Question Viewed CSV ['Action'] Column Value = 'Navigated To'
    And Lesson Question Viewed CSV ['Page'] Column Value = 'lesson'
    And Lesson Question Viewed CSV ['Activity Type'] Column Value = 'lesson'
    And Lesson Question Viewed CSV ['Activity Name'] Column Value = Provided Lesson Name
    And Lesson Question Viewed CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Lesson Question Viewed should get generated and sent to Tableau.
    And Lesson Question Viewed Tableau ['Action'] Column Value = 'Navigated To'
    And Lesson Question Viewed Tableau ['Page'] Column Value = 'lesson'
    And Lesson Question Viewed Tableau ['Activity Type'] Column Value = 'lesson'
    And Lesson Question Viewed Tableau ['Activity Name'] Column Value = Provided Lesson Name
    And Lesson Question Viewed Tableau ['Data Source'] Column Value = 'Moodle'
