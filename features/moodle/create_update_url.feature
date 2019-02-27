@moodle
Feature: Moodle.User Story 5174 and 5216 - Create and Update A URL

  @IntegrationTest @EndToEndTest
  Scenario: TC 5602 Create a New URL for a course
    Given Created a New URL for a course
    When The New URL got successfully created
    Then A Course Entity for New URL should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/WebPage'
    And ['entity'].['name'] = URL name
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['externalurl'] = Provided URL
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['courseSection'].['@id'] value includes the course id
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The ['entity'].['extensions'].['moduleType'] = 'url'

  @IntegrationTest @EndToEndTest
  Scenario: TC 5603 Update the created URL for the course
    Given Updated the existing URL for a course
    When The existing URL got successfully updated
    Then A Course Entity for Update URL should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/WebPage'
    And Updated ['entity'].['name'] = URL name
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false
    And Updated ['entity'].['extensions'].['externalurl'] = Provided URL
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['courseSection'].['@id'] value includes the course id
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The ['entity'].['extensions'].['moduleType'] = 'url'
