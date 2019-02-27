@moodle
Feature: Moodle.User Story 9651 - Send Message To Chat: Student Event and Send Message To Chat: Instructor Event

  @IntegrationTest
  Scenario: TC Student Send a Message To Chat
    Given Sent a Chat Message by Student
    When The Chat Message got successfully sent by Student
    Then An Event for Student Chat Message should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'chat'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'chat_message'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'chat'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @EndToEndTest
  Scenario: TC Student Send a Message To Chat
    Given CSV Record Counts before Sending Event
    Given Tableau Record Counts before Sending Event
    Given Sent a Chat Message by Student
    When The Chat Message got successfully sent by Student
    Then An Event for Student Chat Message should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'chat'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'chat_message'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'chat'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
    Then An Event for Student Chat Message should get generated and sent to CSV.
    And Student Chat Message CSV ['Action'] Column Value = 'Submitted'
    And Student Chat Message CSV ['Page'] Column Value = 'chat_message'
    And Student Chat Message CSV ['Activity Type'] Column Value = 'chat'
    And Student Chat Message CSV ['Activity Name'] Column Value = Provided Chat Name
    And Student Chat Message CSV ['Data Source'] Column Value = 'Moodle'
    Then An Event for Student Chat Message should get generated and sent to Tableau.
    And Student Chat Message Tableau ['Action'] Column Value = 'Submitted'
    And Student Chat Message Tableau ['Page'] Column Value = 'chat_message'
    And Student Chat Message Tableau ['Activity Type'] Column Value = 'chat'
    And Student Chat Message Tableau ['Activity Name'] Column Value = Provided Chat Name
    And Student Chat Message Tableau ['Data Source'] Column Value = 'Moodle'

  @IntegrationTest @EndToEndTest
  Scenario: TC Student View the Chat Sessions
    Given View the Chat Sessions by Student
    When The Chat Sessions got successfully viewed by Student
    Then An Event for Student Chat Sessions Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Event'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'chat_sessions'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC Instructor Send a Message To Chat
    Given Sent a Chat Message by Instructor
    When The Chat Message got successfully sent by Instructor
    Then An Event for Instructor Chat Message should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableEvent'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Submitted'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'chat'
    And ['event'].['generated'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event'].['generated'].['extensions'].['moduleType'] = 'chat_message'
    And ['event'].['generated'].['assignable'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['generated'].['assignable'].['extensions'].['moduleType'] = 'chat'
    And ['event'].['generated'].['count'] = 1
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'

  @IntegrationTest @EndToEndTest
  Scenario: TC Instructor View the Chat Sessions
    Given View the Chat Sessions by Instructor
    When The Chat Sessions got successfully viewed by Instructor
    Then An Event for Instructor Chat Sessions Viewed should get generated and sent to our Raw Event Index.
    And ['event'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/Event'
    And ['event'].['actor'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event'].['action'] = 'http://purl.imsglobal.org/vocab/caliper/v1/action#Viewed'
    And ['event'].['object'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event'].['object'].['extensions'].['moduleType'] = 'chat_sessions'
    And ['event'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event'].['edApp'].['name'] = 'IntellifyLearning'
