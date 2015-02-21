require "logger"
require "mongoid"

require "securerandom"

require "frecon/database"

FReCon::Database.setup(:test)

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
