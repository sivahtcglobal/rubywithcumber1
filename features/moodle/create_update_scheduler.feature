@moodle
Feature: Moodle.User Story 11255 - Create and Update A Scheduler

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Scheduler under a course
    Given Created a New Scheduler under a course
    When The New Scheduler got successfully created
    Then A Course Entity for New Scheduler should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Scheduler Name
    And The ['entity'].['extensions'].['moduleType'] = 'scheduler'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['gradeType'] = scale
    And The ['entity'].['extensions'].['gradeToPass'] = Provided Grade To Pass value
    And ['entity'].['extensions'].['visible'] = false
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'separate'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['completionTracking'] = 'manual'
    And ['entity'].['extensions'].['requireView'] = false
    And ['entity'].['extensions'].['requireGrade'] = false
    And ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And ['entity'].['extensions'].['rolenameOfTeacher'] = Provided Role Name
    And ['entity'].['extensions'].['studentsCanRegister'] = Provided Value
    And ['entity'].['extensions'].['appointment'] = Provided Value
    And ['entity'].['extensions'].['guardtime'] = Provided Value
    And ['entity'].['extensions'].['bookinGrouping'] = Provided Value
    And ['entity'].['extensions'].['defaultSlotDuration'] = Provided Value
    And ['entity'].['extensions'].['notifications'] = Provided Value
    And ['entity'].['extensions'].['useNotesAppointments'] = Provided Value

  @IntegrationTest @EndToEndTest
  Scenario: TC Update the created Scheduler under a course
    Given Updated the existing Scheduler under a course
    When The existing Scheduler got successfully updated
    Then A Course Entity for Update Scheduler should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Scheduler Name
    And The ['entity'].['extensions'].['moduleType'] = 'scheduler'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And Updated ['entity'].['extensions'].['gradeType'] = point
    And Updated The ['entity'].['extensions'].['gradeToPass'] = Provided Grade To Pass value
    And ['entity'].['extensions'].['visible'] = true
    And ['entity']['extensions']['grouping'] == false
    And ['entity']['extensions']['groupMode'] == 'visible'
    And ['entity'].['extensions'].['restrictions'] = false
    And ['entity'].['extensions'].['completionTracking'] = 'conditions'
    And ['entity'].['extensions'].['requireView'] = false
    And Updated ['entity'].['extensions'].['requireGrade'] = true
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided Tags
    And Updated ['entity'].['extensions'].['rolenameOfTeacher'] = Provided Role Name
    And Updated ['entity'].['extensions'].['studentsCanRegister'] = Provided Value
    And Updated ['entity'].['extensions'].['appointment'] = Provided Value
    And Updated ['entity'].['extensions'].['guardtime'] = Provided Value
    And Updated ['entity'].['extensions'].['bookinGrouping'] = Provided Value
    And Updated ['entity'].['extensions'].['defaultSlotDuration'] = Provided Value
    And Updated ['entity'].['extensions'].['notifications'] = Provided Value
    And Updated ['entity'].['extensions'].['useNotesAppointments'] = Provided Value
