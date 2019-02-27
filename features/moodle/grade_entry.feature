@moodle
Feature: Moodle.User Story 9664 - Submit Grade Entry for Database Course Module.

  @IntegrationTest @EndToEndTest
  Scenario: TC  Submit Grade Entry for Database Course Module
    Given Submit Grade Entry for Database Page for a Course
    When The New Grade Entry for Database Page Got successfully submitted
    Then An Event for New Grade Entry for Database Page should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/OutcomeEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Graded'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['object'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['assignable'].['extensions'].['moduleType'] = 'data'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Result'
    And ['event'].['generated'].['extensions'].['maxGrade'] = Provided Database Entry Max Grade
    And ['event'].['generated'].['extensions'].['weight'] = Calculated Database Entry Weight Value
    And ['event'].['generated'].['extensions'].['percentage'] = Provided Database Entry Percentage
    And ['event'].['generated'].['extensions'].['contributionToCourseTotal'] = Calculated Database Entry Contribution Value
    And ['event'].['generated'].['extensions'].['courseTotalGrade'] = courseTotalGrade
    And ['event'].['generated'].['extensions'].['courseTotalPercentage'] = courseTotalPercentage
    And ['event'].['generated'].['extensions'].['courseTotalRange'] = courseTotalRange
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'data'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    And ['event'].['generated'].['totalScore'] = Graded Database Entry Score
