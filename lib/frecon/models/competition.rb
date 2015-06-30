# lib/frecon/models/competition.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/model"

module FReCon
	class Competition < Model
		field :location, type: String
		field :name, type: String

		has_many :matches, dependent: :destroy
		has_many :participations, dependent: :destroy

		validates :location, :name, presence: true
		validates :name, uniqueness: true

		def records
			Record.in match_id: matches.map(&:id)
		end

		def robots
			Robot.in id: participations.map(&:robot_id)
		end
	end
end
