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
	attr_reader :round, :number

	def initialize(string)
		@replay = false
		@type = :qualification
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
	field :red_score, type: Integer
	field :blue_score, type: Integer

	belongs_to :competition
	has_many :records

	validates :number, :red_score, :blue_score, presence: true
end
