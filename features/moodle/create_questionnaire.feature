@moodle
Feature: Moodle.User Story 6345 - Create A Questionnaire Page.

  @IntegrationTest @EndToEndTest
  Scenario: TC 7195 Create a New Questionnaire Page for a Course
    Given Created a New Questionnaire Page for a Course
    When The New Questionnaire Page Got successfully created
    Then A Entity for New Questionnaire Page should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Provided Questionnaire Name
    And The ['entity'].['extensions'].['moduleType'] = 'questionnaire'
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
    And ['entity'].['extensions'].['openDate'] = Provided Open Date Tag
    And ['entity'].['extensions'].['closeDate'] = Provided Close Date Tag
    And ['entity'].['extensions'].['responseType'] = 'once'
    And ['entity'].['extensions'].['respondentType'] = 'fullname'
    And ['entity'].['extensions'].['submissionGrade'] = Provided Grade
