# lib/frecon/match_number.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'frecon/base/bson'
require 'frecon/base/environment'
require 'frecon/base/object'
require 'frecon/base/variables'

module FReCon
	# Public: A wrapper to handle converting match numbers and storing them.
	class MatchNumber

		# Public: All of the possible match types for a MatchNumber to have.
		POSSIBLE_TYPES = [:practice, :qualification, :quarterfinal, :semifinal, :final]

		# Public: All of the elimination types for a MatchNumber to have.
		ELIMINATION_TYPES = [:quarterfinal, :semifinal, :final]

		# Public: The numerical part of the match number
		#
		# Examples
		#
		#   match_number = MatchNumber.new('qm2')
		#   match_number.number
		#   # => 2
		attr_reader :number

		# Public: The round part of the match number
		#
		# Examples
		#
		#   match_number = MatchNumber.new('qf1m2r3')
		#   match_number.round
		#   # => 2
		attr_reader :round

		# Public: The type of the match.
		#
		# Examples
		#
		#   match_number = MatchNumber.new('qf1m2r3')
		#   match_number.type
		#   # => :quarterfinal
		attr_reader :type

		# Public: The replay number of the match.
		#
		# Examples
		#
		#   match_number = MatchNumber.new('qf1m2r3')
		#   match_number.replay_number
		#   # => 3
		attr_reader :replay_number

		# Public: Convert a stored match number string to a MatchNumber object.
		#
		# string - String representation of a match number (mongoized)
		#
		# Returns MatchNumber parsed from string.
		def self.demongoize(string)
			# `string' should *always* be a string (since MatchNumber#mongoize returns a
			# String which is what is stored in the database)
			raise ArgumentError, "`string' must be a String" unless string.is_a?(String)

			MatchNumber.parse(string)
		end

		# Public: Convert a MatchNumber object to a storable string representation.
		#
		# object - A MatchNumber, String, or Hash. If MatchNumber, run #mongoize on
		#          it.  If String or Hash, create a new MatchNumber object for it,
		#          then run #mongoize on it.
		#
		# Returns String containing the mongo-ready value for the representation.
		def self.mongoize(object)
			case object
			when MatchNumber
				object.mongoize
			when String
				MatchNumber.parse(object).mongoize
			when Hash
				MatchNumber.from_hash(object).mongoize
			else object
			end
		end

		# Public: Convert a MatchNumber object to a queryable string representation
		# for use when querying.
		#
		# object - A MatchNumber, String, or Hash. If MatchNumber, run #mongoize on
		#          it.  If String or Hash, create a new MatchNumber object for it,
		#          then run #mongoize on it.
		#
		# Returns String containing the mongo-ready value for the representation.
		def self.evolve(object)
			case object
			when MatchNumber
				object.mongoize
			when String
				MatchNumber.parse(object).mongoize
			when Hash
				MatchNumber.from_hash(object).mongoize
			else object
			end
		end

		def self.parse(string)
			# Match `string' against the regular expression, described below.
			#
			# This regular expression matches all values where the first group of
			# characters is one of either [ 'p', 'q', 'qf', 'sf', 'f' ], which is
			# parsed as the 'type' of the match. This is followed by an 'm' and a
			# group of digits, which is parsed as the 'number' of the match.
			#
			# In addition, one can specify a 'round number' following the first group
			# of characters such as in eliminations and finals. Often times, there
			# are multiple so-called 'rounds' in eliminations, and so the system will
			# optionally capture that round.
			#
			# Also, one can specify a 'replay number' following the match number.
			# this is done by appending 'r' and a group of digits which is the replay
			# number.
			#
			# Below are listed the match groups and what they are:
			#
			# 1: Match type
			# 2: Round number (optional)
			# 3: Match number
			# 4: Replay string (optional)
			# 5: Replay number (required if #4 is supplied)
			#
			# This behavior may change in the future.
			match_data = string.match(/(p|q|qf|sf|f)([\d]+)?m([\d]+)(r)?([\d]+)?/i)

			# Whine if we don't have a match (string is incorrectly formatted)
			raise ArgumentError, 'string is improperly formatted' unless match_data

			# Parse the match type string
			type = case match_data[1].downcase
			       when 'p'
				       :practice
			       when 'q'
				       :qualification
			       when 'qf'
				       :quarterfinal
			       when 'sf'
				       :semifinal
			       when 'f'
				       :final
			       end

			# Parse the match number
			number = match_data[3].to_i
			raise ArgumentError, 'match number must be greater than 0' unless number > 0

			round = nil

			# Parse the round number, if it is present
			if match_data[2]
				round ||= match_data[2].to_i
				raise ArgumentError, 'round number must be greater than 0' unless round > 0
			end

			# Parse replay match group, store replay number if present.
			replay_number = match_data[5].to_i if match_data[4] == 'r'

			MatchNumber.new(type: type, number: number, round: round, replay_number: replay_number)
		end

		def self.from_hash(hash)
			# type (Symbol or String)
			# number (Integer)
			# round (Integer), optional
			# replay_number (Integer), optional

			# Convert keys to symbols if needed.
			hash = Hash[hash.map { |key, value| [key.to_sym, value] }]

			raise TypeError, 'type must be a Symbol or String' unless hash[:type].is_a?(Symbol) || hash[:type].is_a?(String)
			raise ArgumentError, "type must be in #{POSSIBLE_TYPES.inspect}" unless POSSIBLE_TYPES.include?(hash[:type].to_sym)

			type = hash[:type].to_sym

			raise TypeError, 'match number must be an Integer' unless hash[:number].is_an?(Integer)
			raise ArgumentError, 'match number must be greater than 0' unless hash[:number] > 0

			number = hash[:number]

			round = nil

			if hash[:round]
				raise TypeError, 'round number must be an Integer' unless hash[:round].is_an?(Integer)
				raise ArgumentError, 'round number must be greater than 0' unless hash[:round] > 0

				round = hash[:round]
			end

			if hash[:replay_number]
				raise TypeError, 'replay number must be an Integer' unless hash[:replay_number].is_an?(Integer)
				raise ArgumentError, 'replay number must be greater than 0' unless hash[:replay_number] > 0

				replay_number = hash[:replay_number]
			end

			MatchNumber.new(type: type, number: number, round: round, replay_number: replay_number)
		end

		# Public: Convert to a storable string representation.
		#
		# Returns String representing the MatchNumber's data.
		def mongoize
			to_s
		end

		def initialize(type:, number:, round: nil, replay_number: nil)
			@type, @number, @round, @replay_number = type, number, round, replay_number
		end

		# Public: Convert to a String.
		#
		# Returns String representing the match number data.
		def to_s
			type_string = case @type
			              when :practice
				              'p'
			              when :qualification
				              'q'
			              when :quarterfinal
				              'qf'
			              when :semifinal
				              'sf'
			              when :final
				              'f'
			              end

			match_string = "m#{@number}"
			replay_string = "r#{@replay_number}" if replay?

			"#{type_string}#{@round}#{match_string}#{replay_string}"
		end

		# Public: Determine if MatchNumber represents a replay.
		def replay?
			!@replay_number.nil? && @replay_number > 0
		end

		# Public: Determine if MatchNumber represents a practice match.
		def practice?
			@type == :practice
		end

		# Public: Determine if MatchNumber represents a qualification match.
		def qualification?
			@type == :qualification
		end

		# Public: Determine if MatchNumber represents a quarterfinal match.
		def quarterfinal?
			@type == :quarterfinal
		end

		# Public: Determine if MatchNumber represents a semifinal match.
		def semifinal?
			@type == :semifinal
		end

		# Public: Determine if MatchNumber represents a final match.
		def final?
			@type == :final
		end

		# Public: Determine if MatchNumber represents a match of any elimination
		# type.
		def elimination?
			ELIMINATION_TYPES.include?(@type)
		end

	end
end
