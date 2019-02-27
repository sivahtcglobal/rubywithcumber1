class BasePage < PageFactory
  class << self
    #HMH Report
    configatron.hostname = 'hmh2.intellifylearning.com'

    #Slack Integration Token
    configatron.slackToken = 'xoxb-297858357012-IPxzZ6heBJIamonIzWJUjnv9'

    #Workbench Admin user Login Details 'intellifyautomation.intellifyqa.net'
    configatron.workbenchAdminUsername = 'auto_orgadmin'
    configatron.workbenchAdminPassword = 'fooBar1@34'

    #Workbench designer user Login Details 'intellifyautomation.intellifyqa.net'
    configatron.workbenchDesignerUsername = 'auto_orgdesigner'
    configatron.workbenchDesignerPassword = 'fooBar1@34'

    #Moodle Watit Time for the event to flow through the ES
    configatron.eventWaitTime = 10

    #Moodle Workbench Login Details
    configatron.tokenuser = "AutoDesigner2"
    configatron.tokenpass = "fooBar1@34"

    #Site Admin Login Details
    configatron.autoAdminUsername = 'auto_siteadmin'
    configatron.autoAdminPassword = 'Autositeadmin@1'

    #Student Login Details
    configatron.autoStuUsername = 'auto_student'
    configatron.autoStuPassword = 'fooBar1@34'

    #Teacher Login Details
    configatron.autoTechUsername = 'auto_teacher'
    configatron.autoTechPassword = 'fooBar1@34'

    #Stream Delay Time
    configatron.streamDelayTime = 30000
    #osrt
    configatron.osrt_host = "ccc-dev.intellify.io"
    configatron.osrt_user = "osrtautouser"
    configatron.osrt_pass = "Osrtautouser@1"
    configatron.osrt_intellistream = "data-eventdata-59b2edebbba2993531bdc644"
    configatron.canvas_osrt_user = "Autouser1"
    configatron.canvas_osrt_pass = "autouser@1"

    #dev,staging,prod stack
    configatron.essentialsusername = ENV['ESSENTIAL_ADMIN_USER']
    configatron.essentialspassword = ENV['ESSENTIAL_ADMIN_PASSWORD']
    configatron.essLDAPusername = ENV['LDAP_USER']
    configatron.essLDAPpassword = ENV['LDAP_PASSWORD']
    configatron.moodleStudentActivityReport = 'Moodle_Student_Activity_Table'
    configatron.dateAndTimeFieldStudentActivityReport = 'Date and Time'
    configatron.dateAndTimeFieldStudentActivityReportTableau = 'DateandTime'
    configatron.moodleUserProfileReport = 'Moodle_User_Table'
    configatron.dateModifiedFieldUserProfileReport = 'Date Modified'
    configatron.dateModifiedFieldUserProfileReportTableau = 'DateModified'
    configatron.moodleCourseReport = 'Moodle_Course_Table'
    configatron.dateModifiedFieldCourseReport = 'Date Modified'
    configatron.dateModifiedFieldCourseReportTableau = 'DateModified'
    configatron.moodleQuizSubmissionReport = 'Moodle_Quiz_Submission_Table'
    configatron.dateAndTimeFieldQuizSubmissionReport = 'Date and Time'
    configatron.dateAndTimeFieldQuizSubmissionReportTableau = 'DateandTime'
    configatron.moodleEnrollmentReport = 'Moodle_Student_Enrollments_Table'
    configatron.userIdFieldEnrollmentReport = 'User ID'
    configatron.userIdFieldEnrollmentReportTableau = 'UserID'

    case ENV['ENVIRONMENT']
      when 'intellifyautomation.intellifyqa.net' #Master-Staging Environment
        configatron.hostname1 = 'intellifyautomation.intellifyqa.net'
        configatron.workbench = 'intellifyautomation.intellifyqa.net'
        @workbenchHostname = configatron.workbench
        configatron.workbenchURL = "https://#{@workbenchHostname}"

        #Shared Initial Variables
        configatron.environment = 'Master-Staging'
        configatron.collectorVersion = 'NEW'
        configatron.apiKey = "fBOkV-K7TlGsAlOu1uBUiw"
        configatron.sensorId = "com.staging.auto1"
        configatron.orgname = "0-Automation-DoNotDelete"
        configatron.orgId = "59bba53b3324874275e1aa27"
        configatron.dataCollectionName = "0-Auto-DoNotDelete-DataCollection"
        configatron.dataCollectionUUID = "59bba5c93324874275e1aa33"
        configatron.datasourceName = "DoNotDelete Automation1 Source"
        configatron.datasourceUUID = "5a608a19eca9a259af358535"
        configatron.entityIndex = "data-staging-automation1-entity"
        configatron.eventIndex = "data-staging-automation1-event"
        configatron.computestreamUUID = "5a608afceca9a259af358537"
        configatron.computestreamIndex = "data-donotdelete-runscope-steadytests1"
        configatron.designerUsername = "auto_orgdesigner"
        configatron.designerPassword = "fooBar1@34"
        configatron.adminUsername = "auto_orgadmin"
        configatron.adminPassword = "fooBar1@34"

      when 'moodleautomation.intellifyqa.net' #Master-Staging Environment
        configatron.hostname1 = 'moodleautomation.intellifyqa.net'
        configatron.environment = 'Master-Staging'
        configatron.moodleURL = "http://moodleserver.staging.master.us-west-2.prod.aws.intellify.io"
        configatron.moodleWorkbench = 'moodleautomation.intellifyqa.net'
        @hostnameMoodlepoc = configatron.moodleWorkbench
        configatron.essentialsURL = "https://#{@hostnameMoodlepoc}/login/#"
        configatron.workbenchURL  = "https://#{@hostnameMoodlepoc}/wb/index.html#/login"
        configatron.apiTokenURL = "https://#{@hostnameMoodlepoc}/user/apiToken"

      when 'kirkstest3.intellifyqa.net' #Master-Staging Environment
        configatron.hostname1 = 'kirkstest3.intellifyqa.net'
        configatron.environment = 'Master-Staging'
        configatron.moodleURL = "http://moodleserver.kirk.master.us-west-2.prod.aws.intellify.io"
        configatron.moodleWorkbench = 'kirkstest3.intellifyqa.net'
        @hostnameMoodlepoc = configatron.moodleWorkbench
        configatron.essentialsURL = "https://#{@hostnameMoodlepoc}/login/#"
        configatron.workbenchURL  = "https://#{@hostnameMoodlepoc}/wb/index.html#/login"
        configatron.apiTokenURL = "https://#{@hostnameMoodlepoc}/user/apiToken"

      when 'automatedtest.intellifyqa.net' #Master-Staging Environment
        configatron.hostname1 = 'automatedtest.intellifyqa.net'
        configatron.environment = 'Master-Staging'
        configatron.moodleURL = "http://moodleserver.staging.master.us-west-2.prod.aws.intellify.io"
        configatron.moodleWorkbench = 'automatedtest.intellifyqa.net'
        configatron.moodleEventStream = 'data-test7-moodle-event-eventdata-5a60c6c9eca9a259af35856e'
        configatron.moodleEntityStream = 'data-test7-moodle-entity-entitydata-5a60c6c9eca9a259af35856e'
        configatron.hostname = 'automatedtest.intellifyqa.net'
        configatron.apikey = '41nFXuhlRMiU3hrcsEhdbA'
        configatron.sensorid = 'com.test7.moodle'
        @hostnameMoodlepoc = configatron.moodleWorkbench
        configatron.workbenchURL  = "https://#{@hostnameMoodlepoc}/wb/index.html#/login"
        configatron.apiTokenURL = "https://#{@hostnameMoodlepoc}/user/apiToken"

      when 'prodautomatedtest.intellify.io' #Master-PROD Environment
        configatron.hostname1 = 'prodautomatedtest.intellify.io'
        configatron.moodleURL = "http://moodleserver.prod.master.us-west-2.prod.aws.intellify.io"
        configatron.moodleWorkbench = 'prodautomatedtest.intellify.io'
        configatron.moodleEventStream = 'data-test1-moodle-event-eventdata-5a4e9942d01f9c37ad87b218'
        configatron.moodleEntityStream = 'data-test1-moodle-entity-entitydata-5a4e9942d01f9c37ad87b218'
        configatron.hostname = 'prodautomatedtest.intellify.io'
        configatron.apikey = 'i7xy4gn0Q2a30rpUK4Hjjg'
        configatron.sensorid = 'com.test1.moodle'
        @hostnameMoodlepoc = configatron.moodleWorkbench
        configatron.workbenchURL  = "https://#{@hostnameMoodlepoc}/wb/index.html#/login"
        configatron.apiTokenURL = "https://#{@hostnameMoodlepoc}/user/apiToken"

        #Shared Initial Variables
        configatron.environment = 'Master-PROD'
        configatron.collectorVersion = 'NEW'
        configatron.workbench = 'prodautomatedtest.intellify.io'
        configatron.apiKey = "z6ymoeYAQJKnQzWAHrp1sw"
        configatron.sensorId = "com.prod.stack.steadystate.test"
        configatron.orgname = "0-GI-RS-Automation-DoNotDelete"
        configatron.orgId = "5941280ab695fb6896da0231"
        configatron.dataCollectionName = "DoNotDelete Automation Collection"
        configatron.dataCollectionUUID = "59438af4f695b505c5fe6fba"
        configatron.datasourceName = "DoNotDelete Automation Source"
        configatron.datasourceUUID = "59438b521b557f25248d3ebc"
        configatron.entityIndex = "data-runscope-steadystate-prod-entity"
        configatron.eventIndex = "data-runscope-steadystate-prod-event"
        configatron.computestreamUUID = "5a1d5b39db0c1c4ef42c7ab5"
        configatron.computestreamIndex = "data-donotdelete-runscope-steadystate-test"
        configatron.designerUsername = "auto_orgdesigner"
        configatron.designerPassword = "Auto@orgadmin1"
        configatron.adminUsername = "auto_orgadmin"
        configatron.adminPassword = "Auto@orgadmin1"

      when 'qaprodmoodle.intellify.io' #Master-PROD Environment
        configatron.hostname1 = 'qaprodmoodle.intellify.io'
        configatron.environment = 'Master-PROD'
        configatron.moodleURL = "http://moodleserver.prod.master.us-west-2.prod.aws.intellify.io"
        configatron.moodleWorkbench = 'qaprodmoodle.intellify.io'
        @hostnameMoodlepoc = configatron.moodleWorkbench
        configatron.essentialsURL = "https://#{@hostnameMoodlepoc}/essentials/#/login"
        configatron.workbenchURL  = "https://#{@hostnameMoodlepoc}/wb/index.html#/login"
        configatron.apiTokenURL = "https://#{@hostnameMoodlepoc}/user/apiToken"

      when 'intellifyqa-automation1.intellifydev.net' #Master-DEV Environment
        configatron.hostname1 = 'intellifyqa-automation1.intellifydev.net'
        configatron.moodleURL = "http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io"
        configatron.moodleWorkbench = 'intellifyqa-automation1.intellifydev.net'
        configatron.moodleEventStream = 'data-test1-moodle-event-eventdata-5a5f6e81a03649521a365cb7'
        configatron.moodleEntityStream = 'data-test1-moodle-entity-entitydata-5a5f6e81a03649521a365cb7'
        configatron.hostname = 'intellifyqa-automation1.intellifydev.net'
        configatron.apikey = 'lYGjpOUcSL2w3adpkrj0AA'
        configatron.sensorid = 'com.test1.moodle'
        @hostnameMoodlepoc = configatron.moodleWorkbench
        configatron.workbenchURL  = "https://#{@hostnameMoodlepoc}/wb/index.html#/login"
        configatron.apiTokenURL = "https://#{@hostnameMoodlepoc}/user/apiToken"

        #Shared Initial Variables
        configatron.environment = 'Master-DEV'
        configatron.collectorVersion = 'NEW'
        configatron.workbench = 'intellifyqa-automation1.intellifydev.net'
        configatron.apiKey = 'cOHDabsgQKaFGYADwoR2GA'
        configatron.sensorId = 'com.dev.stack.smoketest'
        configatron.orgname = '0-GI-RS-Automation-DoNotDelete'
        configatron.orgId = '59385ebe27343f080727abf6'
        configatron.dataCollectionName = '0-Auto-DoNotDelete-DataCollection'
        configatron.dataCollectionUUID = '5979a71c46593644e7db63db'
        configatron.datasourceName = 'DoNotDelete Automation Smoke Test Source'
        configatron.datasourceUUID = '5979a75546593644e7db63df'
        configatron.entityIndex = 'data-runscope-smoketest-entity'
        configatron.eventIndex = 'data-runscope-smoketest-event'
        configatron.computestreamUUID = '5979a82d46593644e7db63e1'
        configatron.computestreamIndex = 'data-donotdelete-runscope-steadytests'
        configatron.designerUsername = 'auto_orgdesigner'
        configatron.designerPassword = 'Auto@orgadmin1'
        configatron.adminUsername = 'auto_orgadmin'
        configatron.adminPassword = 'Auto@orgadmin1'

      when 'hmh2.intellifylearning.com' #HMH2 Environment
        configatron.hostname1 = 'hmh2.intellifylearning.com'
        #Shared Initial Variables
        configatron.environment = 'HMH2'
        configatron.collectorVersion = 'OLD'
        configatron.workbench = 'hmh2.intellifylearning.com'
        configatron.apiKey = 'PR0q9WfkR1a2F2a6owNsJw'
        configatron.sensorId = 'com.auto.hmh.dev2'
        configatron.orgname = '0-Runscope-Automation-DoNotDelete'
        configatron.orgId = '5991781cff7b276923032fc4'
        configatron.dataCollectionName = 'DoNotDelete Automation Support DC'
        configatron.dataCollectionUUID = '591dac6e6d3896014c48d9e0'
        configatron.datasourceName = '0-Auto-DoNotDelete-DataSource'
        configatron.datasourceUUID = '594a491a4a37053d09499df9'
        configatron.entityIndex = 'data-auto-donotdelete-entity'
        configatron.eventIndex = 'data-auto-donotdelete-event'
        configatron.computestreamUUID = '594a498b6d3896014c48f0a1'
        configatron.computestreamIndex = 'auto-donotdelete-compute-steadystatetest'
        configatron.designerUsername = 'auto_orgdesigner'
        configatron.designerPassword = 'fooBar1@34'
        configatron.adminUsername = 'autorsadmin1'
        configatron.adminPassword = 'Auto@orgadmin1'

      when 'hmhprod2.intellifylearning.com' #HMHPROD2 Environment
        configatron.hostname1 = 'hmhprod2.intellifylearning.com'
        #Shared Initial Variables
        configatron.environment = 'HMHPROD2'
        configatron.collectorVersion = 'OLD'
        configatron.workbench = 'hmhprod2.intellifylearning.com'
        configatron.apiKey = 'Ku53JZQLT423E-woGLYjZA'
        configatron.sensorId = 'com.auto.hmh.prod2'
        configatron.orgname = '0-GI-RS-Automation-DoNotDelete'
        configatron.orgId = '57f79abc619aca14f7c102c0'
        configatron.dataCollectionName = 'DoNotDelete Automation Support DC'
        configatron.dataCollectionUUID = '591e80bb9fe1c23b55d75b70'
        configatron.datasourceName = '0-Auto-DoNotDelete-DataSource'
        configatron.datasourceUUID = '594a5336bbd3ae3b1f06b1a1'
        configatron.entityIndex = 'data-auto-donotdelete-entity'
        configatron.eventIndex = 'data-auto-donotdelete-event'
        configatron.computestreamUUID = '598207ccc903555235300716'
        configatron.computestreamIndex = 'data-runscope-steadystate-ds1-ds2'
        configatron.designerUsername = 'auto_orgdesigner'
        configatron.designerPassword = 'fooBar1@34'
        configatron.adminUsername = 'auto_orgadmin'
        configatron.adminPassword = 'Auto@orgadmin1'

      when 'k12qa.intellifylearning.com' #K12QA Environment
        configatron.hostname1 = 'k12qa.intellifylearning.com'
        #Shared Initial Variables
        configatron.environment = 'K12QA'
        configatron.collectorVersion = 'OLD'
        configatron.workbench = 'k12qa.intellifylearning.com'
        configatron.apiKey = 'nY98GotoTzS1sjt1M32YtA'
        configatron.sensorId = 'com.auto.k12.qa'
        configatron.orgname = '0-GI-RS-Automation-DoNotDelete'
        configatron.orgId = '58a2c9b4aa30474c2a8e8c7d'
        configatron.dataCollectionName = 'DoNotDelete Automation Support DC'
        configatron.dataCollectionUUID = '591e7a8237e6ee245a1980b6'
        configatron.datasourceName = '0-Auto-DoNotDelete-DataSource'
        configatron.datasourceUUID = '5991b330406a0e450104ba6f'
        configatron.entityIndex = 'data-auto-donotdelete-entity'
        configatron.eventIndex = 'data-auto-donotdelete-event'
        configatron.computestreamUUID = '59941df4fe140f334d153887'
        configatron.computestreamIndex = 'data-donotdelete-runscope-steadytests'
        configatron.designerUsername = 'auto_orgdesigner'
        configatron.designerPassword = 'Auto@orgadmin1'
        configatron.adminUsername = 'autors_orgadmin'
        configatron.adminPassword = 'Auto@orgadmin1'

      when 'k12prod1.intellifylearning.com' #K12PROD1 Environment
        configatron.hostname1 = 'k12prod1.intellifylearning.com'
        #Shared Initial Variables
        configatron.environment = 'K12PROD1'
        configatron.collectorVersion = 'OLD'
        configatron.workbench = 'k12prod1.intellifylearning.com'
        configatron.apiKey = 't9L-0hXdSGiJqKrDsxbLFw'
        configatron.sensorId = 'com.auto.k12.qa'
        configatron.orgname = '0-GI-RS-Automation-DoNotDelete'
        configatron.orgId = '58047326a64ffc1f129b0866'
        configatron.dataCollectionName = 'DoNotDelete Automation Support DC '
        configatron.dataCollectionUUID = '591e7e6f55d413321ebb7e60'
        configatron.datasourceName = '0-Auto-DoNotDelete-DataSource'
        configatron.datasourceUUID = '59b6655a98b7bb4b737cf341'
        configatron.entityIndex = 'data-auto-donotdelete-entity'
        configatron.eventIndex = 'data-auto-donotdelete-event'
        configatron.computestreamUUID = '59b6662598b7bb4b737cf342'
        configatron.computestreamIndex = 'data-donotdelete-runscope-steadytests'
        configatron.designerUsername = 'auto_orgdesigner'
        configatron.designerPassword = 'Auto@orgadmin1'
        configatron.adminUsername = 'autors_orgadmin'
        configatron.adminPassword = 'Auto@orgadmin1'

      else
        configatron.hostname1 = 'moodlestatic.intellifydev.net'
        configatron.environment = 'Master-DEV'
        configatron.moodleURL = "http://moodleserver.dev.master.us-west-2.prod.aws.intellify.io"
        configatron.moodleWorkbench = 'moodlestatic.intellifydev.net'
        @hostnameMoodlepoc = configatron.moodleWorkbench
        configatron.essentialsURL = "https://#{@hostnameMoodlepoc}/login/#"
        configatron.workbenchURL  = "https://#{@hostnameMoodlepoc}/wb/index.html#/login"
        configatron.apiTokenURL = "https://#{@hostnameMoodlepoc}/user/apiToken"
    end

    #HMH Reports Validation Initial Set of Variables / Custom Parameters
    configatron.hmhLookupDynamicStream = '56e57292e4b0d23d758d60e6'
    configatron.siteId = 'testIRSite1'
    configatron.studentId = 'Student100'
    configatron.startDate = 1420070400000
    configatron.endDate = 1457519000000

    configatron.sriD3StreamId  = '56e659a1e4b0d76ca0b71718'
    configatron.sriD3siteId = 'h900000031'
    configatron.sriD3classId = 'jgbn81rk2ipatcnlruthvsnv_v8q9qq0'
    configatron.sriD3submissionStart = 1443489947629
    configatron.sriD3submissionEnd = 1463489947629

    configatron.sriD3StreamIdSTD  = '56e65a24e4b0d76ca0b71719'
    configatron.sriD3classIdSTD = 'oic7nalqmamjl8ghs7ctmsfu_v8q9qq0'

    configatron.e3dStreamId  = '570e63bce4b07de1ffe167d3'
    configatron.e3dsiteId = 'h502000001'
    configatron.e3dclassId = 'pd56pj55qu25gj3fct7q1o0f_1cqnue0'
    configatron.e3dsubmissionStart = 1415334400000
    configatron.e3dsubmissionEnd = 1935070400000

    configatron.irStreamId  = '56e57229e4b0d23d758d60cb'
    configatron.irsiteId = 'h502000001'
    configatron.irclassId = 'pd56pj55qu25gj3fct7q1o0f_1cqnue0'
    configatron.irsubmissionStart = 1420070400000
    configatron.irsubmissionEnd = 1497519000000
    configatron.irTopBooks = 5

    configatron.allEnrollment = '1bu96flg6jj9ul1103967vhk_v8q9qq0'
    configatron.allEnrollmentStreamId  = '574e688360b28a06ab9f96c7'

    configatron.allClassRoster = '1bu96flg6jj9ul1103967vhk_v8q9qq0'
    configatron.allClassRosterStreamId  = '57181eeee4b005e68e5e381e'

    configatron.r180ClassZoneCid = 'ofitet0bvrclbupadus5fjnf_1cqnue0'
    configatron.r180ClassZoneStreamId  = '56f55231e4b01e8d935b0329'
    configatron.r180ClassZonesiteId = 'h502000001'
    configatron.r180ClassZonesubmissionStart = 1457798073000
    configatron.r180ClassZonesubmissionEnd = 1958086399000

    configatron.spiClassSumCid = '1bu96flg6jj9ul1103967vhk_v8q9qq0'
    configatron.spiClassSumStreamId  = '56eac636e4b0d76ca0b71764'
    configatron.spiClassSumsiteId = 'h900000031'
    configatron.spiClassSumsubmissionStart = 1457798073000
    configatron.spiClassSumsubmissionEnd = 1458086399000

    configatron.sriClassSumCid = '5g6gtlj2dre6lmk89fl9b5fm_1cqnue0'
    configatron.sriClassSumStreamId  = '56f966bbe4b0d76ca0b71917'
    configatron.sriClassSumsiteId = 'h502000001'
    configatron.sriClassSumsubmissionStart = 1457798073000
    configatron.sriClassSumsubmissionEnd = 1462039301000

    configatron.lkStuAppsCid = 'oic7nalqmamjl8ghs7ctmsfu_v8q9qq0'
    configatron.lkStuAppsStreamId  = '57290f5160b2b454e93cbba8'
    configatron.lkStuAppssiteId = 'h502000001'
    configatron.lkStuAppssubmissionStart = 1457798073000
    configatron.lkStuAppsSumsubmissionEnd = 1459709860000

    configatron.classWSACid = 'qsars0452fse21d90u2d2njj_2cqnue0'
    configatron.classWSAStreamId  = '56e7300ee4b0d76ca0b7175f'
    configatron.classWSAsiteId = 'h502000002'

    configatron.classWSATestidCls = 's_660'
    configatron.classWSACidCls = '2qlp34on59hai37r8m9fankk_1cqnue0'
    configatron.classWSAStreamIdCls  = '56e4d7b9e4b0d23d758d1d73'
    configatron.classWSAsiteIdCls = 'h502000001'
    configatron.classWSAsubmissionStartCls = 1457798073000
    configatron.classWSASumsubmissionEndCls = 1958086399000

    configatron.takenWSAstdid = 'oic7nalqmamjl8ghs7ctmsfu_v8q9qq0'
    configatron.takenWSACidstd = '5ql9nes19lmdjn63k4v036q9_1cqnue0'
    configatron.takenWSAStreamIdstd  = '5719a03de4b005e68e5e3846'
    configatron.takenWSAsiteIdste = 'h502000001'
    configatron.takenWSAsubmissionStartstd = 1457798073000
    configatron.takenWSASumsubmissionEndstd = 1459709860000

    configatron.testWSAtstdid = 's_661'
    configatron.testWSAstdid = 'pofgeogdc5m78gp23uie8ape_1cqnue0'
    configatron.testWSACidstd = 'dd3h8gmblv67pip5u9h9libi_1cqnue0'
    configatron.testWSAStreamIdstd  = '56e6c5ade4b0d76ca0b7175e'
    configatron.testWSAsiteIdste = 'h502000001'
    configatron.testWSAsubmissionStartstd = 1457798073000
    configatron.testWSASumsubmissionEndstd = 1969709860000

    configatron.listWSAtstdid = 's_659'
    configatron.listWSAstdid = 'a8hhj6jlqhm1g6qcf7vk38mb_2cqnue0'
    configatron.listWSACidstd = 'qsars0452fse21d90u2d2njj_2cqnue0'
    configatron.listWSAStreamIdstd  = '56e824cee4b0d76ca0b71760'
    configatron.listWSAsiteIdste = 'h502000002'
    configatron.listWSAsubmissionStartstd = 1457798073000
    configatron.listWSASumsubmissionEndstd = 1459709860000

    configatron.slmsRAWEntity = 'xxx-test-hmh-slms-entities-entitydata-5534f4690cf234f3ddd3525d'
    configatron.classIdR180 = 'knj7mih30teg4813lmc8esc8_1cqnue0'
    configatron.apiKeyR180 = "yScTs-BpQVaSg0PIlDlfzw",
    configatron.sensorIdR180 = "com.scholastic.slms.dev1"
    configatron.slmsSTUGrade = 'xxx-test-slms-students-with-grade'
    configatron.a5b3R180 = 'xxx-test-r180u-synthetic-a5-b3-aggregate-with-student-info'

    configatron.slmsStudents = 'xxx-test-slms-students'
    configatron.slmsClasses = 'xxx-test-slms-classes-in-schools'

    configatron.spiClassId = '1bu96flg6jj9ul1103967vhk_v8q9qq0'

    configatron.sriClassId = '1bu96flg6jj9ul1103967vhk_v8q9qq0'

  end
end
