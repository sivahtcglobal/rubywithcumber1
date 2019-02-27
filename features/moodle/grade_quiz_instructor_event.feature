@moodle
Feature: Moodle.User Story 3392 - Instructor Event: Quiz Graded

  @IntegrationTest
  Scenario: TC 5687 Grade a Quiz under a course
    Given Graded a Quiz under a course
    When The Quiz got successfully graded
    Then An Event for grade quiz should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'quiz_attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Quiz Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Quiz Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Quiz Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Quiz Contribution Value
    And ['event'].['generated'].['extensions'].['courseTotalGrade'] = courseTotalGrade
    And ['event'].['generated'].['extensions'].['courseTotalPercentage'] = courseTotalPercentage
    And ['event'].['generated'].['extensions'].['courseTotalRange'] = courseTotalRange
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Quiz Score

  @EndToEndTest
  Scenario: TC 5687 Grade a Quiz under a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Quiz Submission CSV Record Counts before Sending Event
    Given Quiz Submission Tableau Record Counts before Sending Event
    Given Graded a Quiz under a course
    When The Quiz got successfully graded
    Then An Event for grade quiz should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'quiz_attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Quiz Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Quiz Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Quiz Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Quiz Contribution Value
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'quiz'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Quiz Score
    Then An Event for Grade Quiz should get generated and sent to CSV.
    And Grade Quiz CSV ['Action'] Column Value = 'Graded'
    And Grade Quiz CSV ['Page'] Column Value = 'quiz'
    And Grade Quiz CSV ['Activity Type'] Column Value = 'quiz'
    And Grade Quiz CSV ['Activity Name'] Column Value = Provided Quiz Name
    And Grade Quiz CSV ['Data Source'] Column Value = 'Moodle'
    And Grade Quiz CSV ['Score'] Column Value = Graded Quiz Score
    And Grade Quiz CSV ['Max Score'] Column Value = Provided Quiz Max Grade
    And Grade Quiz CSV ['Score(Percent)'] Column Value = Provided Quiz Percentage
    Then An Event for Grade Quiz should get generated and sent to Tableau.
    And Grade Quiz Tableau ['Action'] Column Value = 'Graded'
    And Grade Quiz Tableau ['Page'] Column Value = 'quiz'
    And Grade Quiz Tableau ['Activity Type'] Column Value = 'quiz'
    And Grade Quiz Tableau ['Activity Name'] Column Value = Provided Quiz Name
    And Grade Quiz Tableau ['Data Source'] Column Value = 'Moodle'
    And Grade Quiz Tableau ['Score'] Column Value = Graded Quiz Score
    And Grade Quiz Tableau ['Max Score'] Column Value = Provided Quiz Max Grade
    And Grade Quiz Tableau ['Score(Percent)'] Column Value = Provided Quiz Percentage
    Then An Event for Quiz Submission should get generated and sent to CSV.
    And Quiz Submission CSV ['Student Display Name'] Column Value = Student Display Name
    And Quiz Submission CSV ['Student Name'] Column Value = Student Name
    And Quiz Submission CSV ['Role'] Column Value = Provided Role
    And Quiz Submission CSV ['Course ID'] Column Value = Course ID
    And Quiz Submission CSV ['Course Name'] Column Value = Course Name
    And Quiz Submission CSV ['Action'] Column Value = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And Quiz Submission CSV ['Page'] Column Value = 'quiz'
    And Quiz Submission CSV ['Activity Type'] Column Value = 'quiz'
    And Quiz Submission CSV ['Activity Name'] Column Value = Quiz Name
    And Quiz Submission CSV ['Activity ID'] Column Value = Quiz ID
    And Quiz Submission CSV ['Data Source'] Column Value = 'Moodle'
    And Quiz Submission CSV ['Score'] Column Value = Provided Score
    And Quiz Submission CSV ['Max Score'] Column Value = Provided Max Score
    And Quiz Submission CSV ['Score (Percent)'] Column Value = Score Percentage
    And Quiz Submission CSV ['Weight'] Column Value = Weight
    And Quiz Submission CSV ['Attempt ID'] Column Value = Attempt ID
    And Quiz Submission CSV ['Open Quiz Date'] Column Value = Provided Open Quiz Date
    And Quiz Submission CSV ['Close Quiz Date'] Column Value = Provided Close Quiz Date
    And Quiz Submission CSV ['Completion Tracking'] Column Value = true
    And Quiz Submission CSV ['Contribution To Course Total'] Column Value = Contribution To Course Total
    And Quiz Submission CSV ['Count'] Column Value = '1'
    And Quiz Submission CSV ['Time Limit'] Column Value = Provided Time Limit
    And Quiz Submission CSV ['Grace Period'] Column Value = Provided Grace Period
    And Quiz Submission CSV ['Overdue Handling'] Column Value = Provided Overdue Handling
    And Quiz Submission CSV ['Restrictions'] Column Value = false
    And Quiz Submission CSV ['Tags'] Column Value = Provided Tags
    And Quiz Submission CSV ['Require View'] Column Value = false
    And Quiz Submission CSV ['Require Grade'] Column Value = false
    And Quiz Submission CSV ['Grade Method'] Column Value = 'first_attempt'
    And Quiz Submission CSV ['Grade To Pass'] Column Value = Provided Grade To Pass
    Then An Event for Quiz Submission should get generated and sent to Tableau.
    And Quiz Submission Tableau ['Student Display Name'] Column Value = Student Display Name
    And Quiz Submission Tableau ['Student Name'] Column Value = Student Name
    And Quiz Submission Tableau ['Role'] Column Value = Provided Role
    And Quiz Submission Tableau ['Course ID'] Column Value = Course ID
    And Quiz Submission Tableau ['Course Name'] Column Value = Course Name
    And Quiz Submission Tableau ['Action'] Column Value = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And Quiz Submission Tableau ['Page'] Column Value = 'quiz'
    And Quiz Submission Tableau ['Activity Type'] Column Value = 'quiz'
    And Quiz Submission Tableau ['Activity Name'] Column Value = Quiz Name
    And Quiz Submission Tableau ['Activity ID'] Column Value = Quiz ID
    And Quiz Submission Tableau ['Data Source'] Column Value = 'Moodle'
    And Quiz Submission Tableau ['Score'] Column Value = Provided Score
    And Quiz Submission Tableau ['Max Score'] Column Value = Provided Max Score
    And Quiz Submission Tableau ['Score (Percent)'] Column Value = Score Percentage
    And Quiz Submission Tableau ['Weight'] Column Value = Weight
    And Quiz Submission Tableau ['Attempt ID'] Column Value = Attempt ID
    And Quiz Submission Tableau ['Open Quiz Date'] Column Value = Provided Open Quiz Date
    And Quiz Submission Tableau ['Close Quiz Date'] Column Value = Provided Close Quiz Date
    And Quiz Submission Tableau ['Completion Tracking'] Column Value = true
    And Quiz Submission Tableau ['Contribution To Course Total'] Column Value = Contribution To Course Total
    And Quiz Submission Tableau ['Count'] Column Value = '1'
    And Quiz Submission Tableau ['Time Limit'] Column Value = Provided Time Limit
    And Quiz Submission Tableau ['Grace Period'] Column Value = Provided Grace Period
    And Quiz Submission Tableau ['Overdue Handling'] Column Value = Provided Overdue Handling
    And Quiz Submission Tableau ['Restrictions'] Column Value = false
    And Quiz Submission Tableau ['Tags'] Column Value = Provided Tags
    And Quiz Submission Tableau ['Require View'] Column Value = false
    And Quiz Submission Tableau ['Require Grade'] Column Value = false
    And Quiz Submission Tableau ['Grade Method'] Column Value = 'first_attempt'
    And Quiz Submission Tableau ['Grade To Pass'] Column Value = Provided Grade To Pass
