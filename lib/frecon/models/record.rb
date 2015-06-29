# lib/frecon/models/record.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/model"
require "frecon/position"

module FReCon
	class Record < Model
		field :notes, type: String
		field :position, type: Position

		validates :position, :match_id, :team_id, presence: true
	end
end
