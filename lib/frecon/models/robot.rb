# lib/frecon/models/robot.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/model"

module FReCon
	class Robot < Model
		# This is an optional field we included for organization.
		field :name, type: String

		belongs_to :competition
		belongs_to :team

		validates :competition_id, :team_id, presence: true
		validates :team_id, uniqueness: { scope: :competition_id }
	end
end
