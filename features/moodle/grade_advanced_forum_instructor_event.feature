@moodle
Feature: Moodle.User Story 3990 - Instructor Event: Grade Advanced Forum

  @IntegrationTest
  Scenario: TC 5460 Grade a Forum under a Topic(Discussion) for a course
    Given Graded a Forum under a Topic(Discussion) for a course
    When The Forum got successfully graded
    Then An Event for grade forum should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Advanced Forum Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Advanced Forum Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Advanced Forum Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Advanced Forum Contribution Value
    And ['event'].['generated'].['extensions'].['courseTotalGrade'] = courseTotalGrade
    And ['event'].['generated'].['extensions'].['courseTotalPercentage'] = courseTotalPercentage
    And ['event'].['generated'].['extensions'].['courseTotalRange'] = courseTotalRange
    And ['event'].['generated'].['totalScore'] = Graded Score
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5460 Grade a Forum under a Topic(Discussion) for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Graded a Forum under a Topic(Discussion) for a course
    When The Forum got successfully graded
    Then An Event for grade forum should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Advanced Forum Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Advanced Forum Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Advanced Forum Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Advanced Forum Contribution Value
    And ['event'].['generated'].['totalScore'] = Graded Score
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Grade Advanced Forum should get generated and sent to CSV.
    And Grade Advanced Forum CSV ['Action'] Column Value = 'Graded'
    And Grade Advanced Forum CSV ['Page'] Column Value = 'hsuforum'
    And Grade Advanced Forum CSV ['Activity Type'] Column Value = 'hsuforum'
    And Grade Advanced Forum CSV ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Grade Advanced Forum CSV ['Data Source'] Column Value = 'Moodle'
    And Grade Advanced Forum CSV ['Score'] Column Value = Graded Score
    And Grade Advanced Forum CSV ['Max Score'] Column Value = Provided Advanced Forum Max Grade
    And Grade Advanced Forum CSV ['Score(Percent)'] Column Value = Provided Advanced Forum Percentage
    Then An Event for Grade Advanced Forum should get generated and sent to Tableau.
    And Grade Advanced Forum Tableau ['Action'] Column Value = 'Graded'
    And Grade Advanced Forum Tableau ['Page'] Column Value = 'hsuforum'
    And Grade Advanced Forum Tableau ['Activity Type'] Column Value = 'hsuforum'
    And Grade Advanced Forum Tableau ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Grade Advanced Forum Tableau ['Data Source'] Column Value = 'Moodle'
    And Grade Advanced Forum Tableau ['Score'] Column Value = Graded Score
    And Grade Advanced Forum Tableau ['Max Score'] Column Value = Provided Advanced Forum Max Grade
    And Grade Advanced Forum Tableau ['Score(Percent)'] Column Value = Provided Advanced Forum Percentage
