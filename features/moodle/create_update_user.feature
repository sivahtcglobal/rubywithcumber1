@moodle
Feature: Moodle. User Story 2715 and 3977 - Create and Update User

  @IntegrationTest
  Scenario: TC 5294 Create Student as Admin
    Given Create a new student in Moodle
    When Student should be successfully created in Moodle
    Then Create user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Student Value
    And ['entity'].['extensions'].['email'] = Provided Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Student'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'

  @IntegrationTest
  Scenario: TC 5295 Update Student as Admin
    Given Update an existing student in Moodle
    When Student should be successfully updated in Moodle
    Then Update user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Student Value
    And Update ['entity'].['extensions'].['email'] = Provided Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Student'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'

  @IntegrationTest
  Scenario: TC 5294 Create Instructor as Admin
    Given Create a new instructor in Moodle
    When Instructor should be successfully created in Moodle
    Then Create user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Instructor Value
    And ['entity'].['extensions'].['email'] = Provided Instructor Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Instructor'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'

  @IntegrationTest
  Scenario: TC 5295 Update Instructor as Admin
    Given Update an existing instructor in Moodle
    When Instructor should be successfully updated in Moodle
    Then Update user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Instructor Value
    And Update ['entity'].['extensions'].['email'] = Provided Instructor Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Instructor'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'

  @EndToEndTest
  Scenario: TC 5294 Create Student as Admin
    Given CSV Record Counts before Sending User Entity
    Given Tableau Record Counts before Sending User Entity
    Given Create a new student in Moodle
    When Student should be successfully created in Moodle
    Then Create user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Student Value
    And ['entity'].['extensions'].['email'] = Provided Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Student'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'
    Then An Entity for Create Student should get generated and sent to CSV.
    And Create Student CSV ['User Display Name'] Column Value = Provided Student Name
    And Create Student CSV ['User Name'] Column Value = Provided User Name
    And Create Student CSV ['Username'] Column Value = Provided UserName
    And Create Student CSV ['User First Name'] Column Value = Provided User First Name
    And Create Student CSV ['User Last Name'] Column Value = Provided User Last Name
    And Create Student CSV ['Email Address'] Column Value = Provided User Email Address
    And Create Student CSV ['City'] Column Value = Provided City
    And Create Student CSV ['Country'] Column Value = Provided Country
    And Create Student CSV ['Time Zone'] Column Value = Provided Time Zone
    And Create Student CSV ['Description'] Column Value = Provided Description
    And Create Student CSV ['Institution'] Column Value = Provided Institution
    And Create Student CSV ['Phone Number'] Column Value = Provided Phone Number
    And Create Student CSV ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Create Student CSV ['Address'] Column Value = Provided Address
    And Create Student CSV ['Data Source'] Column Value = 'Moodle'
    Then An Entity for Create Student should get generated and sent to Tableau.
    And Create Student Tableau ['User Display Name'] Column Value = Provided Student Name
    And Create Student Tableau ['User Name'] Column Value = Provided User Name
    And Create Student Tableau ['Username'] Column Value = Provided UserName
    And Create Student Tableau ['User First Name'] Column Value = Provided User First Name
    And Create Student Tableau ['User Last Name'] Column Value = Provided User Last Name
    And Create Student Tableau ['Email Address'] Column Value = Provided User Email Address
    And Create Student Tableau ['City'] Column Value = Provided City
    And Create Student Tableau ['Country'] Column Value = Provided Country
    And Create Student Tableau ['Time Zone'] Column Value = Provided Time Zone
    And Create Student Tableau ['Description'] Column Value = Provided Description
    And Create Student Tableau ['Institution'] Column Value = Provided Institution
    And Create Student Tableau ['Phone Number'] Column Value = Provided Phone Number
    And Create Student Tableau ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Create Student Tableau ['Address'] Column Value = Provided Address
    And Create Student Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC 5295 Update Student as Admin
    Given CSV Record Counts before Sending User Entity
    Given Tableau Record Counts before Sending User Entity
    Given Update an existing student in Moodle
    When Student should be successfully updated in Moodle
    Then Update user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Student Value
    And Update ['entity'].['extensions'].['email'] = Provided Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Student'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'
    Then An Entity for Update Student should get generated and sent to CSV.
    And Update Student CSV ['User Display Name'] Column Value = Provided Student Name
    And Update Student CSV ['User Name'] Column Value = Provided User Name
    And Update Student CSV ['Username'] Column Value = Provided UserName
    And Update Student CSV ['User First Name'] Column Value = Provided User First Name
    And Update Student CSV ['User Last Name'] Column Value = Provided User Last Name
    And Update Student CSV ['Email Address'] Column Value = Updated User Email Address
    And Update Student CSV ['City'] Column Value = Provided City
    And Update Student CSV ['Country'] Column Value = Provided Country
    And Update Student CSV ['Time Zone'] Column Value = Provided Time Zone
    And Update Student CSV ['Description'] Column Value = Provided Description
    And Update Student CSV ['Institution'] Column Value = Provided Institution
    And Update Student CSV ['Phone Number'] Column Value = Provided Phone Number
    And Update Student CSV ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Update Student CSV ['Address'] Column Value = Provided Address
    And Update Student CSV ['Data Source'] Column Value = 'Moodle'
    Then An Entity for Update Student should get generated and sent to Tableau.
    And Update Student Tableau ['User Display Name'] Column Value = Provided Student Name
    And Update Student Tableau ['User Name'] Column Value = Provided User Name
    And Update Student Tableau ['Username'] Column Value = Provided UserName
    And Update Student Tableau ['User First Name'] Column Value = Provided User First Name
    And Update Student Tableau ['User Last Name'] Column Value = Provided User Last Name
    And Update Student Tableau ['Email Address'] Column Value = Updated User Email Address
    And Update Student Tableau ['City'] Column Value = Provided City
    And Update Student Tableau ['Country'] Column Value = Provided Country
    And Update Student Tableau ['Time Zone'] Column Value = Provided Time Zone
    And Update Student Tableau ['Description'] Column Value = Provided Description
    And Update Student Tableau ['Institution'] Column Value = Provided Institution
    And Update Student Tableau ['Phone Number'] Column Value = Provided Phone Number
    And Update Student Tableau ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Update Student Tableau ['Address'] Column Value = Provided Address
    And Update Student Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC 5294 Create Instructor as Admin
    Given CSV Record Counts before Sending User Entity
    Given Tableau Record Counts before Sending User Entity
    Given Create a new instructor in Moodle
    When Instructor should be successfully created in Moodle
    Then Create user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Instructor Value
    And ['entity'].['extensions'].['email'] = Provided Instructor Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Instructor'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'
    Then An Entity for Create Instructor should get generated and sent to CSV.
    And Create Instructor CSV ['User Display Name'] Column Value = Provided Instructor Name
    And Create Instructor CSV ['User Name'] Column Value = Provided User Name
    And Create Instructor CSV ['Username'] Column Value = Provided UserName
    And Create Instructor CSV ['User First Name'] Column Value = Provided User First Name
    And Create Instructor CSV ['User Last Name'] Column Value = Provided User Last Name
    And Create Instructor CSV ['Email Address'] Column Value = Provided User Email Address
    And Create Instructor CSV ['City'] Column Value = Provided City
    And Create Instructor CSV ['Country'] Column Value = Provided Country
    And Create Instructor CSV ['Time Zone'] Column Value = Provided Time Zone
    And Create Instructor CSV ['Description'] Column Value = Provided Description
    And Create Instructor CSV ['Institution'] Column Value = Provided Institution
    And Create Instructor CSV ['Phone Number'] Column Value = Provided Phone Number
    And Create Instructor CSV ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Create Instructor CSV ['Address'] Column Value = Provided Address
    And Create Instructor CSV ['Data Source'] Column Value = 'Moodle'
    Then An Entity for Create Instructor should get generated and sent to Tableau.
    And Create Instructor Tableau ['User Display Name'] Column Value = Provided Instructor Name
    And Create Instructor Tableau ['User Name'] Column Value = Provided User Name
    And Create Instructor Tableau ['Username'] Column Value = Provided UserName
    And Create Instructor Tableau ['User First Name'] Column Value = Provided User First Name
    And Create Instructor Tableau ['User Last Name'] Column Value = Provided User Last Name
    And Create Instructor Tableau ['Email Address'] Column Value = Provided User Email Address
    And Create Instructor Tableau ['City'] Column Value = Provided City
    And Create Instructor Tableau ['Country'] Column Value = Provided Country
    And Create Instructor Tableau ['Time Zone'] Column Value = Provided Time Zone
    And Create Instructor Tableau ['Description'] Column Value = Provided Description
    And Create Instructor Tableau ['Institution'] Column Value = Provided Institution
    And Create Instructor Tableau ['Phone Number'] Column Value = Provided Phone Number
    And Create Instructor Tableau ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Create Instructor Tableau ['Address'] Column Value = Provided Address
    And Create Instructor Tableau ['Data Source'] Column Value = 'Moodle'

  @EndToEndTest
  Scenario: TC 5295 Update Instructor as Admin
    Given CSV Record Counts before Sending User Entity
    Given Tableau Record Counts before Sending User Entity
    Given Update an existing instructor in Moodle
    When Instructor should be successfully updated in Moodle
    Then Update user event should get successfully sent to the Entity Raw Index
    And The event should have ['entity.@context'] value as ['http://purl.imsglobal.org/ctx/caliper/v1/Context']
    And The event should have ['entity.@type'] value as ['http://purl.imsglobal.org/caliper/v1/lis/Person']
    And ['entity'].['extensions'].['userName'] = Provided Instructor Value
    And Update ['entity'].['extensions'].['email'] = Provided Instructor Value
    And ['entity'].['extensions'].['city'] = Provided Value
    And ['entity'].['extensions'].['country'] = Provided Value
    And ['entity'].['extensions'].['timeZone'] = Provided Value
    And ['entity'].['extensions'].['description'] = Provided Value
    And ['entity'].['extensions'].['institution'] = 'Instructor'
    And ['entity'].['extensions'].['department'] = Provided Value
    And ['entity'].['extensions'].['phone'] = Provided Value
    And ['entity'].['extensions'].['mobilePhone'] = Provided Value
    And ['entity'].['extensions'].['address'] = Provided Value
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And ['entity'].['extensions'].['moduleType'] = 'user'
    Then An Entity for Update Instructor should get generated and sent to CSV.
    And Update Instructor CSV ['User Display Name'] Column Value = Provided Instructor Name
    And Update Instructor CSV ['User Name'] Column Value = Provided User Name
    And Update Instructor CSV ['Username'] Column Value = Provided UserName
    And Update Instructor CSV ['User First Name'] Column Value = Provided User First Name
    And Update Instructor CSV ['User Last Name'] Column Value = Provided User Last Name
    And Update Instructor CSV ['Email Address'] Column Value = Updated User Email Address
    And Update Instructor CSV ['City'] Column Value = Provided City
    And Update Instructor CSV ['Country'] Column Value = Provided Country
    And Update Instructor CSV ['Time Zone'] Column Value = Provided Time Zone
    And Update Instructor CSV ['Description'] Column Value = Provided Description
    And Update Instructor CSV ['Institution'] Column Value = Provided Institution
    And Update Instructor CSV ['Phone Number'] Column Value = Provided Phone Number
    And Update Instructor CSV ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Update Instructor CSV ['Address'] Column Value = Provided Address
    And Update Instructor CSV ['Data Source'] Column Value = 'Moodle'
    Then An Entity for Update Instructor should get generated and sent to Tableau.
    And Update Instructor Tableau ['User Display Name'] Column Value = Provided Instructor Name
    And Update Instructor Tableau ['User Name'] Column Value = Provided User Name
    And Update Instructor Tableau ['Username'] Column Value = Provided UserName
    And Update Instructor Tableau ['User First Name'] Column Value = Provided User First Name
    And Update Instructor Tableau ['User Last Name'] Column Value = Provided User Last Name
    And Update Instructor Tableau ['Email Address'] Column Value = Updated User Email Address
    And Update Instructor Tableau ['City'] Column Value = Provided City
    And Update Instructor Tableau ['Country'] Column Value = Provided Country
    And Update Instructor Tableau ['Time Zone'] Column Value = Provided Time Zone
    And Update Instructor Tableau ['Description'] Column Value = Provided Description
    And Update Instructor Tableau ['Institution'] Column Value = Provided Institution
    And Update Instructor Tableau ['Phone Number'] Column Value = Provided Phone Number
    And Update Instructor Tableau ['Mobile Phone Number'] Column Value = Provided Mobile Number
    And Update Instructor Tableau ['Address'] Column Value = Provided Address
    And Update Instructor Tableau ['Data Source'] Column Value = 'Moodle'
