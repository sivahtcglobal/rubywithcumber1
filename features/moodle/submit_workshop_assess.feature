@moodle
Feature: Moodle.User Story 9561 - Student Event - Workshop Submission Assessed/Re-assessed

  @IntegrationTest
  Scenario: TC Submit Workshop Assess for a Course
    Given Submit Workshop Assess Page for a Course
    When Workshop Assess got submitted successfully
    Then An Event for Workshop Assess submitted Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'workshop_submission_assessed'

  @IntegrationTest
  Scenario: TC Submit Workshop Re-assess for a Course
    Given Submit Workshop Re-assess Page for a Course
    When Workshop Re-assess got submitted successfully
    Then An Event for Workshop Re-assess submitted Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'workshop_submission_assessed'

  @EndToEndTest
  Scenario: TC Submit Workshop Assess for a Course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submit Workshop Assess Page for a Course
    When Workshop Assess got submitted successfully
    Then An Event for Workshop Assess submitted Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'workshop_submission_assessed'
    Then An Event for Workshop Assess submitted Page should get generated and sent to CSV.
    And Workshop Assess submitted Page CSV ['Action'] Column Value = 'Modified'
    And Workshop Assess submitted Page CSV ['Page'] Column Value = 'workshop_submission'
    And Workshop Assess submitted Page CSV ['Activity Type'] Column Value = 'workshop'
    And Workshop Assess submitted Page CSV ['Activity Name'] Column Value = Provided Workshop Name
    And Workshop Assess submitted Page CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Workshop Assess submitted Page should get generated and sent to Tableau.
    And Workshop Assess submitted Page Tableau ['Action'] Column Value = 'Modified'
    And Workshop Assess submitted Page Tableau ['Page'] Column Value = 'workshop_submission'
    And Workshop Assess submitted Page Tableau ['Activity Type'] Column Value = 'workshop'
    And Workshop Assess submitted Page Tableau ['Activity Name'] Column Value = Provided Workshop Name
    And Workshop Assess submitted Page Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC Submit Workshop Re-assess for a Course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submit Workshop Re-assess Page for a Course
    When Workshop Re-assess got submitted successfully
    Then An Event for Workshop Re-assess submitted Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Modified'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['extensions'].['action'] = 'workshop_submission_assessed'
    Then An Event for Workshop Re-assess submitted Page should get generated and sent to CSV.
    And Workshop Re-assess submitted Page CSV ['Action'] Column Value = 'Modified'
    And Workshop Re-assess submitted Page CSV ['Page'] Column Value = 'workshop_submission'
    And Workshop Re-assess submitted Page CSV ['Activity Type'] Column Value = 'workshop'
    And Workshop Re-assess submitted Page CSV ['Activity Name'] Column Value = Provided Workshop Name
    And Workshop Re-assess submitted Page CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Workshop Re-assess submitted Page should get generated and sent to Tableau.
    And Workshop Re-assess submitted Page Tableau ['Action'] Column Value = 'Modified'
    And Workshop Re-assess submitted Page Tableau ['Page'] Column Value = 'workshop_submission'
    And Workshop Re-assess submitted Page Tableau ['Activity Type'] Column Value = 'workshop'
    And Workshop Re-assess submitted Page Tableau ['Activity Name'] Column Value = Provided Workshop Name
    And Workshop Re-assess submitted Page Tableau ['Data Source'] Column Value = 'Moodle'
