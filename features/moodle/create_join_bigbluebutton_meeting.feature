@moodle
Feature: Moodle.User Story 10022, 10023, 10024 and 10025 - BigBlueButton Meeting Created, BigBlueButton Meeting Joined, BigBlueButton Meeting Left and BigBlueButton Meeting Ended

  @IntegrationTest @EndToEndTest
  Scenario: TC Attend a New BigBlueButton Meeting by Instructor
    Given Attended a New BigBlueButton Meeting by Instructor
    When The New BigBlueButton Meeting got successfully attended
    Then An Event for New BigBlueButton Meeting Create should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_created'
    Then An Event for BigBlueButton Meeting Join should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_joined'
    Then An Event for BigBlueButton Meeting Left should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_left'
    Then An Event for BigBlueButton Meeting End should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_ended'

  @IntegrationTest
  Scenario: TC Attend a New BigBlueButton Meeting by Student
    Given Attended a New BigBlueButton Meeting by Student
    When The New BigBlueButton Meeting got successfully attended
    Then An Event for New BigBlueButton Meeting Create should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_created'
    Then An Event for BigBlueButton Meeting Join should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_joined'
    Then An Event for BigBlueButton Meeting Left should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_left'
    Then An Event for BigBlueButton Meeting End should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_ended'

  @EndToEndTest
  Scenario: TC Attend a New BigBlueButton Meeting by Student
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Attended a New BigBlueButton Meeting by Student
    When The New BigBlueButton Meeting got successfully attended
    Then An Event for New BigBlueButton Meeting Create should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_created'
    Then An Event for BigBlueButton Meeting Join should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_joined'
    Then An Event for BigBlueButton Meeting Left should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_left'
    Then An Event for BigBlueButton Meeting End should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'bigbluebuttonbn_meeting_ended'
    Then Events for BigBlueButton Meeting should get generated and sent to CSV.
    And BigBlueButton Meeting CSV ['Action'] Column Value = 'Modified'
    And BigBlueButton Meeting CSV ['Activity Type'] Column Value = 'bigbluebuttonbn'
    And BigBlueButton Meeting CSV ['Activity Name'] Column Value = Provided BigBlueButton Meeting Name
    And BigBlueButton Meeting CSV ['Data Source'] Column Value = 'Moodle'
    Then Events for BigBlueButton Meeting should get generated and sent to Tableau.
    And BigBlueButton Meeting Tableau ['Action'] Column Value = 'Modified'
    And BigBlueButton Meeting Tableau ['Activity Type'] Column Value = 'bigbluebuttonbn'
    And BigBlueButton Meeting Tableau ['Activity Name'] Column Value = Provided BigBlueButton Meeting Name
    And BigBlueButton Meeting Tableau ['Data Source'] Column Value = 'Moodle'
