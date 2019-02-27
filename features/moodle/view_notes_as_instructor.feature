@nightly @moodle
Feature: Moodle.User Story 11825- Instructor Event - View Notes of a Participant as an instructor

  @IntegrationTest @EndToEndTest
  Scenario: View Notes of a Participant as an instructor
    Given View Notes of a Participant as an instructor
    When Notes list page got viewed by an instructor
    Then Instructor Note viewed Event should get generated and sent to our Raw Event Index
    And Instructor Notes viewed Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Notes viewed Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Event'
    And Instructor Notes viewed Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Notes viewed Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Instructor Notes viewed Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
    And Instructor Notes viewed Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Notes viewed Event ['event'].['object'].['@type'] = 'h ttp://purl.imsglobal.org/caliper/v1/Message'
    And Instructor Notes viewed Event ['event'].['object'].['extensions'].['moduleType'] = 'notes'
    And Instructor Notes viewed Event ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Notes viewed Event ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Instructor Notes viewed Event ['event'].['edApp'].['name'] = 'IntellifyLearning'
