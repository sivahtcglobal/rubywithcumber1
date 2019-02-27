@moodle
Feature: Moodle.User Story 11656 - Create and Update A Game

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Game under a course
    Given Created a New Game under a course
    When The New Game got successfully created
    Then A Course Entity for New Game should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Game name
    And The ['entity'].['extensions'].['moduleType'] = 'game'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['closeGame'] = Provided Close Game Date
    And ['entity'].['extensions'].['completionTracking'] = 'manual'
    And The ['entity'].['extensions'].['expectedCompletionDate'] = Provided Date
    And ['entity'].['extensions'].['gameKind'] = 'bookquiz'
    And The ['entity'].['extensions'].['gradeToPass'] = Provided Grade To Pass
    And The ['entity'].['extensions'].['gradeType'] = 'point'
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity']['extensions']['grouping'] == false
    And The ['entity'].['extensions'].['openGame'] = Provided Open Game Date
    And Require Grade ['entity']['extensions']['requireGrade'] == false
    And Require View ['entity']['extensions']['requireView'] == false
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = false

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Game under a course
    Given Updated the existing Game under a course
    When The existing Game got successfully updated
    Then A Course Entity for Update Game should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Game name
    And The ['entity'].['extensions'].['moduleType'] = 'game'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And Updated The ['entity'].['extensions'].['closeGame'] = Provided Close Game Date
    And ['entity'].['extensions'].['completionTracking'] = 'conditions'
    And Updated The ['entity'].['extensions'].['expectedCompletionDate'] = Provided Date
    And ['entity'].['extensions'].['gameKind'] = 'bookquiz'
    And Updated The ['entity'].['extensions'].['gradeToPass'] = Provided Grade To Pass
    And The ['entity'].['extensions'].['gradeType'] = 'point'
    And ['entity']['extensions']['groupMode'] == 'none'
    And ['entity']['extensions']['grouping'] == false
    And Updated The ['entity'].['extensions'].['openGame'] = Provided Open Game Date
    And Require Grade ['entity']['extensions']['requireGrade'] == true
    And Require View ['entity']['extensions']['requireView'] == true
    And ['entity'].['extensions'].['restrictions'] = false
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['visible'] = true
