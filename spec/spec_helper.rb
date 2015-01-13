require "logger"
require "mongoid"

# require "database_cleaner"

require "securerandom"

require "frecon/database"

FReCon::Database.setup(:test)

database_cleaner_good = false

# This code is deferred because of an upstream issue with
# DatabaseCleaner--says Mongoid can't use truncation but
# lists truncation as an available ORM strategy thing.
if database_cleaner_good
	RSpec.configure do |config|
		config.before(:suite) do
			DatabaseCleaner[:mongoid].strategy = :truncation
			DatabaseCleaner.clean_with(:truncation)
		end

		config.before(:each) do
			DatabaseCleaner.start
		end

		config.after(:each) do
			DatabaseCleaner.clean
		end
	end
end

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
