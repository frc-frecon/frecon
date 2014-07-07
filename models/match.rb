# TODO: Move to another directory.
class MatchNumber

	# MongoDB compatibility methods.
	def self.demongoize(object)
	end

	def self.mongoize(object)
	end

	def self.evolve(object)
	end

	# Custom methods.
	attr_reader :number, :round

	def initialize(string)
		@type = nil
		@round = nil
		@number = nil
		@replay = false
		@replay_number = nil

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
		match_data = string.match(/(p|q|qf|sf|f)([\d]+)?m([\d]+)(r)?([\d]+)?/i)

		# Parse the match type string
		case match_data[1].downcase
		when "p"
			@type = :practice
		when "q"
			@type = :qualification
		when "qf"
			@type = :quarterfinal
		when "sf"
			@type = :semifinal
		when "f"
			@type = :final
		end

		# Parse the round number, if it is present
		if match_data[2]
			@round = match_data[2].to_i
		end

		# Parse the match number
		@number = match_data[3].to_i

		# Parse replay match groups
		if match_data[4] == "r"
			@replay = true
			@replay_number = match_data[5].to_i
		end
	end

	def replay?
		@replay
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
