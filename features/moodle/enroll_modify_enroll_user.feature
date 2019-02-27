@moodle
Feature: Moodle.User Story 3978 and 3983 - Enroll User and Modify Enrollment

  @IntegrationTest
  Scenario: TC 5402 Enroll Student as Admin
    Given Enroll a student to a course in Moodle
    When Student should be successfully enrolled in Moodle
    Then Enroll student user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Learner']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user is enrolled
    And The event should have ['entity.member'] value includes the user id who is enrolled

  @IntegrationTest
  Scenario: TC 5403 Modify Student Enrollment as Admin
    Given Modify a student enrollment to a course in Moodle
    When Student enrollment should be successfully modified in Moodle
    Then Modify student enrollment event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user enrollment is modified
    And The event should have ['entity.member'] value includes the user id whose enrollment is modified

  @IntegrationTest
  Scenario: TC 5402 Enroll Instructor as Admin
    Given Enroll an instructor to a course in Moodle
    When Instructor should be successfully enrolled in Moodle
    Then Enroll instructor user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user is enrolled
    And The event should have ['entity.member'] value includes the user id who is enrolled

  @IntegrationTest
  Scenario: TC 5403 Modify Instructor Enrollment as Admin
    Given Modify an instructor enrollment to a course in Moodle
    When Instructor enrollment should be successfully modified in Moodle
    Then Modify instructor enrollment event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Learner']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user enrollment is modified
    And The event should have ['entity.member'] value includes the user id whose enrollment is modified

  @EndToEndTest
  Scenario: TC 5402 Enroll Student as Admin
    Given CSV Record Counts before Sending Enrollment Entity
    Given Tableau Record Counts before Sending Enrollment Entity
    Given Enroll a student to a course in Moodle
    When Student should be successfully enrolled in Moodle
    Then Enroll student user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Learner']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user is enrolled
    And The event should have ['entity.member'] value includes the user id who is enrolled
    Then An Entity for Enrol Student should get generated and sent to CSV.
    And Enrol Student CSV ['User Display Name'] Column Value = Provided Student Name
    And Enrol Student CSV ['User Name'] Column Value = Provided User Name
    And Enrol Student CSV ['Course ID'] Column Value = Generated Course ID
    And Enrol Student CSV ['Course Name'] Column Value = Provided Course Name
    And Enrol Student CSV ['Course Category ID'] Column Value = Course Category ID
    And Enrol Student CSV ['Course Category Name'] Column Value = Provided Course Category Name
    And Enrol Student CSV ['Role'] Column Value = Provided Role
    Then An Entity for Enrol Student should get generated and sent to Tableau.
    And Enrol Student Tableau ['User Display Name'] Column Value = Provided Student Name
    And Enrol Student Tableau ['User Name'] Column Value = Provided User Name
    And Enrol Student Tableau ['Course ID'] Column Value = Generated Course ID
    And Enrol Student Tableau ['Course Name'] Column Value = Provided Course Name
    And Enrol Student Tableau ['Course Category ID'] Column Value = Course Category ID
    And Enrol Student Tableau ['Course Category Name'] Column Value = Provided Course Category Name
    And Enrol Student Tableau ['Role'] Column Value = Provided Role

  @EndToEndTest
  Scenario: TC 5403 Modify Student Enrollment as Admin
    Given CSV Record Counts before Sending Enrollment Entity
    Given Tableau Record Counts before Sending Enrollment Entity
    Given Modify a student enrollment to a course in Moodle
    When Student enrollment should be successfully modified in Moodle
    Then Modify student enrollment event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user enrollment is modified
    And The event should have ['entity.member'] value includes the user id whose enrollment is modified
    Then An Entity for Modify Student Enrollment should get generated and sent to CSV.
    And Modify Student Enrollment CSV ['User Display Name'] Column Value = Provided Student Name
    And Modify Student Enrollment CSV ['User Name'] Column Value = Provided User Name
    And Modify Student Enrollment CSV ['Course ID'] Column Value = Generated Course ID
    And Modify Student Enrollment CSV ['Course Name'] Column Value = Provided Course Name
    And Modify Student Enrollment CSV ['Course Category ID'] Column Value = Course Category ID
    And Modify Student Enrollment CSV ['Course Category Name'] Column Value = Provided Course Category Name
    And Modify Student Enrollment CSV ['Role'] Column Value = Updated Role
    Then An Entity for Modify Student Enrollment should get generated and sent to Tableau.
    And Modify Student Enrollment Tableau ['User Display Name'] Column Value = Provided Student Name
    And Modify Student Enrollment Tableau ['User Name'] Column Value = Provided User Name
    And Modify Student Enrollment Tableau ['Course ID'] Column Value = Generated Course ID
    And Modify Student Enrollment Tableau ['Course Name'] Column Value = Provided Course Name
    And Modify Student Enrollment Tableau ['Course Category ID'] Column Value = Course Category ID
    And Modify Student Enrollment Tableau ['Course Category Name'] Column Value = Provided Course Category Name
    And Modify Student Enrollment Tableau ['Role'] Column Value = Updated Role

  @EndToEndTest
  Scenario: TC 5402 Enroll Instructor as Admin
    Given CSV Record Counts before Sending Enrollment Entity
    Given Tableau Record Counts before Sending Enrollment Entity
    Given Enroll an instructor to a course in Moodle
    When Instructor should be successfully enrolled in Moodle
    Then Enroll instructor user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user is enrolled
    And The event should have ['entity.member'] value includes the user id who is enrolled
    Then An Entity for Enrol Instructor should get generated and sent to CSV.
    And Enrol Instructor CSV ['User Display Name'] Column Value = Provided Instructor Name
    And Enrol Instructor CSV ['User Name'] Column Value = Provided User Name
    And Enrol Instructor CSV ['Course ID'] Column Value = Generated Course ID
    And Enrol Instructor CSV ['Course Name'] Column Value = Provided Course Name
    And Enrol Instructor CSV ['Course Category ID'] Column Value = Course Category ID
    And Enrol Instructor CSV ['Course Category Name'] Column Value = Provided Course Category Name
    And Enrol Instructor CSV ['Role'] Column Value = Provided Role
    Then An Entity for Enrol Instructor should get generated and sent to Tableau.
    And Enrol Instructor Tableau ['User Display Name'] Column Value = Provided Instructor Name
    And Enrol Instructor Tableau ['User Name'] Column Value = Provided User Name
    And Enrol Instructor Tableau ['Course ID'] Column Value = Generated Course ID
    And Enrol Instructor Tableau ['Course Name'] Column Value = Provided Course Name
    And Enrol Instructor Tableau ['Course Category ID'] Column Value = Course Category ID
    And Enrol Instructor Tableau ['Course Category Name'] Column Value = Provided Course Category Name
    And Enrol Instructor Tableau ['Role'] Column Value = Provided Role

  @EndToEndTest
  Scenario: TC 5403 Modify Instructor Enrollment as Admin
    Given CSV Record Counts before Sending Enrollment Entity
    Given Tableau Record Counts before Sending Enrollment Entity
    Given Modify an instructor enrollment to a course in Moodle
    When Instructor enrollment should be successfully modified in Moodle
    Then Modify instructor enrollment event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] values as ['http://purl.imsglobal.org/caliper/v1/lis/Membership']
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'enrolment'
    And The event should have ['entity.roles'] values as ['http://purl.imsglobal.org/vocab/lis/v2/membership#Learner']
    And The event should have ['entity.status'] values as ['http://purl.imsglobal.org/vocab/lis/v2/status#Active']
    And The event should have ['entity.@id'] value includes the course id in which user enrollment is modified
    And The event should have ['entity.member'] value includes the user id whose enrollment is modified
    Then An Entity for Modify Instructor Enrollment should get generated and sent to CSV.
    And Modify Instructor Enrollment CSV ['User Display Name'] Column Value = Provided Instructor Name
    And Modify Instructor Enrollment CSV ['User Name'] Column Value = Provided User Name
    And Modify Instructor Enrollment CSV ['Course ID'] Column Value = Generated Course ID
    And Modify Instructor Enrollment CSV ['Course Name'] Column Value = Provided Course Name
    And Modify Instructor Enrollment CSV ['Course Category ID'] Column Value = Course Category ID
    And Modify Instructor Enrollment CSV ['Course Category Name'] Column Value = Provided Course Category Name
    And Modify Instructor Enrollment CSV ['Role'] Column Value = Updated Role
    Then An Entity for Modify Instructor Enrollment should get generated and sent to Tableau.
    And Modify Instructor Enrollment Tableau ['User Display Name'] Column Value = Provided Instructor Name
    And Modify Instructor Enrollment Tableau ['User Name'] Column Value = Provided User Name
    And Modify Instructor Enrollment Tableau ['Course ID'] Column Value = Generated Course ID
    And Modify Instructor Enrollment Tableau ['Course Name'] Column Value = Provided Course Name
    And Modify Instructor Enrollment Tableau ['Course Category ID'] Column Value = Course Category ID
    And Modify Instructor Enrollment Tableau ['Course Category Name'] Column Value = Provided Course Category Name
    And Modify Instructor Enrollment Tableau ['Role'] Column Value = Updated Role
