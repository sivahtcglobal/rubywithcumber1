@moodle
Feature: Moodle.Student Event - Answer a Choice.US:- 8120

  @IntegrationTest
  Scenario: TC 8559 Answer a Choice as a Student
    Given Answer a Choice as a Student
    When Choice got answered successfully by the Student
    Then Answer a Choice event should get generated and sent to our Raw Event Index
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'choice'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'choice_answer'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'choice'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 8559 Answer a Choice as a Student
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Answer a Choice as a Student
    When Choice got answered successfully by the Student
    Then Answer a Choice event should get generated and sent to our Raw Event Index
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'choice'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'choice_answer'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'choice'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Answer a Choice should get generated and sent to CSV.
    And Answer a Choice CSV ['Action'] Column Value = 'Submitted'
    And Answer a Choice CSV ['Page'] Column Value = 'choice_answer'
    And Answer a Choice CSV ['Activity Type'] Column Value = 'choice'
    And Answer a Choice CSV ['Activity Name'] Column Value = Provided Choice Name
    And Answer a Choice CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Answer a Choice should get generated and sent to Tableau.
    And Answer a Choice Tableau ['Action'] Column Value = 'Submitted'
    And Answer a Choice Tableau ['Page'] Column Value = 'choice_answer'
    And Answer a Choice Tableau ['Activity Type'] Column Value = 'choice'
    And Answer a Choice Tableau ['Activity Name'] Column Value = Provided Choice Name
    And Answer a Choice Tableau ['Data Source'] Column Value = 'Moodle'
