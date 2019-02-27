@nightly @moodle
Feature: Moodle.User Story 11824- Instructor Event - Enter and Update Note to a Participant as an instructor

  @IntegrationTest @EndToEndTest
  Scenario Outline: Enter Note to a Participant as an instructor
    Given Enter <Context> Note to a Participant as an instructor
    When Note got created to a Participant as an instructor
    Then Instructor Note creation Event should get generated and sent to our Raw Event Index
    And Instructor Note Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And Instructor Note Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Instructor Note Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Created'
    And Instructor Note Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Event ['event'].['object'].['@type'] = 'h ttp://purl.imsglobal.org/caliper/v1/Message'
    And Instructor Note Event ['event'].['object'].['body'] = Provided Instructor Note
    And Instructor Note Event ['event'].['object'].['extensions'].['moduleType'] = 'notes'
    And Instructor Note Event ['event'].['object'].['extensions'].['context'] = '<Context>'
    And Instructor Note Event ['event'].['object'].['extensions'].['courseSection'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Event ['event'].['object'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And Instructor Note Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And Instructor Note Event ['event'].['object'].['extensions'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Event ['event'].['object'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Instructor Note Event ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Event ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Instructor Note Event ['event'].['edApp'].['name'] = 'IntellifyLearning'

    Examples:
    |Context |
    |site    |
    |course     |
    |personal   |

  @IntegrationTest @EndToEndTest
  Scenario Outline: Update the Note to a Participant as an instructor
    Given Update the <Context> Note to a Participant as an instructor
    When Note got Updated to a Participant as an instructor
    Then Instructor Note Updation Event should get generated and sent to our Raw Event Index
    And Instructor Note Updation Event ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Updation Event ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/MessageEvent'
    And Instructor Note Updation Event ['event'].['actor'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Updation Event ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And Instructor Note Updation Event ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Updated'
    And Instructor Note Updation Event ['event'].['object'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Updation Event ['event'].['object'].['@type'] = 'h ttp://purl.imsglobal.org/caliper/v1/Message'
    And Instructor Note Updation Event ['event'].['object'].['body'] = Provided Instructor Note
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['moduleType'] = 'notes'
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['context'] = '<Context>'
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['courseSection'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Updation Event ['event'].['object'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Instructor Note Updation Event ['event'].['edApp'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Instructor Note Updation Event ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And Instructor Note Updation Event ['event'].['edApp'].['name'] = 'IntellifyLearning'

    Examples:
      |Context |
      |site    |
      |course     |
      |personal   |