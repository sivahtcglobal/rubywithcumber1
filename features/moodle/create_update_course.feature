@nightly @moodle @smoketest
Feature: Moodle.User Story 5171 and 5172 - Create and Update A Course

  @IntegrationTest
  Scenario Outline: TC 5484 Create New Course With Visibility Show and Hide
    Given Create a Course With Visibility <visible>
    When The Course Got successfully created
    Then A Course Entity should get generated and sent to our Raw Entity Index.
    And The [entity][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][@type] =  'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The [entity][name] = Provided Course Full Name
    And The [entity][extensions][shortName] = Provided Course Short Name
    And The [entity][extensions][visible] = <result>
    And The #[entity][extensions][startDate] = Should Be Porvided Start Date
    And The #[entity][extensions][format] = Provided Format
    And The #[entity][extensions][layout] = Provided Course Layout
    And The #[entity][extensions][showGradeBook] = Provided Gradebook Instruction
    And The #[entity][extensions][showActivityReports] = Provided Activity Reports Instruction
    And The [entity][extensions][completionTracking] = false
    And The #[entity][extensions][groupMode] = Provided Grouping Mode
    And ['entity'].['extensions'].['tags'].[0] = Provided Course Tag
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'course'
    And The [entity][courseNumber] = Provided Course Number
    And The [entity][subOrganizationOf][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][subOrganizationOf]["@type] = 'http://purl.imsglobal.org/caliper/v1/lis/Group'
    Examples:
      |visible|result|
      |Show   |true |
      |Hide   |false |

  @IntegrationTest
  Scenario: TC 5486 Update an Existing Course
    Given Update the a Created Course
    When The Course Got successfully Updated
    Then A Course Entity should get generated and sent to our Raw Entity Index.
    And The [entity][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][@type] =  'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The [entity][name] = Provided Updated Course Full Name
    And The [entity][extensions][shortName] = Provided Updated Course Short Name
    And The [entity][extensions][visible] =Updated Visiblelity
    And The #[entity][extensions][startDate] =Updated Start Date
    And Update the #[entity][extensions][layout] = Provided Course Layout
    And Update the #[entity][extensions][showGradeBook] = Provided Gradebook Instruction
    And Update the #[entity][extensions][showActivityReports] = Provided Activity Reports Instruction
    And The [entity][extensions][completionTracking] = true
    And Update the #[entity][extensions][groupMode] = Provided Grouping Mode
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'course'
    And The [entity][courseNumber] = Provided Course Number
    And The [entity][subOrganizationOf][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][subOrganizationOf]["@type] = 'http://purl.imsglobal.org/caliper/v1/lis/Group'

  @EndToEndTest
  Scenario Outline: TC 5484 Create New Course With Visibility Show and Hide
    Given CSV Record Counts before Sending Course Entity
    Given Tableau Record Counts before Sending Course Entity
    Given Create a Course With Visibility <visible>
    When The Course Got successfully created
    Then A Course Entity should get generated and sent to our Raw Entity Index.
    And The [entity][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][@type] =  'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The [entity][name] = Provided Course Full Name
    And The [entity][extensions][shortName] = Provided Course Short Name
    And The [entity][extensions][visible] = <result>
    And The #[entity][extensions][startDate] = Should Be Porvided Start Date
    And The #[entity][extensions][format] = Provided Format
    And The #[entity][extensions][layout] = Provided Course Layout
    And The #[entity][extensions][showGradeBook] = Provided Gradebook Instruction
    And The #[entity][extensions][showActivityReports] = Provided Activity Reports Instruction
    And The [entity][extensions][completionTracking] = false
    And The #[entity][extensions][groupMode] = Provided Grouping Mode
    And ['entity'].['extensions'].['tags'].[0] = Provided Course Tag
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'course'
    And The [entity][courseNumber] = Provided Course Number
    And The [entity][subOrganizationOf][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][subOrganizationOf]["@type] = 'http://purl.imsglobal.org/caliper/v1/lis/Group'
    Then An Entity for Create Course should get generated and sent to CSV.
    And Create Course CSV ['Course Name'] Column Value = Provided Course Name
    And Create Course CSV ['Course Short Name'] Column Value = Provided Course Short Name
    And Create Course CSV ['Course ID'] Column Value = Generated Course ID
    And Create Course CSV ['Course Number'] Column Value = Provided Course Number
    And Create Course CSV ['Course Category ID'] Column Value = Course Category ID
    And Create Course CSV ['Course Category Name'] Column Value = Provided Course Category Name
    And Create Course CSV ['Course Format'] Column Value = Provided Course Format
    And Create Course CSV ['Course Layout'] Column Value = Provided Course Layout
    And Create Course CSV ['Course Visible'] Column Value = Provided Course Visible <result>
    And Create Course CSV ['Course Start Date'] Column Value = Provided Course Start Date
    And Create Course CSV ['Course Completion Tracking'] Column Value = Provided Course Completion Tracking
    And Create Course CSV ['Show Grade Book'] Column Value = Provided Grade Book
    And Create Course CSV ['Show Activity Reports'] Column Value = Provided Activity Reports
    And Create Course CSV ['Group Mode'] Column Value = Provided Group Mode
    And Create Course CSV ['Tags'] Column Value = Provided Tags
    And Create Course CSV ['Data Source'] Column Value = 'Moodle'
    Then An Entity for Create Course should get generated and sent to Tableau.
    And Create Course Tableau ['Course Name'] Column Value = Provided Course Name
    And Create Course Tableau ['Course Short Name'] Column Value = Provided Course Short Name
    And Create Course Tableau ['Course ID'] Column Value = Generated Course ID
    And Create Course Tableau ['Course Number'] Column Value = Provided Course Number
    And Create Course Tableau ['Course Category ID'] Column Value = Course Category ID
    And Create Course Tableau ['Course Category Name'] Column Value = Provided Course Category Name
    And Create Course Tableau ['Course Format'] Column Value = Provided Course Format
    And Create Course Tableau ['Course Layout'] Column Value = Provided Course Layout
    And Create Course Tableau ['Course Visible'] Column Value = Provided Course Visible <result>
    And Create Course Tableau ['Course Start Date'] Column Value = Provided Course Start Date
    And Create Course Tableau ['Course Completion Tracking'] Column Value = Provided Course Completion Tracking
    And Create Course Tableau ['Show Grade Book'] Column Value = Provided Grade Book
    And Create Course Tableau ['Show Activity Reports'] Column Value = Provided Activity Reports
    And Create Course Tableau ['Group Mode'] Column Value = Provided Group Mode
    And Create Course Tableau ['Tags'] Column Value = Provided Tags
    And Create Course Tableau ['Data Source'] Column Value = 'Moodle'
    Examples:
      |visible|result|
      |Show   |true |
      |Hide   |false |

  @EndToEndTest
  Scenario: TC 5486 Update an Existing Course
    Given CSV Record Counts before Sending Course Entity
    Given Tableau Record Counts before Sending Course Entity
    Given Update the a Created Course
    When The Course Got successfully Updated
    Then A Course Entity should get generated and sent to our Raw Entity Index.
    And The [entity][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][@type] =  'http://purl.imsglobal.org/caliper/v1/lis/CourseOffering'
    And The [entity][name] = Provided Updated Course Full Name
    And The [entity][extensions][shortName] = Provided Updated Course Short Name
    And The [entity][extensions][visible] =Updated Visiblelity
    And The #[entity][extensions][startDate] =Updated Start Date
    And Update the #[entity][extensions][layout] = Provided Course Layout
    And Update the #[entity][extensions][showGradeBook] = Provided Gradebook Instruction
    And Update the #[entity][extensions][showActivityReports] = Provided Activity Reports Instruction
    And The [entity][extensions][completionTracking] = true
    And Update the #[entity][extensions][groupMode] = Provided Grouping Mode
    And ['entity'].['extensions'].['edApp'].['@type'] = 'http://purl.imsglobal.org/caliper/v1/SoftwareApplication'
    And ['entity'].['extensions'].['edApp'].['name'] = 'IntellifyLearning'
    And The ['entity'].['extensions'].['moduleType'] = 'course'
    And The [entity][courseNumber] = Provided Course Number
    And The [entity][subOrganizationOf][@context] = 'http://purl.imsglobal.org/ctx/caliper/v1/Context'
    And The [entity][subOrganizationOf]["@type] = 'http://purl.imsglobal.org/caliper/v1/lis/Group'
    Then An Entity for Update Course should get generated and sent to CSV.
    And Update Course CSV ['Course Name'] Column Value = Updated Course Name
    And Update Course CSV ['Course Short Name'] Column Value = Updated Course Short Name
    And Update Course CSV ['Course ID'] Column Value = Generated Course ID
    And Update Course CSV ['Course Number'] Column Value = Provided Course Number
    And Update Course CSV ['Course Category ID'] Column Value = Course Category ID
    And Update Course CSV ['Course Category Name'] Column Value = Provided Course Category Name
    And Update Course CSV ['Course Format'] Column Value = Provided Course Format
    And Update Course CSV ['Course Layout'] Column Value = Updated Course Layout
    And Update Course CSV ['Course Visible'] Column Value = Updated Course Visible
    And Update Course CSV ['Course Start Date'] Column Value = Updated Course Start Date
    And Update Course CSV ['Course Completion Tracking'] Column Value = Updated Course Completion Tracking
    And Update Course CSV ['Show Grade Book'] Column Value = Updated Grade Book
    And Update Course CSV ['Show Activity Reports'] Column Value = Updated Activity Reports
    And Update Course CSV ['Group Mode'] Column Value = Updated Group Mode
    And Update Course CSV ['Tags'] Column Value = Provided Tags
    And Update Course CSV ['Data Source'] Column Value = 'Moodle'
    Then An Entity for Update Course should get generated and sent to Tableau.
    And Update Course Tableau ['Course Name'] Column Value = Updated Course Name
    And Update Course Tableau ['Course Short Name'] Column Value = Updated Course Short Name
    And Update Course Tableau ['Course ID'] Column Value = Generated Course ID
    And Update Course Tableau ['Course Number'] Column Value = Provided Course Number
    And Update Course Tableau ['Course Category ID'] Column Value = Course Category ID
    And Update Course Tableau ['Course Category Name'] Column Value = Provided Course Category Name
    And Update Course Tableau ['Course Format'] Column Value = Provided Course Format
    And Update Course Tableau ['Course Layout'] Column Value = Updated Course Layout
    And Update Course Tableau ['Course Visible'] Column Value = Updated Course Visible
    And Update Course Tableau ['Course Start Date'] Column Value = Updated Course Start Date
    And Update Course Tableau ['Course Completion Tracking'] Column Value = Updated Course Completion Tracking
    And Update Course Tableau ['Show Grade Book'] Column Value = Updated Grade Book
    And Update Course Tableau ['Show Activity Reports'] Column Value = Updated Activity Reports
    And Update Course Tableau ['Group Mode'] Column Value = Updated Group Mode
    And Update Course Tableau ['Tags'] Column Value = Provided Tags
    And Update Course Tableau ['Data Source'] Column Value = 'Moodle'
