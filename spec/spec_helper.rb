require 'rspec'

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
