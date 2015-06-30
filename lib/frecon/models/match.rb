# lib/frecon/models/match.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/model"
require "frecon/match_number"

module FReCon
	class Match < Model
		field :number, type: MatchNumber

		field :blue_score, type: Integer, default: 0
		field :red_score, type: Integer, default: 0

		belongs_to :competition
		has_many :records, dependent: :destroy

		validates :number, :competition_id, presence: true

		def participations
			Participation.in id: records.map(&:participation_id)
		end
	end
end
