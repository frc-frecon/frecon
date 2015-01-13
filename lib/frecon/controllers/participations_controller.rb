# lib/frecon/controllers/participations_controller.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

module FReCon
	class ParticipationsController < Controller
		def self.create(request, params)
			post_data = process_request request
			
			# Convert team number to team_id.
			post_data = team_number_to_team_id(post_data)

			@model = model.new
			@model.attributes = post_data

			if @model.save
				[201, @model.to_json]
			else
				raise RequestError.new(422, @model.errors.full_messages)
			end
		end
		
		def self.competition(params)
			show_attribute params, :competition
		end
		
		def self.team(params)
			show_attribute params, :team
		end
	end
end
