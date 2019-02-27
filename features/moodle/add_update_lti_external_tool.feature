@moodle
Feature: Moodle.User Story 11002 - Add and Update LTI External Tool

  @IntegrationTest @EndToEndTest
  Scenario: TC Add a LTI External Tool for a course
    Given Added a New LTI External Tool for a course
    When The New LTI External Tool got successfully added
    Then A Course Entity for New LTI External Tool should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = LTI External Tool Name
    And The ['entity'].['extensions'].['moduleType'] = 'lti'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['gradeType'] = 'scale'
    And The ['entity'].['extensions'].['gradeToPass'] = Provided Grade To Pass value
    And ['entity'].['extensions'].['visible'] = false
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'none'
    And ['entity'].['extensions'].['preconfiguredTool'] = 'Kaltura'
    And ['entity'].['extensions'].['preconfiguredToolUrl'] = Preconfigured Tool Url
    And ['entity'].['extensions'].['privacyShareLauncherNameWithTheTool'] = true
    And ['entity'].['extensions'].['privacyShareLauncherEmailWithTheTool'] = true
    And ['entity'].['extensions'].['acceptGradesFromTheTool'] = true
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags

  @IntegrationTest @EndToEndTest
  Scenario: TC Update a created LTI External Tool for the course
    Given Updated the LTI External Tool for a course
    When The LTI External Tool got successfully updated
    Then A Course Entity for Update LTI External Tool should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = LTI External Tool Name
    And The ['entity'].['extensions'].['moduleType'] = 'lti'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And Updated The ['entity'].['extensions'].['gradeType'] = 'point'
    And The ['entity'].['extensions'].['gradeToPass'] = Updated Grade To Pass value
    And Updated ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'none'
    And ['entity'].['extensions'].['preconfiguredTool'] = 'Kaltura'
    And ['entity'].['extensions'].['preconfiguredToolUrl'] = Preconfigured Tool Url
    And ['entity'].['extensions'].['privacyShareLauncherNameWithTheTool'] = true
    And ['entity'].['extensions'].['privacyShareLauncherEmailWithTheTool'] = true
    And ['entity'].['extensions'].['acceptGradesFromTheTool'] = true
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
