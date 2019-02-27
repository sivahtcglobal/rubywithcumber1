@nightly @moodle
Feature: Moodle.User Story 11810- Student Event - View Message as a Student sent by an Instructor

  @IntegrationTest @EndToEndTest
  Scenario: View Message as a Student sent by an Instructor
    Given View Message as a Student sent by an Instructor
    When Message got viewed by the Student
    Then Student Message Viewed Event should get generated and sent to our Raw Event Index
    And Student Message Viewed Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Student Message Viewed Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Event'
    And Student Message Viewed Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Student Message Viewed Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Student Message Viewed Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
    And Student Message Viewed Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Student Message Viewed Event ['event'].['object'].['@type'] = 'h ttp://purl.imsglobal.org/caliper/v1/Message'
    And Student Message Viewed Event ['event'].['object'].['extensions'].['moduleType'] = 'message'
    And Student Message Viewed Event ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Student Message Viewed Event ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Student Message Viewed Event ['event'].['edApp'].['name'] = 'IntellifyLearning'
