@nightly @moodle
Feature: Moodle.User Story 5177  and 5196 - Create and Update A Quiz Page.

  @IntegrationTest @EndToEndTest
  Scenario: TC Create a New Quiz Page for a Course
    Given Created a New Quiz Page for a Course
    When The New Quiz Page Got successfully created
    Then A Entity for New Quiz Page should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] ='http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] ='http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Provided Name
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['tags'].[0] = Provided First Tag
    And ['entity'].['extensions'].['tags'].[1] = Provided Second Tag
    And ['entity'].['extensions'].['openQuizDate'] = Provided Open Date Tag
    And ['entity'].['extensions'].['closeQuizDate'] = Provided Close Date Tag
    And ['entity'].['extensions'].['timeLimit'] = Provided Time Limit
    And ['entity'].['extensions'].['overdueHandling'] = Provided Overdue Handling
    And ['entity'].['extensions'].['gracePeriod'] = Provided Grace Period
    And The ['entity'].['extensions'].['moduleType'] = 'quiz'

  @IntegrationTest @EndToEndTest
  Scenario: TC  Update the created Question Page for the Course
    Given Updated the Created Quiz Page for the Course
    When The Quiz Page Got successfully Updated
    Then A Entity for Update Quiz Page should get generated and sent to our Raw Entity Index.
    And Updated ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And Updated ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Updated Name
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And Updated ['entity'].['extensions'].['tags'].[0] = Provided First Tag
    And Updated ['entity'].['extensions'].['tags'].[1] = Provided Second Tag
    And Updated ['entity'].['extensions'].['tags'].[2] = Provided Third Tag
    And Updated ['entity'].['extensions'].['openQuizDate'] = Updated Open Date Tag
    And Updated ['entity'].['extensions'].['closeQuizDate'] = Updated Close Date Tag
    And Updated ['entity'].['extensions'].['timeLimit'] = Updated Time Limit
    And Updated ['entity'].['extensions'].['overdueHandling'] = Updated Overdue Handling
    And Updated ['entity'].['extensions'].['gracePeriod'] = Updated Grace Period
    And The ['entity'].['extensions'].['moduleType'] = 'quiz'
