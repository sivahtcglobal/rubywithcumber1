@nightly @moodle
Feature: Moodle.User Story 3966 - Create and Update an Assignment for a Given Course

  @IntegrationTest @EndToEndTest
  Scenario: TC  Create a New Assignment for a Given Course
    Given Created a New Assignment for a Given Course
    When The New Assignment Got successfully for a Given Course
    Then A Course Entity for the New Assignment should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Assignment Name ['entity']['name'].should == Provided Assignment Name
    And The ['entity'].['extensions'].['moduleType'] = 'assign'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And Allow Submission From ['entity']['dateToStartOn'] == '2018-02-01T05:00:00.000Z'
    And Due Date ['entity']['dateToSubmit'] == '2018-11-24T05:00:00.000Z'
    And Cut-off data ['entity']['extensions']['dateToCutOff'] == '2018-12-31T10:40:00.000Z'
    And Submission types ['entity']['extensions']['submissionTypes'] == Provided Options
    And Maximum number of uploaded files ['entity']['extensions']['maxUploadedFiles'] == Provided Value
    And Require Students Click Submit Button ['entity']['extensions']['requireSubmitButton'] == true
    And Require that students accept the submission statement ['entity']['extensions']['requireSubmissionStatement'] == true
    And Maximum attempts ['_source']['entity']['maxAttempts'] == Provided Value
    And Grade ['entity']['maxScore'] == Provided Value
    And Grading method ['entity']['extensions']['gradingMethod'] == 'guide'
    And Visible ['entity']['extensions']['visible'] == true
    And Completion tracking ['entity']['extensions']['completionTracking'] == 'conditions'
    And Require View ['entity']['extensions']['requireView'] == true
    And Require Grade ['entity']['extensions']['requireGrade'] == true
    And Expect completed on ['entity']['extensions']['expectedCompletionDate'] == '2018-01-16T05:00:00.000Z'
    And Max Score ['entity']['maxScore'] == Provided Value

  @IntegrationTest @EndToEndTest
  Scenario: TC  Update the Created Assignment for a Given Course
    Given Updated the New Assignment for the Given Course
    When The Assignment Got successfully Updated for the Given Course
    Then A Course Entity for the Updated Assignment should get generated and sent to our Raw Entity Index.
    And Updated Assignment Name ['entity']['name'].should == Provided Assignment Name
    And The ['entity'].['extensions'].['moduleType'] = 'assign'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And Updated Allow Submission From ['entity']['dateToStartOn'] == '2018-02-01T05:00:00.000Z'
    And Updated Due Date ['entity']['dateToSubmit'] == '2018-11-24T05:00:00.000Z'
    And Updated Cut-off data ['entity']['extensions']['dateToCutOff'] == '2018-12-31T10:40:00.000Z'
    And Updated Submission types ['entity']['extensions']['submissionTypes'] == Provided Options
    And Updated Maximum number of uploaded files ['entity']['extensions']['maxUploadedFiles'] == Provided Value
    And Updated Require Students Click Submit Button ['entity']['extensions']['requireSubmitButton'] == true
    And Updated Require that students accept the submission statement ['entity']['extensions']['requireSubmissionStatement'] == true
    And Updated Maximum attempts ['_source']['entity']['maxAttempts'] == Provided Value
    And Updated Grade ['entity']['maxScore'] == Provided Value
    And Updated Grading method ['entity']['extensions']['gradingMethod'] == 'guide'
    And Updated Visible ['entity']['extensions']['visible'] == true
    And Updated Completion tracking ['entity']['extensions']['completionTracking'] == 'conditions'
    And Updated Require View ['entity']['extensions']['requireView'] == true
    And Updated Require Grade ['entity']['extensions']['requireGrade'] == true
    And Updated Expect completed on ['entity']['extensions']['expectedCompletionDate'] == '2018-01-16T05:00:00.000Z'
    And Updated Max Score ['entity']['maxScore'] == Provided Value
