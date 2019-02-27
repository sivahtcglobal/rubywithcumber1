@moodle
Feature: Moodle.User Story 9450 - Instructor Event - BigBlueButton Course Module Created/Updated

  @IntegrationTest @EndToEndTest
  Scenario: TC 9450 Create a New BigBlueButton for a course
    Given Created a New BigBlueButton for a course
    When The New BigBlueButton got successfully created
    Then A Course Entity for New BigBlueButton should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = BigBlueButton Name
    And ['entity'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['entity'].['extensions'].['courseSection'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['groupMode'] = Provided Group
    And ['entity'].['extensions'].['grouping'] = false
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['completionTracking'] = Provided Value
    And ['entity'].['extensions'].['requireView'] = Provided Value
    And ['entity'].['extensions'].['requireGrade'] = Provided Value
    And ['entity'].['extensions'].['expectedCompletionDate'] = Provided Expected Completion Date
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['participants'].[0].['type'] = 'all'
    And ['entity'].['extensions'].['participants'].[0].['id'] = 'all'
    And ['entity'].['extensions'].['joinClosed'] = Provided Join Closed Date

  @IntegrationTest @EndToEndTest
  Scenario: TC 9450 Update the Existing BigBlueButton for a course
    Given Updated the Existing BigBlueButton for a course
    When The Existing BigBlueButton got successfully updated
    Then A Course Entity for Update BigBlueButton should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = BigBlueButton Name
    And ['entity'].['extensions'].['moduleType'] = 'bigbluebuttonbn'
    And ['entity'].['extensions'].['courseSection'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['groupMode'] = Updated Group
    And ['entity'].['extensions'].['grouping'] = false
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['completionTracking'] = Updated Value
    And ['entity'].['extensions'].['requireView'] = Updated Value
    And ['entity'].['extensions'].['requireGrade'] = Provided Value
    And ['entity'].['extensions'].['expectedCompletionDate'] = Updated Expected Completion Date
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['participants'].[0].['type'] = 'all'
    And ['entity'].['extensions'].['participants'].[0].['id'] = 'all'
    And ['entity'].['extensions'].['joinClosed'] = Updated Join Closed Date
