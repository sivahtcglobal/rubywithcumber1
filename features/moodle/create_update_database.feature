@moodle
Feature: Moodle.User Story 9662 - Create and Update Database Course Module.

  @IntegrationTest @EndToEndTest
  Scenario: TC  Create a New Database Course Module
    Given Created a New Database Page for a Course
    When The New Database Page Got successfully created
    Then An Entity for New Database Page should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Provided Database Name
    And The ['entity'].['extensions'].['moduleType'] = 'data'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['grouping'] = false

  @IntegrationTest @EndToEndTest
  Scenario: TC  Update the Created Database for a Given Course
    Given Updated the New Database for the Given Course
    When The Database Got successfully Updated for the Given Course
    Then A Course Entity for the Updated Database should get generated and sent to our Raw Entity Index.
    And Updated Name ['entity'].['name'] = Provided Database Name
    And The ['entity'].['extensions'].['moduleType'] = 'data'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
