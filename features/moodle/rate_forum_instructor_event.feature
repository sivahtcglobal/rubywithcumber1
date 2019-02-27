@moodle
Feature: Moodle.User Story 6344 - Instructor Event: Rate a Forum Post

  @IntegrationTest
  Scenario: TC  Rate a Forum Post under a Discussion for a course
    Given Rated a Forum Post under a Discussion for a course
    When The Forum Post got successfully rated
    Then An Event for rate forum post should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Value
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['totalScore'] = Selected Forum Post Rating
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC  Rate a Forum Post under a Discussion for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Rated a Forum Post under a Discussion for a course
    When The Forum Post got successfully rated
    Then An Event for rate forum post should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Value
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['totalScore'] = Selected Forum Post Rating
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Rate a Forum Post should get generated and sent to CSV.
    And Rate a Forum Post CSV ['Action'] Column Value = 'Graded'
    And Rate a Forum Post CSV ['Page'] Column Value = 'forum'
    And Rate a Forum Post CSV ['Activity Type'] Column Value = 'forum'
    And Rate a Forum Post CSV ['Activity Name'] Column Value = Provided Forum Name
    And Rate a Forum Post CSV ['Data Source'] Column Value = 'Moodle'
    And Rate a Forum Post CSV ['Score'] Column Value = Selected Forum Post Rating
    And Rate a Forum Post CSV ['Max Score'] Column Value = Provided Max Grade
    And Rate a Forum Post CSV ['Score(Percent)'] Column Value = Provided Percentage
    Then An Event for Rate a Forum Post should get generated and sent to Tableau.
    And Rate a Forum Post Tableau ['Action'] Column Value = 'Graded'
    And Rate a Forum Post Tableau ['Page'] Column Value = 'forum'
    And Rate a Forum Post Tableau ['Activity Type'] Column Value = 'forum'
    And Rate a Forum Post Tableau ['Activity Name'] Column Value = Provided Forum Name
    And Rate a Forum Post Tableau ['Data Source'] Column Value = 'Moodle'
    And Rate a Forum Post Tableau ['Score'] Column Value = Selected Forum Post Rating
    And Rate a Forum Post Tableau ['Max Score'] Column Value = Provided Max Grade
    And Rate a Forum Post Tableau ['Score(Percent)'] Column Value = Provided Percentage
