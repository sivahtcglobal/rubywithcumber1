spec = Gem::Specification.new do |s|
  s.name = 'essentials-automation'
  s.version = '0.0.1'
  s.summary = %q{This framework is for testing Intellify Workbench, Moodle Sensor, API }
  s.description = %q{This gem is used for creating test scripts for Intellify Automation.}
  s.files = Dir.glob("**/**/**")
  s.authors = ["Ravishankar" ]
  s.email = %w{"ravishankar@intellifylearning.com"}
  s.homepage = 'https://github.com/'
  s.add_dependency 'test-factory', '>= 0.5.3'
  s.required_ruby_version = '>= 2.3.1'
end