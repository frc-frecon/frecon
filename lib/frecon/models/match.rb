require "frecon/match_number"

module FReCon
	class Match
		include Mongoid::Document
		include Mongoid::Timestamps

		field :number, type: MatchNumber

		field :blue_score, type: Integer, default: 0
		field :red_score, type: Integer, default: 0

		belongs_to :competition
		has_many :records

		validates :number, :competition_id, presence: true
	end
end
