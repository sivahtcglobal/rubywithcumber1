@nightly @moodle @smoketest
Feature: Moodle.User Story 5176 and 5211 - Create and Update A Lesson

  @IntegrationTest @EndToEndTest
  Scenario: TC  Create a New Lesson for a course
    Given Created a New Lesson for a course
    When The New Lesson Got successfully created
    Then A Course Entity for New Lesson should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = lesson name
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['gradeType'] = scale
    And ['entity'].['extensions'].['gradeToPass'] = Provided Pass Score
    And ['entity'].['extensions'].['availableFromDate'] = Provided Date
    And ['entity'].['extensions'].['deadlineDate'] = Provided Date
    And ['entity'].['extensions'].['courseSection'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And Lesson Tag ['entity'].['extensions'].['tags'].[0] = Provided First Tag
    And Lesson Tag ['entity'].['extensions'].['tags'].[1] = Provided Second Tag
    And Lesson Tag ['entity'].['extensions'].['tags'].[2] = Provided Third Tag
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'lesson'

  @IntegrationTest @EndToEndTest
  Scenario: TC  Update the created Lesson for the course
    Given Updated the Lesson for a course
    When The Lesson Got successfully Update
    Then A Course Entity for Update Lesson should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = lesson name
    And ['entity'].['extensions'].['visible'] = true
    And Updated ['entity'].['extensions'].['gradeType']  = Point
    And Updated ['entity'].['extensions'].['gradeToPass'] = Provided Pass Score
    And Updated ['entity'].['extensions'].['availableFromDate'] = Provided Date
    And Updated ['entity'].['extensions'].['deadlineDate'] = Provided Date
    And Lesson Tag ['entity'].['extensions'].['tags'].[0] = Provided First Tag
    And Lesson Tag ['entity'].['extensions'].['tags'].[1] = Provided Second Tag
    And Lesson Tag ['entity'].['extensions'].['tags'].[2] = Provided Third Tag
    And Updated Lesson Tag ['entity'].['extensions'].['tags'].[3] = Provided Fourth Tag
    And Updated Lesson Tag ['entity'].['extensions'].['tags'].[4] = Provided Fifth Tag
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'lesson'
