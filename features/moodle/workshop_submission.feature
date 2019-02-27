@moodle
Feature: Moodle.User Story 9555 and 9556 - Student Event: Create/Update Workshop Submission and Student Event: Workshop Submission Uploaded

  @IntegrationTest
  Scenario: TC Create a New Workshop Submission Course Module
    Given Created a New Workshop Submission Page for a Course
    When The New Workshop Submission Page Got successfully submitted
    Then An Event for New Workshop Submission Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['name'] = Provided Workshop Submission Name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Upload Workshop Submission Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop_submission_file'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest
  Scenario: TC  Update the Created Workshop Submission for a Given Course
    Given Updated the New Workshop Submission for the Given Course
    When The Workshop Submission Got successfully Updated for the Given Course
    Then A Course Event for the Updated Workshop Submission should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And Updated Name ['event'].['generated'].['name'] = Provided Workshop Submission Name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Create a New Workshop Submission Course Module
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Created a New Workshop Submission Page for a Course
    When The New Workshop Submission Page Got successfully submitted
    Then An Event for New Workshop Submission Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['name'] = Provided Workshop Submission Name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for New Workshop Submission Page should get generated and sent to CSV.
    And New Workshop Submission Page CSV ['Action'] Column Value = 'Submitted'
    And New Workshop Submission Page CSV ['Page'] Column Value = 'workshop_submission'
    And New Workshop Submission Page CSV ['Activity Type'] Column Value = 'workshop'
    And New Workshop Submission Page CSV ['Activity Name'] Column Value = Provided Workshop Name
    And New Workshop Submission Page CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for New Workshop Submission Page should get generated and sent to Tableau.
    And New Workshop Submission Page Tableau ['Action'] Column Value = 'Submitted'
    And New Workshop Submission Page Tableau ['Page'] Column Value = 'workshop_submission'
    And New Workshop Submission Page Tableau ['Activity Type'] Column Value = 'workshop'
    And New Workshop Submission Page Tableau ['Activity Name'] Column Value = Provided Workshop Name
    And New Workshop Submission Page Tableau ['Data Source'] Column Value = 'Moodle'
    Then An Event for Upload Workshop Submission Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop_submission_file'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Upload Workshop Submission Page should get generated and sent to CSV.
    And Upload Workshop Submission Page CSV ['Action'] Column Value = 'Completed'
    And Upload Workshop Submission Page CSV ['Page'] Column Value = 'workshop_submission_file'
    And Upload Workshop Submission Page CSV ['Activity Type'] Column Value = 'workshop'
    And Upload Workshop Submission Page CSV ['Activity Name'] Column Value = Provided Workshop Name
    And Upload Workshop Submission Page CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Upload Workshop Submission Page should get generated and sent to Tableau.
    And Upload Workshop Submission Page Tableau ['Action'] Column Value = 'Completed'
    And Upload Workshop Submission Page Tableau ['Page'] Column Value = 'workshop_submission_file'
    And Upload Workshop Submission Page Tableau ['Activity Type'] Column Value = 'workshop'
    And Upload Workshop Submission Page Tableau ['Activity Name'] Column Value = Provided Workshop Name
    And Upload Workshop Submission Page Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC  Update the Created Workshop Submission for a Given Course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Updated the New Workshop Submission for the Given Course
    When The Workshop Submission Got successfully Updated for the Given Course
    Then A Course Event for the Updated Workshop Submission should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And Updated Name ['event'].['generated'].['name'] = Provided Workshop Submission Name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'workshop_submission'
    And The ['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And The ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'workshop'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Updated Workshop Submission should get generated and sent to CSV.
    And Updated Workshop Submission CSV ['Action'] Column Value = 'Submitted'
    And Updated Workshop Submission CSV ['Page'] Column Value = 'workshop_submission'
    And Updated Workshop Submission CSV ['Activity Type'] Column Value = 'workshop'
    And Updated Workshop Submission CSV ['Activity Name'] Column Value = Provided Workshop Name
    And Updated Workshop Submission CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Updated Workshop Submission should get generated and sent to Tableau.
    And Updated Workshop Submission Tableau ['Action'] Column Value = 'Submitted'
    And Updated Workshop Submission Tableau ['Page'] Column Value = 'workshop_submission'
    And Updated Workshop Submission Tableau ['Activity Type'] Column Value = 'workshop'
    And Updated Workshop Submission Tableau ['Activity Name'] Column Value = Provided Workshop Name
    And Updated Workshop Submission Tableau ['Data Source'] Column Value = 'Moodle'
