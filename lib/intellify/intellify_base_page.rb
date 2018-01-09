class BasePage < PageFactory

  class << self

    #Stream Delay Time
    configatron.streamDelayTime = 30000

    #Slack Integration Token
    configatron.slackToken = 'XXXXXXXXXXXXXXXXXXXXXXXX'

    #dev,staging,prod stack
    configatron.essusername = ENV['ESSENTIAL_ADMIN_USER']
    configatron.esspassword = ENV['ESSENTIAL_ADMIN_PASSWORD']
    configatron.essLDAPusername = ENV['LDAP_USER']
    configatron.essLDAPpassword = ENV['LDAP_PASSWORD']
    configatron.intellifywbuser = ENV['INTELLIFY_WB_USER']
    configatron.intellifywbpassword = ENV['INTELLIFY_WB_PASSWORD']
    configatron.essNonAdminusername = ENV['ESSENTIAL_USER']
    configatron.essNonAdminpassword = ENV['ESSENTIAL_PASSWORD']
    configatron.essNonAdminchangepassword = ENV['ESSENTIAL_CHANGE_PASSWORD']

    case ENV['ENVIRONMENT']
      when 'canvasauto.intellifyqa.net'
        ###Essentials Configuration
        configatron.environment = 'Master-Staging'
        @essentialhostname = 'canvasauto.intellifyqa.net' #@essentialhostname = "localhost:8080"
        configatron.hostname1  = 'canvasauto.intellifyqa.net'
        configatron.essentialloginURL  = "https://#{@essentialhostname}/login/#"
        configatron.essentialWBloginURL  = "https://#{@essentialhostname}/wb/index.html#/login"
        configatron.apiToken1URL = "http://#{@essentialhostname}/user/apiToken"
        configatron.essentialhomepageURL  = "https://#{@essentialhostname}/essentials/#/data-sources"
        configatron.essentialWBstreampageURL  = "https://#{@essentialhostname}/wb/index.html#/admin/explore"
        configatron.essentialWBdatastorepageURL  = "https://#{@essentialhostname}/wb/index.html#/admin/organize"
        configatron.essentialHelppageURL  = "https://#{@essentialhostname}/essentials/#/help"
        #Intellify Ess entials Tablaeu API
        configatron.datacollectiondetails ="https://#{@essentialhostname}/datacollection/"
        configatron.datasourcedetails  = "https://#{@essentialhostname}/datasource"
        configatron.reports  = "https://#{@essentialhostname}/api/essentials/reports/v0"
        configatron.schema  = "https://#{@essentialhostname}/api/essentials/reports/v0/canvas-submission_fact/schema/tableau"

      when 'prodsmoketest.intellify.io'
        #Essentials Configuration
        configatron.environment = 'Master-PROD'
        @essentialhostname = 'prodsmoketest.intellify.io' #@essentialhostname = "localhost:8080"
        configatron.hostname1  = 'prodsmoketest.intellify.io'
        configatron.essentialloginURL  = "https://#{@essentialhostname}/login/#"
        configatron.essentialWBloginURL  = "https://#{@essentialhostname}/wb/index.html#/login"
        configatron.apiToken1URL = "http://#{@essentialhostname}/user/apiToken"
        configatron.essentialhomepageURL  = "https://#{@essentialhostname}/essentials/#/data-sources"
        configatron.essentialWBstreampageURL  = "https://#{@essentialhostname}/wb/index.html#/admin/explore"
        configatron.essentialWBdatastorepageURL  = "https://#{@essentialhostname}/wb/index.html#/admin/organize"
        configatron.essentialHelppageURL  = "https://#{@essentialhostname}/essentials/#/help"
        #Intellify Ess entials Tablaeu API
        configatron.datacollectiondetails ="https://#{@essentialhostname}/datacollection/"
        configatron.datasourcedetails  = "https://#{@essentialhostname}/datasource"
        configatron.reports  = "https://#{@essentialhostname}/api/essentials/reports/v0"
        configatron.schema  = "https://#{@essentialhostname}/api/essentials/reports/v0/canvas-submission_fact/schema/tableau"

      when 'localhost'
        configatron.environment = 'localhost'
        @essential_host = ENV['ESSENTIALS_HOST'] || 'http://localhost:8080'
        @api_host = ENV['ESSENTIALS_API_HOST'] || 'https://intellifyqa-automation1.intellifydev.net'
        @workbench_host = ENV['ESSENTIALS_WORKBENCH_HOST'] || @api_host
        @essentials_path = ENV['ESSENTIALS_PATH'] || ''
        @essentials_url = "#{@essential_host}/#{@essentials_path}"
        @workbench_url = "#{@workbench_host}/wb/index.html"

        configatron.hostname1  = @api_hostname
        configatron.essentialloginURL  = "#{@essentials_url}/#/login"
        configatron.essentialWBloginURL  = "#{@workbench_url}#/login"
        configatron.apiToken1URL = "#{@api_host}/user/apiToken"
        configatron.essentialhomepageURL  = "#{@essentials_url}/#/data-sources"
        configatron.essentialWBstreampageURL  = "#{@workbench_url}#/admin/explore"
        configatron.essentialWBdatastorepageURL  = "#{@workbench_url}#/admin/organize"
        configatron.essentialHelppageURL  = "#{@essentials_url}/#/help"
        #Intellify Ess entials Tablaeu API
        configatron.datacollectiondetails ="https://#{@essentialhostname}/datacollection/"
        configatron.datasourcedetails  = "#{@api_host}/datasource"
        configatron.reports  = "#{@api_host}/api/essentials/reports/v0"
        configatron.schema  = "#{@api_host}/api/essentials/reports/v0/canvas-submission_fact/schema/tableau"
    
      else
        ###Essential Configuration
        configatron.environment = 'Master-DEV'
        @essentialhostname = 'intellifyqa-automation1.intellifydev.net' #@essentialhostname = "localhost:8080"
        configatron.hostname1  = 'intellifyqa-automation1.intellifydev.net'
        configatron.essentialloginURL  = "https://#{@essentialhostname}/login/#"
        configatron.essentialWBloginURL  = "https://#{@essentialhostname}/wb/index.html#/login"
        configatron.apiToken1URL = "http://#{@essentialhostname}/user/apiToken"
        configatron.essentialhomepageURL  = "https://#{@essentialhostname}/essentials/#/data-sources"
        configatron.essentialWBstreampageURL  = "https://#{@essentialhostname}/wb/index.html#/admin/explore"
        configatron.essentialWBdatastorepageURL  = "https://#{@essentialhostname}/wb/index.html#/admin/organize"
        configatron.essentialHelppageURL  = "https://#{@essentialhostname}/essentials/#/help"
        #Intellify Ess entials Tablaeu API
        configatron.datacollectiondetails ="https://#{@essentialhostname}/datacollection/"
        configatron.datasourcedetails  = "https://#{@essentialhostname}/datasource"
        configatron.reports  = "https://#{@essentialhostname}/api/essentials/reports/v0"
        configatron.schema  = "https://#{@essentialhostname}/api/essentials/reports/v0/canvas-submission_fact/schema/tableau"
    end

    #Global Configurations
    @hostname = "master-staging.intellify.io"
    configatron.hostname  = "master-staging.intellify.io"
    configatron.quizPageId = Array.new
    configatron.courseId = nil
    configatron.assignmentId == nil

  end
end
