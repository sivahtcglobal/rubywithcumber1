@moodle
Feature: Moodle.User Story 3991 - Instructor Event: Rate Advanced Forum

  @IntegrationTest
  Scenario: TC 5428 Rate a Forum under a Topic(Discussion) for a course
    Given Rated a Forum under a Topic(Discussion) for a course
    When The Forum got successfully rated
    Then An Event for rate forum should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['maxGrade'] = Provided Advanced Forum Max Grade
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['weight'] = Calculated Advanced Forum Weight Value
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['percentage'] = Provided Advanced Forum Percentage
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Advanced Forum Contribution Value
    And ['event'].['generated'].['totalScore'] = Selected Rating
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 5428 Rate a Forum under a Topic(Discussion) for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Rated a Forum under a Topic(Discussion) for a course
    When The Forum got successfully rated
    Then An Event for rate forum should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['maxGrade'] = Provided Advanced Forum Max Grade
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['weight'] = Calculated Advanced Forum Weight Value
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['percentage'] = Provided Advanced Forum Percentage
    And Rate Advanced Forum ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Advanced Forum Contribution Value
    And ['event'].['generated'].['totalScore'] = Selected Rating
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Rate Advanced Forum should get generated and sent to CSV.
    And Rate Advanced Forum CSV ['Action'] Column Value = 'Graded'
    And Rate Advanced Forum CSV ['Page'] Column Value = 'hsuforum'
    And Rate Advanced Forum CSV ['Activity Type'] Column Value = 'hsuforum'
    And Rate Advanced Forum CSV ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Rate Advanced Forum CSV ['Data Source'] Column Value = 'Moodle'
    And Rate Advanced Forum CSV ['Score'] Column Value = Selected Rating
    And Rate Advanced Forum CSV ['Max Score'] Column Value = Provided Advanced Forum Max Grade
    And Rate Advanced Forum CSV ['Score(Percent)'] Column Value = Provided Advanced Forum Percentage
    Then An Event for Rate Advanced Forum should get generated and sent to Tableau.
    And Rate Advanced Forum Tableau ['Action'] Column Value = 'Graded'
    And Rate Advanced Forum Tableau ['Page'] Column Value = 'hsuforum'
    And Rate Advanced Forum Tableau ['Activity Type'] Column Value = 'hsuforum'
    And Rate Advanced Forum Tableau ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Rate Advanced Forum Tableau ['Data Source'] Column Value = 'Moodle'
    And Rate Advanced Forum Tableau ['Score'] Column Value = Selected Rating
    And Rate Advanced Forum Tableau ['Max Score'] Column Value = Provided Advanced Forum Max Grade
    And Rate Advanced Forum Tableau ['Score(Percent)'] Column Value = Provided Advanced Forum Percentage
