@moodle
Feature: Moodle.User Story 9694 - Create and Update A Feedback

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Feedback under a course
    Given Created a New Feedback under a course
    When The New Feedback got successfully created
    Then A Course Entity for New Feedback should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Feedback name
    And The ['entity'].['extensions'].['moduleType'] = 'feedback'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['recordUserNames'] = Provided Value
    And ['entity'].['extensions'].['allowMultipleSubmissions'] = Provided Value
    And ['entity'].['extensions'].['enableNotifications'] = Provided Value
    And ['entity'].['extensions'].['autoNumberQuestions'] = Provided Value

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Feedback under a course
    Given Updated the existing Feedback under a course
    When The existing Feedback got successfully updated
    Then A Course Entity for Update Feedback should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Feedback name
    And The ['entity'].['extensions'].['moduleType'] = 'feedback'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And Updated ['entity'].['extensions'].['recordUserNames'] = Provided Value
    And Updated ['entity'].['extensions'].['allowMultipleSubmissions'] = Provided Value
    And Updated ['entity'].['extensions'].['enableNotifications'] = Provided Value
    And Updated ['entity'].['extensions'].['autoNumberQuestions'] = Provided Value
