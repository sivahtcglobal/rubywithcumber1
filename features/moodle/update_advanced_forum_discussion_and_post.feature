@moodle
Feature: Moodle.User Story 8583 - Update Advanced Forum Discussion and Advanced Forum Post

  @IntegrationTest @EndToEndTest
  Scenario: TC  Update an Advanced Forum Discussion for a course
    Given Updated an Advanced Forum Discussion for a course
    When The Advanced Forum Discussion got successfully updated
    Then An Event for Advanced Forum discussion should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'hsuforum'
    And ['event'].['generated'].['@id'] value includes the advanced forum discussion id updated by instructor
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['name'] includes the updated advanced forum discussion name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'hsuforum_discussion'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'hsuforum'
    And ['event'].['generated'].['count'] = '1'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest
  Scenario: TC  Update an Advanced Forum Post under a Topic(Discussion) for a course
    Given Updated a Post under an Advanced Forum Discussion for a course
    When The Advanced Forum Post got successfully updated
    Then An Event for student Advanced Forum post should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'hsuforum'
    And ['event'].['generated'].['@id'] value includes the advanced forum post id updated by student
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['name'] includes the updated student advanced forum post subject name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'hsuforum_post'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'hsuforum'
    And ['event'].['generated'].['count'] = '1'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC  Update an Advanced Forum Post under a Topic(Discussion) for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Updated a Post under an Advanced Forum Discussion for a course
    When The Advanced Forum Post got successfully updated
    Then An Event for student Advanced Forum post should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'hsuforum'
    And ['event'].['generated'].['@id'] value includes the advanced forum post id updated by student
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['name'] includes the updated student advanced forum post subject name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'hsuforum_post'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'hsuforum'
    And ['event'].['generated'].['count'] = '1'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for update student advanced forum post should get generated and sent to CSV.
    And Student Advanced Forum Post CSV ['Action'] Column Value = 'Submitted'
    And Student Advanced Forum Post CSV ['Page'] Column Value = 'hsuforum_post'
    And Student Advanced Forum Post CSV ['Activity Type'] Column Value = 'hsuforum'
    And Student Advanced Forum Post CSV ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Student Advanced Forum Post CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for update student advanced forum post should get generated and sent to Tableau.
    And Student Advanced Forum Post Tableau ['Action'] Column Value = 'Submitted'
    And Student Advanced Forum Post Tableau ['Page'] Column Value = 'hsuforum_post'
    And Student Advanced Forum Post Tableau ['Activity Type'] Column Value = 'hsuforum'
    And Student Advanced Forum Post Tableau ['Activity Name'] Column Value = Provided Advanced Forum Name
    And Student Advanced Forum Post Tableau ['Data Source'] Column Value = 'Moodle'
