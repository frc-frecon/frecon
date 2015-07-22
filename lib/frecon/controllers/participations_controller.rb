# lib/frecon/controllers/participations_controller.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "json"
require "frecon/models/participation"

module FReCon
	class ParticipationsController < Controller
		def self.create(request, params, post_data = nil)
			super(request, params, post_data || team_number_to_team_id(process_json_request(request)))
		end
	end
end
