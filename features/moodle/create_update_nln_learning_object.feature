@moodle
Feature: Moodle.User Story 11413 - Create and Update A NLN Learning Object

  @IntegrationTest @EndToEndTest
  Scenario: TC Create A New NLN Learning Object under a course
    Given Created a New NLN Learning Object under a course
    When The New NLN Learning Object got successfully created
    Then A Course Entity for New NLN Learning Object should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = NLN Learning Object Name
    And The ['entity'].['extensions'].['moduleType'] = 'nln'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'none'
    And ['entity'].['extensions'].['nlnLearningObjectId'] = NLN learning object ID
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = false

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created NLN Learning Object under a course
    Given Updated the existing NLN Learning Object under a course
    When The existing NLN Learning Object got successfully updated
    Then A Course Entity for Update NLN Learning Object should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = NLN Learning Object Name
    And The ['entity'].['extensions'].['moduleType'] = 'nln'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'none'
    And ['entity'].['extensions'].['nlnLearningObjectId'] = NLN learning object ID
    And ['entity'].['extensions'].['restrictions'] = false
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And Updated ['entity'].['extensions'].['visible'] = true
