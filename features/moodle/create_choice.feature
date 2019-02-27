@moodle
Feature: Moodle.User Story 8119 - Create A Choice Page.

  @IntegrationTest @EndToEndTest
  Scenario: TC 8556 Create a New Choice Page for a Course
    Given Created a New Choice Page for a Course
    When The New Choice Page Got successfully created
    Then An Entity for New Choice Page should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Provided Choice Name
    And The ['entity'].['extensions'].['moduleType'] = 'choice'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['grouping'] = false
    And ['entity'].['extensions'].['groupMode'] = 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['completionTracking'] = 'conditions'
    And Require View ['entity']['extensions']['requireView'] == false
    And Require Grade ['entity']['extensions']['requireGrade'] == false
    And Expect completed on ['entity']['extensions']['expectedCompletionDate'] == '2017-10-08'
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['allowResponsesFromDate'] = Provided Responses From Date
    And ['entity'].['extensions'].['allowResponsesUntilDate'] = Provided Responses Until Date
    And ['entity'].['extensions'].['previewOptions'] = true
    And ['entity'].['extensions'].['publishResults'] = Provided Value
    And ['entity'].['extensions'].['resultsPrivacy'] = Provided Value
