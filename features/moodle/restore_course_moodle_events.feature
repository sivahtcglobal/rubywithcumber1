@moodle
Feature: Moodle.User Story 8897 - Restore Course

  @IntegrationTest @EndToEndTest
  Scenario: TC Restore a course with tags that are being tracked into a category that is being tracked
    Given Restore a course with tags that are being tracked into a category that is being tracked
    When The Course got successfully restored in Moodle
    Then Entities for Restored Course should get generated and sent to our Raw Entity Index.
    Then Entity for Choice should get generated and sent to our Raw Entity Index.
    Then Entity for Page should get generated and sent to our Raw Entity Index.
    Then Entity for Update Glossary should get generated and sent to our Raw Entity Index.
    Then Entity for Lesson should get generated and sent to our Raw Entity Index.
    Then Entity for Enrollment should get generated and sent to our Raw Entity Index.
    Then Entity for Folder should get generated and sent to our Raw Entity Index.
    Then Entity for Forum should get generated and sent to our Raw Entity Index.
    Then Entity for URL should get generated and sent to our Raw Entity Index.
    Then Entity for Questionnaire should get generated and sent to our Raw Entity Index.
    Then Entity for Glossary should get generated and sent to our Raw Entity Index.
    Then Entity for Forum Announcements should get generated and sent to our Raw Entity Index.
    Then Entity for Restore Course should get generated and sent to our Raw Entity Index.
    Then Entity for File should get generated and sent to our Raw Entity Index.
    Then Entity for Advanced Forum should get generated and sent to our Raw Entity Index.
    Then Entity for Quiz should get generated and sent to our Raw Entity Index.
    Then Entity for Assignment should get generated and sent to our Raw Entity Index.
