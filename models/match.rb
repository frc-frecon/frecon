# Should probably be moved.
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

		match_data = string.match(/(p|q|qf|sf|f)([\d]+)?m([\d]+)(r)?([\d]+)?/i)

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

		if match_data[2]
			@round = match_data[2].to_i
		end

		@number = match_data[3].to_i

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
