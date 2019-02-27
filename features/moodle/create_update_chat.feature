@moodle
Feature: Moodle.User Story 9650 - Create and Update A Chat

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Chat under a course
    Given Created a New Chat under a course
    When The New Chat got successfully created
    Then A Course Entity for New Chat should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Chat name
    And The ['entity'].['extensions'].['moduleType'] = 'chat'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['chatTime'] = Provided Value
    And ['entity'].['extensions'].['chatRepeatTimes'] = Provided Value

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Chat under a course
    Given Updated the existing Chat under a course
    When The existing Chat got successfully updated
    Then A Course Entity for Update Chat should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Chat name
    And The ['entity'].['extensions'].['moduleType'] = 'chat'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And Updated ['entity'].['extensions'].['chatTime'] = Provided Value
    And Updated ['entity'].['extensions'].['chatRepeatTimes'] = Provided Value
