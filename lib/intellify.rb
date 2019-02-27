require 'test-factory'
require 'configatron'
require 'json'
require 'rest-client'
require 'os'
require 'slack-ruby-client'
require 'headless'

$: << File.dirname(__FILE__)+'/intellify'
require 'intellify/intellify_base_page'
Dir["#{File.dirname(__FILE__)}/intellify/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/pages/hmhreports/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/pages/IntellifyEssentials/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/pages/moodle/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/pages/workbench/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/pages/**/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/intellify/data_objects/**/*.rb"].each {|f| require f }
Dir["#{File.dirname(__FILE__)}/test_factory_ext/**/*.rb"].each {|f| require f }



