require 'test-factory'
require 'configatron'
require 'json'
require 'rest-client'
require 'os'
require 'slack-ruby-client'

$: << File.dirname(__FILE__)+'/intellify'
require 'intellify/intellify_base_page'
Dir["#{File.dirname(__FILE__)}/intellify/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/pages/IntellifyEssentials/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/pages/**/*.rb"].each {|f| require f }



