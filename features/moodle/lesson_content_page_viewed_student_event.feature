@moodle
Feature: Moodle.User Story 8586 - Lesson Content Page Viewed - Student Event

  @IntegrationTest
  Scenario: TC Lesson Content Page Viewed for a course
    Given Lesson Content Page Viewed for a course
    When The Lesson Content Page successfully viewed by student
    Then An Event for Lesson Content Page Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Provided Content Page Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'lesson_content_page'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Lesson Content Page Viewed for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Lesson Content Page Viewed for a course
    When The Lesson Content Page successfully viewed by student
    Then An Event for Lesson Content Page Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['target'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Frame'
    And ['event'].['target'].['name'] = Provided Content Page Name
    And ['event'].['target'].['extensions'].['moduleType'] = 'lesson_content_page'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Lesson Content Page Viewed should get generated and sent to CSV.
    And Lesson Content Page Viewed CSV ['Action'] Column Value = 'Navigated To'
    And Lesson Content Page Viewed CSV ['Page'] Column Value = 'lesson'
    And Lesson Content Page Viewed CSV ['Activity Type'] Column Value = 'lesson'
    And Lesson Content Page Viewed CSV ['Activity Name'] Column Value = Provided Lesson Name
    And Lesson Content Page Viewed CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Lesson Content Page Viewed should get generated and sent to Tableau.
    And Lesson Content Page Viewed Tableau ['Action'] Column Value = 'Navigated To'
    And Lesson Content Page Viewed Tableau ['Page'] Column Value = 'lesson'
    And Lesson Content Page Viewed Tableau ['Activity Type'] Column Value = 'lesson'
    And Lesson Content Page Viewed Tableau ['Activity Name'] Column Value = Provided Lesson Name
    And Lesson Content Page Viewed Tableau ['Data Source'] Column Value = 'Moodle'
