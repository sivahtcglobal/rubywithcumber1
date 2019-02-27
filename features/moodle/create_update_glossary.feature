@moodle
Feature: Moodle.User Story 5175 and 5205 - Create and Update A Glossary

  @IntegrationTest @EndToEndTest
  Scenario: TC 5379 Create a New Glossary for a course
    Given Created a New Glossary for a course
    When The New Glossary got successfully created
    Then A Course Entity for New Glossary should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And ['entity'].['name'] = Glossary name
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'glossary'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The ['entity'].['extensions'].['gradeToPass'] = Provided Grade
    And ['entity'].['extensions'].['ratingAggregateType'] = Provided Aggregate Type
    And ['entity'].['extensions'].['gradeType'] = Provided Scale Type
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false

  @IntegrationTest @EndToEndTest
  Scenario: TC 5380 Update the created Glossary for the course
    Given Updated the existing Glossary for a course
    When The existing Glossary got successfully updated
    Then A Course Entity for Update Glossary should get generated and sent to our Raw Entity Index.
    And ['entity'].['@context'] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['entity'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/AssignableDigitalResource'
    And Updated ['entity'].['name'] = Glossary name
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'glossary'
    And ['entity'].['extensions'].['courseSection'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseSection'
    And ['entity'].['extensions'].['courseSection'].['subOrganizationOf'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And Updated The ['entity'].['extensions'].['gradeToPass'] = Provided Grade
    And Updated ['entity'].['extensions'].['ratingAggregateType'] = Provided Aggregate Type
    And ['entity'].['extensions'].['gradeType'] = Provided Scale Type
    And ['entity'].['extensions'].['visible'] = true
    And ['entity'].['extensions'].['restrictions'] = false
