# -*- mode: ruby -*-

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
	add_filter '.bundle/'
end