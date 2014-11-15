# lib/frecon/controllers/robots_controller.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "json"
require "frecon/models/robot"

module FReCon
	class RobotsController < Controller
		def self.competition(params)
			show_attribute params, :competition
		end

		def self.team(params)
			show_attribute params, :team
		end
	end
end
