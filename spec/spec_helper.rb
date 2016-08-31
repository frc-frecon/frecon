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

require 'rspec/expectations'

RSpec::Matchers.define :have_type do |expected_type|
	match do |actual|
		actual.type == expected_type
	end

	match_when_negated do |actual|
		!actual.type
	end
end

RSpec::Matchers.define :have_rounded_type do |expected_type|
	match do |actual|
		require 'frecon/match_number'

		actual.type == expected_type &&
			FReCon::MatchNumber::ELIMINATION_TYPES.include?(actual.type)
	end

	match_when_negated do |actual|
		require 'frecon/match_number'

		!FReCon::MatchNumber::ELIMINATION_TYPES.include?(actual.type)
	end
end

RSpec::Matchers.define :have_nonrounded_type do |expected_type|
	match do |actual|
		require 'frecon/match_number'

		actual.type == expected_type &&
			(FReCon::MatchNumber::POSSIBLE_TYPES - FReCon::MatchNumber::ELIMINATION_TYPES).include?(actual.type)
	end

	match_when_negated do |actual|
		require 'frecon/match_number'

		!(FReCon::MatchNumber::POSSIBLE_TYPES - FReCon::MatchNumber::ELIMINATION_TYPES).include?(actual.type)
	end
end

RSpec::Matchers.define :have_number do |expected_number|
	match do |actual|
		actual.number == expected_number
	end

	match_when_negated do |actual|
		!actual.number
	end
end

RSpec::Matchers.define :have_round_number do |expected_round_number|
	match do |actual|
		actual.round == expected_round_number
	end

	match_when_negated do |actual|
		!actual.round
	end
end

RSpec::Matchers.define :have_replay_number do |expected_replay_number|
	match do |actual|
		actual.replay_number == expected_replay_number
	end

	match_when_negated do |actual|
		!actual.replay_number
	end
end
