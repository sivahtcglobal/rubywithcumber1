@nightly @moodle
Feature: Moodle.User Story 3965- Instructor Event - Add Grade and Feedback Comment to Assignment for a Given Course

  @IntegrationTest
  Scenario: TC Add Grade and Feedback Comment to Assignment for a Given Course
    Given Add Grade and Feedback Comment to Assignment for a Given Course
    When Grade and Feedback Comment Got successfully Added to the Assignment for a Given Course
    Then A Assignment Grade and Feedback Comment Event should get generated and sent to our Raw Event Index
    And Assignment Grade and Feedback Comment Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And Assignment Grade and Feedback Comment Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Assignment Grade and Feedback Comment Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And Assignment Grade and Feedback Comment Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign_submission'
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Assignment Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Assignment Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Assignment Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Assignment Contribution Value
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['normalScore'] = 65
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['totalScore'] = 65
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['scoredBy'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['scoredBy'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Add Grade and Feedback Comment to Assignment for a Given Course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Add Grade and Feedback Comment to Assignment for a Given Course
    When Grade and Feedback Comment Got successfully Added to the Assignment for a Given Course
    Then A Assignment Grade and Feedback Comment Event should get generated and sent to our Raw Event Index
    And Assignment Grade and Feedback Comment Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And Assignment Grade and Feedback Comment Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Assignment Grade and Feedback Comment Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And Assignment Grade and Feedback Comment Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign_submission'
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Assignment Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Assignment Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Assignment Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Assignment Contribution Value
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['normalScore'] = 65
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['totalScore'] = 65
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['scoredBy'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment Grade and Feedback Comment Event ['event'].['generated'].['scoredBy'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Grade Assignment should get generated and sent to CSV.
    And Grade Assignment CSV ['Action'] Column Value = 'Graded'
    And Grade Assignment CSV ['Page'] Column Value = 'assign'
    And Grade Assignment CSV ['Activity Type'] Column Value = 'assign'
    And Grade Assignment CSV ['Activity Name'] Column Value = Provided Assignment Name
    And Grade Assignment CSV ['Data Source'] Column Value = 'Moodle'
    And Grade Assignment CSV ['Score'] Column Value = 65
    And Grade Assignment CSV ['Max Score'] Column Value = Provided Assignment Max Grade
    And Grade Assignment CSV ['Score(Percent)'] Column Value = Provided Assignment Percentage
    Then An Event for Grade Assignment should get generated and sent to Tableau.
    And Grade Assignment Tableau ['Action'] Column Value = 'Graded'
    And Grade Assignment Tableau ['Page'] Column Value = 'assign'
    And Grade Assignment Tableau ['Activity Type'] Column Value = 'assign'
    And Grade Assignment Tableau ['Activity Name'] Column Value = Provided Assignment Name
    And Grade Assignment Tableau ['Data Source'] Column Value = 'Moodle'
    And Grade Assignment Tableau ['Score'] Column Value = 65
    And Grade Assignment Tableau ['Max Score'] Column Value = Provided Assignment Max Grade
    And Grade Assignment Tableau ['Score(Percent)'] Column Value = Provided Assignment Percentage
