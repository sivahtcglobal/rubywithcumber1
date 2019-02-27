@moodle
Feature: Moodle.User Story 9590 and 9552 - Instructor Event: Submit Workshop Grading and Instructor Event: Workshop Phase Switched

  @IntegrationTest
  Scenario: TC Submit Workshop Grading and Workshop Phase Switched
    Given Submit Workshop grading Page for a Course
    When Workshop grading got submitted successfully
    Then An Event for Workshop grading submitted Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    Then An Event for Workshop Phase Switched should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['object'].['extensions'].['phase'] = 'closed'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'workshop_phase_changed'

  @EndToEndTest
  Scenario: TC Submit Workshop Grading and Workshop Phase Switched
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submit Workshop grading Page for a Course
    When Workshop grading got submitted successfully
    Then An Event for Workshop grading submitted Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    Then An Event for Workshop Phase Switched should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['object'].['extensions'].['phase'] = 'closed'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'workshop_phase_changed'
    Then An Event for Submit Workshop Grading should get generated and sent to CSV.
    And Submit Workshop Grading CSV ['Action'] Column Value = 'Graded'
    And Submit Workshop Grading CSV ['Page'] Column Value = 'workshop'
    And Submit Workshop Grading CSV ['Activity Type'] Column Value = 'workshop'
    And Submit Workshop Grading CSV ['Activity Name'] Column Value = Provided Workshop Name
    And Submit Workshop Grading CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Submit Workshop Grading should get generated and sent to Tableau.
    And Submit Workshop Grading Tableau ['Action'] Column Value = 'Graded'
    And Submit Workshop Grading Tableau ['Page'] Column Value = 'workshop'
    And Submit Workshop Grading Tableau ['Activity Type'] Column Value = 'workshop'
    And Submit Workshop Grading Tableau ['Activity Name'] Column Value = Provided Workshop Name
    And Submit Workshop Grading Tableau ['Data Source'] Column Value = 'Moodle'
