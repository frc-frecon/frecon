require "logger"
require "mongoid"

require "frecon"

Mongoid.load!(File.join(File.dirname(__FILE__), "..", "lib", "frecon", "mongoid.yml"), :test)

Mongoid.logger.level = Logger::DEBUG
Mongoid.logger = Logger.new($stdout)

Moped.logger.level = Logger::DEBUG
Moped.logger = Logger.new($stdout)

RSpec::Matchers.define :be_a do |expected|
	match do |actual|
		actual.class == expected
	end
end

RSpec::Matchers.define :include do |expected|
	match do |actual|
		actual.include?(expected)
	end
end
