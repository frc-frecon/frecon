# lib/frecon/controllers/dump_controller.rb
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
	class DumpController
		def self.full(params)
			competitions = Competition.all
			teams = Team.all
			matches = Match.all
			records = Record.all

			{
				"competitions" => competitions,
				"teams" => teams,
				"matches" => matches,
				"records" => records
			}.to_json
		end
	end
end
