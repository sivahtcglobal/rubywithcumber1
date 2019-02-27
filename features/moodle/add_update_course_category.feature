@moodle
Feature: Moodle.User Story 5170 and 5223 - Add and Update A Course Category

  @IntegrationTest @EndToEndTest
  Scenario: TC 5487 Add Course Category as Admin
    Given Add a new course category in Moodle
    When Course category should be successfully created in Moodle
    Then Add course category event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Group']
    And The event should have ['entity.extensions.categoryNumber'] category id value as provided
    And The event should have ['entity.name'] category name value as provided
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'course_category'

  @IntegrationTest @EndToEndTest
  Scenario: TC 5511 Update Course Category as Admin
    Given Update an existing course category in Moodle
    When Course category should be successfully updated in Moodle
    Then Update course category event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Group']
    And The event should have ['entity.extensions.categoryNumber'] category id value as updated
    And The event should have ['entity.name'] category name value as provided
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'course_category'
