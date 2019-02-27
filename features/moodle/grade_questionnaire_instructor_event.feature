@moodle
Feature: Moodle.User Story 8182 - Instructor Event: Grade Questionnaire

  @IntegrationTest
  Scenario: TC 8551 Grade a Questionnaire under a course
    Given Graded a Questionnaire under a course
    When The Questionnaire got successfully graded
    Then An Event for grade questionnaire should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'questionnaire_response'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Questionnaire Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Questionnaire Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Questionnaire Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Questionnaire Contribution Value
    And ['event'].['generated'].['extensions'].['courseTotalGrade'] = courseTotalGrade
    And ['event'].['generated'].['extensions'].['courseTotalPercentage'] = courseTotalPercentage
    And ['event'].['generated'].['extensions'].['courseTotalRange'] = courseTotalRange
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Questionnaire Total Score

  @EndToEndTest
  Scenario: TC 8551 Grade a Questionnaire under a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Graded a Questionnaire under a course
    When The Questionnaire got successfully graded
    Then An Event for grade questionnaire should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'questionnaire_response'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Questionnaire Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Questionnaire Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Questionnaire Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Questionnaire Contribution Value
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'questionnaire'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Questionnaire Total Score
    Then An Event for Grade Questionnaire should get generated and sent to CSV.
    And Grade Questionnaire CSV ['Action'] Column Value = 'Graded'
    And Grade Questionnaire CSV ['Page'] Column Value = 'questionnaire'
    And Grade Questionnaire CSV ['Activity Type'] Column Value = 'questionnaire'
    And Grade Questionnaire CSV ['Activity Name'] Column Value = Provided Questionnaire Name
    And Grade Questionnaire CSV ['Data Source'] Column Value = 'Moodle'
    And Grade Questionnaire CSV ['Score'] Column Value = Graded Questionnaire Total Score
    And Grade Questionnaire CSV ['Max Score'] Column Value = Provided Questionnaire Max Grade
    And Grade Questionnaire CSV ['Score(Percent)'] Column Value = Provided Questionnaire Percentage
    Then An Event for Grade Questionnaire should get generated and sent to Tableau.
    And Grade Questionnaire Tableau ['Action'] Column Value = 'Graded'
    And Grade Questionnaire Tableau ['Page'] Column Value = 'questionnaire'
    And Grade Questionnaire Tableau ['Activity Type'] Column Value = 'questionnaire'
    And Grade Questionnaire Tableau ['Activity Name'] Column Value = Provided Questionnaire Name
    And Grade Questionnaire Tableau ['Data Source'] Column Value = 'Moodle'
    And Grade Questionnaire Tableau ['Score'] Column Value = Graded Questionnaire Total Score
    And Grade Questionnaire Tableau ['Max Score'] Column Value = Provided Questionnaire Max Grade
    And Grade Questionnaire Tableau ['Score(Percent)'] Column Value = Provided Questionnaire Percentage
