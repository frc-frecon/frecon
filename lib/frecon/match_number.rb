# lib/frecon/match_number.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/base"

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

		# Public: Convert a stored match number to a MatchNumber object.
		#
		# object - String representation of a match number (mongoized)
		#
		# Returns MatchNumber parsed from object.
		def self.demongoize(object)
			# `object' should *always* be a string (since MatchNumber#mongoize returns a
			# String which is what is stored in the database)
			raise ArgumentError, "`object' must be a String" unless object.is_a?(String)

			MatchNumber.new(object)
		end

		# Public: Convert a MatchNumber object to a storable string representation.
		#
		# object - A MatchNumber, String, or Hash. If MatchNumber, run #mongoize on
		#          it.  If String, create a new MatchNumber object for it, then run
		#          #mongoize on it. If Hash, convert its keys to symbols, then
		#          pull out the :alliance and :number keys to generate a
		#          MatchNumber.
		#
		# Returns String containing the mongo-ready value for the representation.
		def self.mongoize(object)
			case object
			when MatchNumber
				object.mongoize
			when String, Hash
				MatchNumber.new(object).mongoize
			else
				object
			end
		end

		# Public: Convert a MatchNumber object to a storable string representation
		# for queries.
		#
		# object - A MatchNumber, String, or Hash. If MatchNumber, run #mongoize on
		#          it.  If String, create a new MatchNumber object for it, then run
		#          #mongoize on it. If Hash, convert its keys to symbols, then
		#          pull out the :alliance and :number keys to generate a
		#          MatchNumber.
		#
		# Returns String containing the mongo-ready value for the representation.
		def self.evolve(object)
			case object
			when MatchNumber
				object.mongoize
			when String, Hash
				MatchNumber.new(object).mongoize
			else
				object
			end
		end

		# Public: Convert to a storable string representation.
		#
		# Returns String representing the MatchNumber's data.
		def mongoize
			to_s
		end

		def initialize(args)
			if args.is_a?(String)
				# Match `args' against the regular expression, described below.
				#
				# This regular expression matches all values where the first group of
				# characters is one of either [ "p", "q", "qf", "sf", "f" ], which is
				# parsed as the "type" of the match. This is followed by an "m" and a
				# group of digits, which is parsed as the "number" of the match.
				#
				# In addition, one can specify a "round number" following the first group
				# of characters such as in eliminations and finals. Often times, there
				# are multiple so-called "rounds" in eliminations, and so the system will
				# optionally capture that round.
				#
				# Also, one can specify a "replay number" following the match number.
				# this is done by appending "r" and a group of digits which is the replay
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
				match_data = args.match(/(p|q|qf|sf|f)([\d]+)?m([\d]+)(r)?([\d]+)?/i)

				# Whine if we don't have a match (string is incorrectly formatted)
				raise ArgumentError, "string is improperly formatted" unless match_data

				# Check and set required stuff first, everything else later.

				# Whine if we don't have a match type
				raise ArgumentError, "match type must be supplied" unless match_data[1]

				# Parse the match type string
				@type = case match_data[1].downcase
				        when "p"
					        :practice
				        when "q"
					        :qualification
				        when "qf"
					        :quarterfinal
				        when "sf"
					        :semifinal
				        when "f"
					        :final
				        else
					        raise ArgumentError, "match type must be in [\"p\", \"q\", \"qf\", \"sf\", \"f\"]"
				        end

				# Whine if we don't have a match number
				raise ArgumentError, "match number must be supplied" unless match_data[3]

				# Parse the match number
				@number = match_data[3].to_i
				raise ArgumentError, "match number must be greater than 0" unless @number > 0

				# Parse the round number, if it is present
				if match_data[2]
					@round = match_data[2].to_i
					raise ArgumentError, "round number must be greater than 0" unless @round > 0
				end

				# Parse replay match group, store replay number if present.
				@replay_number = match_data[5].to_i if match_data[4] == "r"
			elsif args.is_a?(Hash)
				# type (Symbol or String)
				# number (Integer)
				# round (Integer), optional
				# replay_number (Integer), optional

				# Convert keys to symbols if needed.
				args = Hash[args.map { |key, value| [key.to_sym, value] }]

				raise TypeError, "type must be a Symbol or String" unless args[:type].is_a?(Symbol) || args[:type].is_a?(String)
				raise ArgumentError, "type must be in #{POSSIBLE_TYPES.inspect}" unless POSSIBLE_TYPES.include?(args[:type].to_sym)

				@type = args[:type].to_sym

				raise TypeError, "match number must be an Integer" unless args[:number].is_an?(Integer)
				raise ArgumentError, "match number must be greater than 0" unless args[:number] > 0

				@number = args[:number]

				if args[:round]
					raise TypeError, "round number must be an Integer" unless args[:round].is_an?(Integer)
					raise ArgumentError, "round number must be greater than 0" unless args[:round] > 0

					@round = args[:round]
				end

				if args[:replay_number]
					raise TypeError, "replay number must be an Integer" unless args[:replay_number].is_an?(Integer)
					raise ArgumentError, "replay number must be greater than 0" unless args[:replay_number] > 0

					@replay_number = args[:replay_number]
				end
			else
				raise TypeError, "argument must be a String or Hash"
			end
		end

		# Public: Convert to a String.
		#
		# Returns String representing the match number data.
		def to_s
			type_string = case @type
			              when :practice
				              "p"
			              when :qualification
				              "q"
			              when :quarterfinal
				              "qf"
			              when :semifinal
				              "sf"
			              when :final
				              "f"
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

		def elimination?
			ELIMINATION_TYPES.include?(@type)
		end
	end
end
