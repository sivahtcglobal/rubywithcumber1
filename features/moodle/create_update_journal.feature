@moodle
Feature: Moodle.User Story 9145 - Create and Update A Journal

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Journal under a course
    Given Created a New Journal under a course
    When The New Journal got successfully created
    Then A Course Entity for New Journal should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Journal name
    And The ['entity'].['extensions'].['moduleType'] = 'journal'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity']['extensions']['gradeType'] == 'scale'
    And ['entity']['extensions']['gradeScale'] == Provided Value
    And ['entity']['extensions']['gradeToPass'] == Provided Value
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['completionTracking'] = 'manual'
    And Require View ['entity']['extensions']['requireView'] == false
    And Require Grade ['entity']['extensions']['requireGrade'] == false
    And ['entity'].['extensions'].['expectedCompletionDate'] = Provided Completion Date
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['daysAvailable'] = Provided Value

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Journal under a course
    Given Updated the existing Journal under a course
    When The existing Journal got successfully updated
    Then A Course Entity for Update Journal should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Journal name
    And The ['entity'].['extensions'].['moduleType'] = 'journal'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity']['extensions']['gradeType'] == 'point'
    And ['entity']['extensions']['gradeToPass'] == Updated Value
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['completionTracking'] = 'conditions'
    And Require View ['entity']['extensions']['requireView'] == true
    And Require Grade ['entity']['extensions']['requireGrade'] == true
    And ['entity'].['extensions'].['expectedCompletionDate'] = Updated Completion Date
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['daysAvailable'] = Updated Value
