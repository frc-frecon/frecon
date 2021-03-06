# lib/frecon/models/match.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'frecon/model'
require 'frecon/match_number'

module FReCon
	# Public: The Match model.
	class Match < Model

		field :number, type: MatchNumber

		field :blue_score, type: Integer, default: 0
		field :red_score, type: Integer, default: 0

		belongs_to :competition
		has_many :records, dependent: :destroy

		validates :number, :competition_id, presence: true

		# Public: Get this Match's Participations
		def participations
			Participation.in id: records.map(&:participation_id)
		end

		# Public: Get this Match's Participations' Robots
		def robots
			Robot.in id: participations.map(&:robot_id)
		end

		# Public: Get this Match's Participations' Robots' Teams
		def teams
			Team.in id: robots.map(&:team_id)
		end

		register_routable_relation :competition, 'competition'
		register_routable_relation :records, 'records'
		register_routable_relation :participations, 'participations'
		register_routable_relation :robots, 'robots'
		register_routable_relation :teams, 'teams'

	end
end
