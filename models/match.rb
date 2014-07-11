# TODO: Move to another directory.
class MatchNumber
	# MongoDB compatibility methods.
	def mongoize
		to_s
	end

	def self.demongoize(object)
		# object will be a String
		MatchNumber.new(object)
	end

	def self.mongoize(object)
		case object
		when MatchNumber
			object.mongoize
		when String
		when Hash
			MatchNumber.new(object).mongoize
		else
			object
		end
	end

	def self.evolve(object)
		case object
		when MatchNumber
			object.mongoize
		when String
		when Hash
			MatchNumber.new(object).mongoize
		else
			object
		end
	end

	# Custom methods.
	attr_reader :number, :round

	def initialize(args)
		if args.is_a?(String)
			# Match `string' against the regular expression, described below.
			#
			# This regular expression matches all values for `string' where the first
			# group of characters is one of either [ "p", "q", "qf", "sf", "f" ],
			# which is parsed as the "type" of the match. This is followed by an
			# "m" and a group of digits, which is parsed as the "number" of the match.
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

			raise TypeError, "type must be a Symbol or String" unless args[:type].is_a?(Symbol) || args[:type].is_a?(String)
			raise ArgumentError, "type must be in [:practice, :qualification, :quarterfinal, :semifinal, :final]" unless [:practice, :qualification, :quarterfinal, :semifinal, :final].include?(args[:type].to_sym)

			@type = args[:type].to_sym

			raise TypeError, "match number must be an Integer" unless args[:number].is_a?(Integer)
			raise ArgumentError, "match number must be greater than 0" unless args[:number] > 0

			@number = args[:number]

			if args[:round]
				raise TypeError, "round number must be an Integer" unless args[:round].is_a?(Integer)
				raise ArgumentError, "round number must be greater than 0" unless args[:round] > 0

				@round = args[:round]
			end

			if args[:replay_number]
				raise TypeError, "replay number must be an Integer" unless args[:replay_number].is_a?(Integer)
				raise ArgumentError, "replay number must be greater than 0" unless args[:replay_number] > 0

				@replay_number = args[:replay_number]
			end
		else
			raise TypeError, "argument must be a String or Hash"
		end
	end

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

	def replay?
		!@replay_number.nil? && @replay_number > 0
	end

	def practice?
		@type == :practice
	end

	def qualification?
		@type == :qualification
	end

	def quarterfinal?
		@type == :quarterfinal
	end

	def semifinal?
		@type == :semifinal
	end

	def final?
		@type == :final
	end

	def elimination?
		[:quarterfinal, :semifinal, :final].include? @type
	end
end

class Match
	include Mongoid::Document
	include Mongoid::Timestamps

	field :number, type: MatchNumber

	field :blue_score, type: Integer
	field :red_score, type: Integer

	belongs_to :competition
	has_many :records

	validates :number, :blue_score, :red_score, :competition_id, presence: true
end
