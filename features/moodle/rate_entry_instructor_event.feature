@moodle
Feature: Moodle.User Story 5154 - Instructor Event: Rate Entry

  @IntegrationTest
  Scenario: TC 5431 Rate a Student Entry under a Glossary for a course
    Given Rated a Student Entry under a Glossary for a course
    When The Student Entry got successfully rated
    Then An Event for rate entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Glossary Entry Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Glossary Entry Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Glossary Entry Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Glossary Entry Contribution Value
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Selected Rating

  @EndToEndTest
  Scenario: TC 5431 Rate a Student Entry under a Glossary for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Rated a Student Entry under a Glossary for a course
    When The Student Entry got successfully rated
    Then An Event for rate entry should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Glossary Entry Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Glossary Entry Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Glossary Entry Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Glossary Entry Contribution Value
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'glossary'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Selected Rating
    Then An Event for Rate Glossary Entry should get generated and sent to CSV.
    And Rate Glossary Entry CSV ['Action'] Column Value = 'Graded'
    And Rate Glossary Entry CSV ['Page'] Column Value = 'glossary'
    And Rate Glossary Entry CSV ['Activity Type'] Column Value = 'glossary'
    And Rate Glossary Entry CSV ['Activity Name'] Column Value = Provided Glossary Name
    And Rate Glossary Entry CSV ['Data Source'] Column Value = 'Moodle'
    And Rate Glossary Entry CSV ['Score'] Column Value = Selected Rating
    And Rate Glossary Entry CSV ['Max Score'] Column Value = Provided Glossary Entry Max Grade
    And Rate Glossary Entry CSV ['Score(Percent)'] Column Value = Provided Glossary Entry Percentage
    Then An Event for Rate Glossary Entry should get generated and sent to Tableau.
    And Rate Glossary Entry Tableau ['Action'] Column Value = 'Graded'
    And Rate Glossary Entry Tableau ['Page'] Column Value = 'glossary'
    And Rate Glossary Entry Tableau ['Activity Type'] Column Value = 'glossary'
    And Rate Glossary Entry Tableau ['Activity Name'] Column Value = Provided Glossary Name
    And Rate Glossary Entry Tableau ['Data Source'] Column Value = 'Moodle'
    And Rate Glossary Entry Tableau ['Score'] Column Value = Selected Rating
    And Rate Glossary Entry Tableau ['Max Score'] Column Value = Provided Glossary Entry Max Grade
    And Rate Glossary Entry Tableau ['Score(Percent)'] Column Value = Provided Glossary Entry Percentage
