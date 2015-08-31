# lib/frecon/models/participation.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/model"

module FReCon
	# Public: The Participation model.
	class Participation < Model
		belongs_to :robot
		belongs_to :competition
		has_many :records, dependent: :destroy

		validates :robot_id, :competition_id, presence: true

		# Public: Get this Participation's Robot's Team
		def team
			robot.team
		end

		# Public: Get this Participation's Competition's Matches
		def matches
			competition.matches
		end

		register_routable_relation :robot, "robot"
		register_routable_relation :team, "team"
		register_routable_relation :competition, "competition"
		register_routable_relation :matches, "matches"
		register_routable_relation :records, "records"
	end
end
