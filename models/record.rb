# TODO: Move to another directory.
class Position
	# MongoDB compatibility methods.
	def mongoize
		to_s
	end

	def self.demongoize(object)
		# object will be a string
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
			Position.new(object[:alliance], object[:number]).mongoize
		else
			object
		end
	end

	def to_s
		"#{@alliance[0]}#{@number}"
	end

	# Custom methods.
	attr_reader :alliance, :number

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

			raise ArgumentError, "unable to process RegExp" unless match_data

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
			raise ArgumentError, "alliance must be in [:blue, :red]" unless [:blue, :red].include?(args[0])

			@alliance = args[0].is_a?(String) ? args[0].to_sym : args[0]

			raise TypeError, "second argument must be an Integer" unless args[1].is_a?(Integer)
			raise ArgumentError, "second argument must be in [1, 2, 3]" unless [1, 2, 3].include?(args[1])

			@number = args[1]
		else
			raise ArgumentError, "wrong number of arguments (#{args.length} for [1, 2])"
		end
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

class Record
	include Mongoid::Document
	include Mongoid::Timestamps

	field :notes, type: String
	field :position, type: Position

	belongs_to :match
	belongs_to :team

	validates :position, :match_id, :team_id, presence: true
end
