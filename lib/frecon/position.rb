# lib/frecon/position.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/base"

module FReCon
	# Public: A wrapper to handle converting team positions and storing them.
	class Position
		# Public: The alliance part of the position
		#
		# Examples
		#
		#   position = Position.new('r2')
		#   position.alliance
		#   # => :red
		attr_reader :alliance

		# Public: The slot part of the position.
		#
		# Examples
		#
		#   position = Position.new('r2')
		#   position.number
		#   # => 2
		attr_reader :number

		# Public: Convert a stored position to a Position object.
		#
		# object - String representation of a position (mongoized)
		#
		# Returns Position parsed from object.
		def self.demongoize(object)
			# `object' should *always* be a string (since MatchNumber#mongoize returns a
			# String which is what is stored in the database)
			raise ArgumentError, "`object' must be a String" unless object.is_a?(String)

			Position.new(object)
		end

		# Allows passing a String or Hash instead of a Position.
		# i.e. record.position = "r3"
		def self.mongoize(object)
			case object
			when Position
				object.mongoize
			when String
				Position.new(object).mongoize
			when Hash
				# Convert keys to symbols if necessary.
				object = Hash[object.map { |key, value| [key.to_sym, value] }]
				Position.new(object[:alliance], object[:number]).mongoize
			else
				object
			end
		end

		# Used for queries.
		def self.evolve(object)
			case object
			when Position
				object.mongoize
			when String
				Position.new(object).mongoize
			when Hash
				# Convert keys to symbols if necessary.
				object = Hash[object.map { |key, value| [key.to_sym, value] }]
				Position.new(object[:alliance], object[:number]).mongoize
			else
				object
			end
		end

		def mongoize
			to_s
		end

		def initialize(*args)
			if args.length == 1
				# Match `string' against the regular expression, described below.
				#
				# This regular expression matches all values for `string' where
				# the first letter is either "r" or "b" (case-insensitive due to /i
				# at the end of the regular expression) and the last one-or-more
				# characters in the string are digits 0-9. Anything between those two
				# that is either a letter or an underscore is not retained, but
				# if other characters exist (e.g. spaces as of right now) `string'
				# will not match.
				#
				# You can use any words you like if you have more than just
				# "r<n>" or "b<n>", for example "red_2" matches just the same
				# as "r2", or, just for fun, just the same as "royal______2".
				#
				# This behavior may change in the future.
				match_data = args[0].match(/^([rb])[a-z\_]*([0-9]+)/i)

				# Note: if matched at all, match_data[0] is the entire
				# string that was matched, hence the indices that start
				# at one.

				raise ArgumentError, "string is improperly formatted" unless match_data

				@alliance = case match_data[1].downcase
				            when "b"
					            :blue
				            when "r"
					            :red
				            else
					            raise ArgumentError, "alliance character must be in [\"b\", \"r\"]"
				            end

				position_number = match_data[2].to_i
				raise ArgumentError, "position number must be in [1, 2, 3]" unless [1, 2, 3].include?(position_number)

				@number = position_number
			elsif args.length == 2
				raise TypeError, "alliance must be a Symbol or String" unless args[0].is_a?(Symbol) || args[0].is_a?(String)
				raise ArgumentError, "alliance must be in [:blue, :red]" unless [:blue, :red].include?(args[0].to_sym)

				@alliance = args[0].to_sym

				raise TypeError, "second argument must be an Integer" unless args[1].is_an?(Integer)
				raise ArgumentError, "second argument must be in [1, 2, 3]" unless [1, 2, 3].include?(args[1])

				@number = args[1]
			else
				raise ArgumentError, "wrong number of arguments (#{args.length} for [1, 2])"
			end
		end

		def to_s
			"#{@alliance[0]}#{@number}"
		end

		def is_blue?
			@alliance == :blue
		end

		def is_red?
			@alliance == :red
		end

		alias_method :was_blue?, :is_blue?
		alias_method :was_red?, :is_red?
	end
end
