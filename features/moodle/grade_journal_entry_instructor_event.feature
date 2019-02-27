@moodle
Feature: Moodle.User Story 9146 - Instructor Event: Journal Entry Graded

  @IntegrationTest
  Scenario: TC Grade a Journal Entry under a course
    Given Graded a Journal Entry under a course
    When The Journal Entry got successfully graded
    Then An Event for grade journal entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Journal Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Journal Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Journal Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Journal Contribution Value
    And ['event'].['generated'].['extensions'].['courseTotalGrade'] = courseTotalGrade
    And ['event'].['generated'].['extensions'].['courseTotalPercentage'] = courseTotalPercentage
    And ['event'].['generated'].['extensions'].['courseTotalRange'] = courseTotalRange
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Journal Entry Score

  @EndToEndTest
  Scenario: TC Grade a Journal Entry under a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Graded a Journal Entry under a course
    When The Journal Entry got successfully graded
    Then An Event for grade journal entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Journal Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Journal Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Journal Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Journal Contribution Value
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'journal'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Journal Entry Score
    Then An Event for Grade Journal Entry should get generated and sent to CSV.
    And Grade Journal Entry CSV ['Action'] Column Value = 'Graded'
    And Grade Journal Entry CSV ['Page'] Column Value = 'journal'
    And Grade Journal Entry CSV ['Activity Type'] Column Value = 'journal'
    And Grade Journal Entry CSV ['Activity Name'] Column Value = Provided Journal Name
    And Grade Journal Entry CSV ['Data Source'] Column Value = 'Moodle'
    And Grade Journal Entry CSV ['Score'] Column Value = Graded Journal Entry Score
    And Grade Journal Entry CSV ['Max Score'] Column Value = Provided Journal Max Grade
    And Grade Journal Entry CSV ['Score(Percent)'] Column Value = Provided Journal Percentage
    Then An Event for Grade Journal Entry should get generated and sent to Tableau.
    And Grade Journal Entry Tableau ['Action'] Column Value = 'Graded'
    And Grade Journal Entry Tableau ['Page'] Column Value = 'journal'
    And Grade Journal Entry Tableau ['Activity Type'] Column Value = 'journal'
    And Grade Journal Entry Tableau ['Activity Name'] Column Value = Provided Journal Name
    And Grade Journal Entry Tableau ['Data Source'] Column Value = 'Moodle'
    And Grade Journal Entry Tableau ['Score'] Column Value = Graded Journal Entry Score
    And Grade Journal Entry Tableau ['Max Score'] Column Value = Provided Journal Max Grade
    And Grade Journal Entry Tableau ['Score(Percent)'] Column Value = Provided Journal Percentage
