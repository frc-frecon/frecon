# lib/frecon/controllers/records_controller.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "json"
require "frecon/base"
require "frecon/models"

module FReCon
	class RecordsController < Controller
		def self.create(request, params, post_data = nil)
			super(request, params, post_data || match_number_and_competition_to_match_id(team_number_to_team_id(process_json_request(request))))
		end

		def self.competition(params)
			show_attribute params, :competition
		end
	end
end
