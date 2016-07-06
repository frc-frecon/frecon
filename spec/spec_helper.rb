require 'rspec'

PROJECT_ROOT_DIRECTORY = File.join(File.dirname(__FILE__), '..')
LIB_DIRECTORY = File.join(PROJECT_ROOT_DIRECTORY, 'lib')

# Initialization code for Coveralls.io
require 'coveralls'
Coveralls.wear!

# Initialization code for CodeClimate
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
