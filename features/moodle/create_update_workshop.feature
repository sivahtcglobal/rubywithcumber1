@moodle
Feature: Moodle.User Story 9551 - Create and Update Workshop Course Module.

  @IntegrationTest @EndToEndTest
  Scenario: TC  Create a New Workshop Course Module
    Given Created a New Workshop Page for a Course
    When The New Workshop Page Got successfully created
    Then An Entity for New Workshop Page should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Provided Workshop Name
    And The ['entity'].['extensions'].['moduleType'] = 'workshop'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['grouping'] = false

  @IntegrationTest @EndToEndTest
  Scenario: TC  Update the Created Workshop for a Given Course
    Given Updated the New Workshop for the Given Course
    When The Workshop Got successfully Updated for the Given Course
    Then A Course Entity for the Updated Workshop should get generated and sent to our Raw Entity Index.
    And Updated Name ['entity'].['name'] = Provided Workshop Name
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
