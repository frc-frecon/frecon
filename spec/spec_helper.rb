require 'rspec'

PROJECT_ROOT_DIRECTORY = File.join(File.dirname(__FILE__), '..')
LIB_DIRECTORY = File.join(PROJECT_ROOT_DIRECTORY, 'lib')

# Initialization code for CodeClimate
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

# Set up SimpleCov
SimpleCov.start do
	formatter SimpleCov::Formatter::MultiFormatter.new([
		SimpleCov::Formatter::HTMLFormatter,
		CodeClimate::TestReporter::Formatter
	])
end
