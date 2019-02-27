@moodle
Feature: Moodle.User Story 11770 - Quiz Attempt Started: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC 11770 Start a Quiz Attempt for a course
    Given Started a Quiz Attempt for a instructor course
    When The Quiz Attempt got successfully started by instructor
    Then An Event for Quiz Attempt Started should get generated for instructor and sent to our Raw Event Index.
    And ['event']['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event']['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssessmentEvent'
    And ['event']['action'] == 'http://purl.imsglobal.org/vocab/caliper/v1/action#Started'
    And ['event']['actor']['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event']['actor']['@type'] == 'http://purl.imsglobal.org/caliper/v1/lis/Person'
    And ['event']['edApp']['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event']['edApp']['@id'] == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
    And ['event']['edApp']['@type'] == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['event']['edApp']['name'] == 'IntellifyLearning'
    And ['event']['generated']['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event']['generated']['@type'] == 'http://purl.imsglobal.org/caliper/v1/Attempt'
    And ['event']['generated']['assignable']['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event']['generated']['assignable']['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event']['generated']['assignable']['extensions']['moduleType'] == 'quiz'
    And ['event']['generated']['count'] == '1'
    And ['event']['generated']['extensions']['moduleType'] == 'quiz_attempt_preview'
    And ['event']['object']['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['event']['object']['@type'] == 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['event']['object']['extensions']['moduleType'] == 'quiz'