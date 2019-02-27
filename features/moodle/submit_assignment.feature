@nightly @moodle
Feature: Moodle.US 3972 Student Event - Submit an Assignment.

  @IntegrationTest
  Scenario: TC Submit an Assignment as a Student
    Given Submit an Assignment as a Student
    When Assignment got submitted successfully by the Student
    Then An AssignableEvent should get generated and sent to our Raw Event Index
    And Assignment submitted Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And Assignment submitted Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Assignment submitted Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And Assignment submitted Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign'
    And Assignment submitted Event ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'assign_submission'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Submit an Assignment as a Student
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submit an Assignment as a Student
    When Assignment got submitted successfully by the Student
    Then An AssignableEvent should get generated and sent to our Raw Event Index
    And Assignment submitted Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And Assignment submitted Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Assignment submitted Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And Assignment submitted Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign'
    And Assignment submitted Event ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Assignment submitted Event ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'assign_submission'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Submit Assignment should get generated and sent to CSV.
    And Submit Assignment CSV ['Action'] Column Value = 'Submitted'
    And Submit Assignment CSV ['Page'] Column Value = 'assign_submission'
    And Submit Assignment CSV ['Activity Type'] Column Value = 'assign'
    And Submit Assignment CSV ['Activity Name'] Column Value = Provided Assignment Name
    And Submit Assignment CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Submit Assignment should get generated and sent to Tableau.
    And Submit Assignment Tableau ['Action'] Column Value = 'Submitted'
    And Submit Assignment Tableau ['Page'] Column Value = 'assign_submission'
    And Submit Assignment Tableau ['Activity Type'] Column Value = 'assign'
    And Submit Assignment Tableau ['Activity Name'] Column Value = Provided Assignment Name
    And Submit Assignment Tableau ['Data Source'] Column Value = 'Moodle'
