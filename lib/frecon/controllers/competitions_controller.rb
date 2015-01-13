# lib/frecon/controllers/competitions_controller.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "json"
require "frecon/models"

module FReCon
	class CompetitionsController < Controller
		def self.teams(params)
			show_attribute params, :teams
		end

		def self.matches(params)
			show_attribute params, :matches
		end

		def self.records(params)
			show_attribute params, :records
		end
	end
end
