@moodle
Feature: Moodle.User Story 6341 and 6342 - Create and Update Forum

  @IntegrationTest @EndToEndTest
  Scenario: TC 7191 Create a Forum for a course
    Given Created a New Forum for a course
    When The New Forum got successfully created
    Then A Course Entity for New Forum should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Forum name
    And ['entity'].['extensions'].['moduleType'] = 'forum'
    And ['entity'].['extensions'].['forumType'] = 'single'
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['ratingAggregateType'] = Provided Aggregate Type
    And ['entity'].['extensions'].['gradeType'] = Provided Scale Type
    And ['entity'].['extensions'].['groupMode'] = 'none'
    And ['entity'].['extensions'].['grouping'] = false
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC 7192 Update a created Forum for the course
    Given Updated the Forum for a course
    When The Forum got successfully updated
    Then A Course Entity for Update Forum should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Forum name
    And ['entity'].['extensions'].['moduleType'] = 'forum'
    And Updated ['entity'].['extensions'].['forumType'] = 'general'
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false
    And Updated ['entity'].['extensions'].['ratingAggregateType'] = Provided Aggregate Type
    And ['entity'].['extensions'].['gradeType'] = Provided Scale Type
    And ['entity'].['extensions'].['groupMode'] = 'none'
    And ['entity'].['extensions'].['grouping'] = false
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
