@nightly @moodle
Feature: Moodle.User Story 11802 - Student Event - Assignment submission with online text

  @IntegrationTest @EndToEndTest
  Scenario: Online Text Assignment submission
    Given Login as Valid Moodle Student user
    When Create online text submission is succesfully added
    Then A Submitted Event for the Given Course should get generated and sent to our Raw Event Index
    And Onlinetext submission['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And Onlinetext submission['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Onlinetext submission['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And Onlinetext submission['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And Onlinetext submission['event'].['object'].['extensions'].['moduleType'] = 'assign_text'
    And Onlinetext submission['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And Onlinetext submission['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Onlinetext submission['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And Onlinetext submission['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Onlinetext submission['event'].['edApp'].['name'] = 'IntellifyLearning'
    When Edit online text submission is succesfully added
    Then A Submitted Event for the Given Course should get generated and sent to our Raw Event Index
    And Onlinetext submission['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItemEvent'
    And Onlinetext submission['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Onlinetext submission['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Completed'
    And Onlinetext submission['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssessmentItem'
    And Onlinetext submission['event'].['object'].['extensions'].['moduleType'] = 'assign_text'
    And Onlinetext submission['event'].['generated'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And Onlinetext submission['event'].['generated'].['assignable'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Onlinetext submission['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Onlinetext submission['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'assign'
    And Onlinetext submission['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Onlinetext submission['event'].['edApp'].['name'] = 'IntellifyLearning'


