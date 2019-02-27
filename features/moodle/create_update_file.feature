@moodle
Feature: Moodle.User Story 5178 and 5198 - Create and Update A File

  @IntegrationTest @EndToEndTest
  Scenario: TC 5604 Create a New File for a course
    Given Created a New File for a course
    When The New File got successfully created
    Then A Course Entity for New File should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Document'
    And ['entity'].['name'] = File Name
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['courseSection'].['@id'] value includes the course id
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The ['entity'].['extensions'].['moduleType'] = 'resource'

  @IntegrationTest @EndToEndTest
  Scenario: TC 5605 Update the Existing File for a course
    Given Updated the Existing File for a course
    When The Existing File got successfully updated
    Then A Course Entity for Update File should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Document'
    And Updated ['entity'].['name'] = File Name
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['courseSection'].['@id'] value includes the course id
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The ['entity'].['extensions'].['moduleType'] = 'resource'
