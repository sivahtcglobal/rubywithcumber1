@moodle
Feature: Moodle.User Story 11045 - Create and Update A Survey

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Survey under a course
    Given Created a New Survey under a course
    When The New Survey got successfully created
    Then A Course Entity for New Survey should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Survey name
    And The ['entity'].['extensions'].['moduleType'] = 'survey'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'none'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['surveyType'] = Provided Survey Type

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Survey under a course
    Given Updated the existing Survey under a course
    When The existing Survey got successfully updated
    Then A Course Entity for Update Survey should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Survey name
    And The ['entity'].['extensions'].['moduleType'] = 'survey'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And Updated ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And Updated ['entity'].['extensions'].['surveyType'] = Provided Survey Type
