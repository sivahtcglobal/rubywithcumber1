@moodle
Feature: Moodle.User Story 5213 and 5214 - Add and Update Advanced Forum

  @IntegrationTest @EndToEndTest
  Scenario: TC 5608 Add an Advanced Forum for a course
    Given Added a New Advanced Forum for a course
    When The New Advanced Forum got successfully created
    Then A Course Entity for New Advanced Forum should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Advanced Forum name
    And The ['entity'].['extensions'].['moduleType'] = 'hsuforum'
    And The ['entity'].['extensions'].['forumType'] = 'general'
    And The ['entity'].['extensions'].['gradingType'] = 'manual'
    And The ['entity'].['extensions'].['gradeType'] = 'point'
    And The ['entity'].['extensions'].['gradeToPass'] = Provided value
    And ['entity'].['extensions'].['ratingAggregateType'] = 'average'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC 5609 Update a created Advanced Forum for the course
    Given Updated the Advanced Forum for a course
    When The Advanced Forum got successfully updated
    Then A Course Entity for Update Advanced Forum should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] should have advanced forum name value as updated
    And The ['entity'].['extensions'].['moduleType'] = 'hsuforum'
    And The ['entity'].['extensions'].['forumType'] = 'general'
    And Updated The ['entity'].['extensions'].['gradingType'] = 'rating'
    And The ['entity'].['extensions'].['gradeType'] = 'point'
    And The ['entity'].['extensions'].['gradeToPass'] = Provided value
    And ['entity'].['extensions'].['ratingAggregateType'] = 'average'
    And ['entity'].['extensions'].['visible'] = true
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
