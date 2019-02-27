@moodle
Feature: Moodle.User Story 11806 - Create and Update A Group

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Group under a course
    Given Created a New Group under a course
    When The New Group got successfully created
    Then A Course Entity for New Group should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Entity'
    And ['entity'].['name'] = Group name
    And The ['entity'].['extensions'].['moduleType'] = 'group'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['idNumber'] = Provided Value
    And The ['entity'].['extensions'].['description'] = Provided Description
    And The ['entity'].['extensions'].['hidePicture'] = false

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Group under a course
    Given Updated the existing Group under a course
    When The existing Group got successfully updated
    Then A Course Entity for Update Group should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Entity'
    And Updated ['entity'].['name'] = Group name
    And The ['entity'].['extensions'].['moduleType'] = 'group'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And Updated The ['entity'].['extensions'].['idNumber'] = Provided Value
    And Updated The ['entity'].['extensions'].['description'] = Provided Description
    And The ['entity'].['extensions'].['hidePicture'] = true
