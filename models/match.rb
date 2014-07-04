# Should probably be moved.
class MatchNumber
	
end

class Match
	include Mongoid::Document
	include Mongoid::Timestamps

	field :number, type: MatchNumber
	field :red_score, type: Integer
	field :blue_score, type: Integer

	belongs_to :competition
	has_many :records
end
