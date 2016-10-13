require 'rspec'

# Initialization code for CodeClimate
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

# Set up SimpleCov
SimpleCov.start do

  formatter_list = [ SimpleCov::Formatter::HTMLFormatter,
                     CodeClimate::TestReporter::Formatter ]

  formatter SimpleCov::Formatter::MultiFormatter.new(formatter_list)

end
