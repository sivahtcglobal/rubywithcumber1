@moodle
Feature: Moodle.User Story 6343 - Student Event: Post To Forum

  @IntegrationTest
  Scenario: TC 7193 Submit a Post under a Topic(Discussion) for a course
    Given Submitted a Post under a Forum Discussion for a course
    When The Forum Post got successfully submitted
    Then An Event for student Forum post should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['@id'] value includes the forum post id submitted by student
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['name'] includes the student forum post subject name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'forum_post'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['count'] = '1'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Navigate to Forum Discussion should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'forum_discussions'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC 7193 Submit a Post under a Topic(Discussion) for a course
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Submitted a Post under a Forum Discussion for a course
    When The Forum Post got successfully submitted
    Then An Event for student Forum post should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['@id'] value includes the forum post id submitted by student
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['name'] includes the student forum post subject name
    And ['event'].['generated'].['extensions'].['moduleType'] = 'forum_post'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'forum'
    And ['event'].['generated'].['count'] = '1'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Navigate to Forum Discussion should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/NavigationEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#NavigatedTo'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'forum_discussions'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for student forum post should get generated and sent to CSV.
    And Student Forum Post CSV ['Action'] Column Value = 'Submitted'
    And Student Forum Post CSV ['Page'] Column Value = 'forum_post'
    And Student Forum Post CSV ['Activity Type'] Column Value = 'forum'
    And Student Forum Post CSV ['Activity Name'] Column Value = Provided Forum Name
    And Student Forum Post CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for student forum post should get generated and sent to Tableau.
    And Student Forum Post Tableau ['Action'] Column Value = 'Submitted'
    And Student Forum Post Tableau ['Page'] Column Value = 'forum_post'
    And Student Forum Post Tableau ['Activity Type'] Column Value = 'forum'
    And Student Forum Post Tableau ['Activity Name'] Column Value = Provided Forum Name
    And Student Forum Post Tableau ['Data Source'] Column Value = 'Moodle'
