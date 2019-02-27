@nightly @moodle
Feature: Moodle.Student Event - Uploaded File to an Assignment.US:- 5330

  @IntegrationTest
  Scenario: TC Uploaded File to an Assignment as a Student
    Given Uploaded File to an Assignment as a Student
    When File got uploaded successfully to the Assignment by the Student
    Then An AssessmentItemEvent should get generated and sent to our Raw Event Index
    And AssessmentItemEvent submitted Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And AssessmentItemEvent submitted Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And AssessmentItemEvent submitted Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And AssessmentItemEvent submitted Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign_file'
    And AssessmentItemEvent submitted Event ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Uploaded File to an Assignment as a Student
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Uploaded File to an Assignment as a Student
    When File got uploaded successfully to the Assignment by the Student
    Then An AssessmentItemEvent should get generated and sent to our Raw Event Index
    And AssessmentItemEvent submitted Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And AssessmentItemEvent submitted Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And AssessmentItemEvent submitted Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And AssessmentItemEvent submitted Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['extensions'].['moduleType'] = 'assign_file'
    And AssessmentItemEvent submitted Event ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And AssessmentItemEvent submitted Event ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Upload File should get generated and sent to CSV.
    And Upload File CSV ['Action'] Column Value = 'Completed'
    And Upload File CSV ['Page'] Column Value = 'assign_file'
    And Upload File CSV ['Activity Type'] Column Value = 'assign'
    And Upload File CSV ['Activity Name'] Column Value = Provided Assignment Name
    And Upload File CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Upload File should get generated and sent to Tableau.
    And Upload File Tableau ['Action'] Column Value = 'Completed'
    And Upload File Tableau ['Page'] Column Value = 'assign_file'
    And Upload File Tableau ['Activity Type'] Column Value = 'assign'
    And Upload File Tableau ['Activity Name'] Column Value = Provided Assignment Name
    And Upload File Tableau ['Data Source'] Column Value = 'Moodle'
