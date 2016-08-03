lib_directory = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(lib_directory) unless $LOAD_PATH.map { |directory| File.expand_path(directory) }.include?(lib_directory)

require 'frecon/base/variables'

Gem::Specification.new do |s|
	s.name = 'frecon'
	s.email = 'frc-frecon@googlegroups.com'
	s.version = FReCon::VERSION

	s.licenses = ['MIT']

	s.summary = 'A JSON API for scouting FRC competitions.'
	s.description = 'A JSON API in Sinatra for scouting FRC competitions, and that manages the database using Mongoid.'

	s.authors = ['Sam Craig',
	             'Kristofer Rye',
	             'Christopher Cooper',
	             'Sam Mercier',
	             'Tiger Huang',
	             'Vincent Mai']

	s.homepage = 'https://github.com/frc-frecon/frecon'

	s.files = []
	s.files << 'Gemfile'
	s.files << 'Rakefile'
	s.files << Dir.glob('lib/**/*.rb')
	s.files << 'lib/frecon/mongoid.yml'
	s.files << Dir.glob('config/**/*')
	s.files << 'bin/frecon'

	s.executables << 'frecon'

	s.add_runtime_dependency 'sinatra', ['~> 1.4']
	s.add_runtime_dependency 'pry', ['~> 0.10']
	s.add_runtime_dependency 'thin', ['~> 1.6']
	s.add_runtime_dependency 'mongoid', ['~> 5.1']
	s.add_runtime_dependency 'http', ['~> 2.0']

	s.add_development_dependency 'yard', ['~> 0.9']
	s.add_development_dependency 'yard-tomdoc', ['~> 0.7']
	s.add_development_dependency 'yard-mongoid', ['~> 0.0']
	s.add_development_dependency 'rake', ['~> 11.2']

	s.add_development_dependency 'rspec', ['~> 3.5']
	s.add_development_dependency 'guard', ['~> 2.14']
	s.add_development_dependency 'guard-rspec', ['~> 4.7']

	s.add_development_dependency 'coveralls', ['~> 0.8']
	s.add_development_dependency 'codeclimate', ['~> 0.35']
	s.add_development_dependency 'codeclimate-test-reporter', ['~> 0.6']

	s.add_development_dependency 'pry-doc', ['~> 0']
end
