# Should be moved probably.
class Position
	# MongoDB compatibility methods.
	def self.demongoize(object)
	end

	def self.mongoize(object)
	end

	def self.evolve(object)
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
			
			@alliance = case match_data[1].downcase
			            when "b"
				            :blue
			            when "r"
				            :red
			            else
				            :unknown
			            end

			position_number = match_data[2].to_i
			raise ArgumentError, "position number must be in [1, 2, 3]" unless [1, 2, 3].include?(position_number)
			
			@number = position_number
		elsif args.length == 2
			@alliance = [:blue, :red].include?(args[0]) ? args[0] : :unknown

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
