@moodle
Feature: Moodle.User Story 3986 - Instructor Event: Grade Lesson

  @IntegrationTest
  Scenario: TC 5685 Grade a Lesson under a course
    Given Graded a Lesson under a course
    When The Lesson got successfully graded
    Then An Event for grade lesson should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Lesson Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Lesson Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Lesson Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Lesson Contribution Value
    And ['event'].['generated'].['extensions'].['courseTotalGrade'] = courseTotalGrade
    And ['event'].['generated'].['extensions'].['courseTotalPercentage'] = courseTotalPercentage
    And ['event'].['generated'].['extensions'].['courseTotalRange'] = courseTotalRange
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Lesson Total Score

  @EndToEndTest
  Scenario: TC 5685 Grade a Lesson under a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Graded a Lesson under a course
    When The Lesson got successfully graded
    Then An Event for grade lesson should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'lesson_timer'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Lesson Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Lesson Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Lesson Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Lesson Contribution Value
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'lesson'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Lesson Total Score
    Then An Event for Grade Lesson should get generated and sent to CSV.
    And Grade Lesson CSV ['Action'] Column Value = 'Graded'
    And Grade Lesson CSV ['Page'] Column Value = 'lesson'
    And Grade Lesson CSV ['Activity Type'] Column Value = 'lesson'
    And Grade Lesson CSV ['Activity Name'] Column Value = Provided Lesson Name
    And Grade Lesson CSV ['Data Source'] Column Value = 'Moodle'
    And Grade Lesson CSV ['Score'] Column Value = Graded Lesson Total Score
    And Grade Lesson CSV ['Max Score'] Column Value = Provided Lesson Max Grade
    And Grade Lesson CSV ['Score(Percent)'] Column Value = Provided Lesson Percentage
    Then An Event for Grade Lesson should get generated and sent to Tableau.
    And Grade Lesson Tableau ['Action'] Column Value = 'Graded'
    And Grade Lesson Tableau ['Page'] Column Value = 'lesson'
    And Grade Lesson Tableau ['Activity Type'] Column Value = 'lesson'
    And Grade Lesson Tableau ['Activity Name'] Column Value = Provided Lesson Name
    And Grade Lesson Tableau ['Data Source'] Column Value = 'Moodle'
    And Grade Lesson Tableau ['Score'] Column Value = Graded Lesson Total Score
    And Grade Lesson Tableau ['Max Score'] Column Value = Provided Lesson Max Grade
    And Grade Lesson Tableau ['Score(Percent)'] Column Value = Provided Lesson Percentage
