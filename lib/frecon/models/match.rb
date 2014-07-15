require_relative "../match_number.rb"

module FReCon
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
end
