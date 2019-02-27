@nightly @moodle
Feature: Moodle.User Story 11809- Instructor Event - Send Message to a Participant as an instructor

  @IntegrationTest @EndToEndTest
  Scenario: Send Message to a Participant as an instructor
    Given Send Message to a Participant as an instructor
    When Message got created to a Participant as an instructor
    Then Instructor Message creation Event should get generated and sent to our Raw Event Index
    And Instructor Message Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Message Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And Instructor Message Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Message Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Instructor Message Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Posted'
    And Instructor Message Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Message Event ['event'].['object'].['@type'] = 'h ttp://purl.imsglobal.org/caliper/v1/Message'
    And Instructor Message Event ['event'].['object'].['body'] = Provided Instructor Message
    And Instructor Message Event ['event'].['object'].['extensions'].['subject'] include 'New message from'
    And Instructor Message Event ['event'].['object'].['extensions'].['courseSection'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Message Event ['event'].['object'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And Instructor Message Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Message Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And Instructor Message Event ['event'].['object'].['extensions'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Message Event ['event'].['object'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Instructor Message Event ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Message Event ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Instructor Message Event ['event'].['edApp'].['name'] = 'IntellifyLearning'
