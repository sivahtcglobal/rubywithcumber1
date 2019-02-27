@moodle
Feature: Moodle.User Story 11808 - Create/Update Grouping: Instructor Event

  @IntegrationTest @EndToEndTest
  Scenario: TC 11816 Create the Grouping
    Given Login as valid instructor-Grouping
    Then Create New Grouping name and Save grouping
    Then Grouping Event should generated and send to Raw index
    And ['GROUPING'].['entity'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUPING'].['entity'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/Entity'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['@id'] == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['name'] == 'IntellifyLearning'
    And ['GROUPING'].['entity'].['extensions'].['moduleType'] == 'grouping'
    And ['GROUPING'].['entity'].['extensions'].['idname'] == 'grouping'
    And ['GROUPING'].['entity'].['name'] == 'grouping'
    Then Update Created Grouping name and Save grouping
    Then Grouping Event should generated for Update and send to Raw index
    And ['GROUPING'].['entity'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUPING'].['entity'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/Entity'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['@context'] == 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['@id'] == 'http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['@type'] == 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['GROUPING'].['entity'].['extensions'].['edApp'].['name'] == 'IntellifyLearning'
    And ['GROUPING'].['entity'].['extensions'].['moduleType'] == 'grouping'
    And ['GROUPING'].['entity'].['extensions'].['idname'] == 'grouping'
    And ['GROUPING'].['entity'].['name'] == 'groupingupdate'