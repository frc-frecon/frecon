# lib/frecon/controllers/teams_controller.rb
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
	class TeamsController < Controller
		# The `id` param will be a number or id.
		def self.find_model(params)
			id_or_number = params.delete("id")

			(Team.find_by id: id_or_number) || (Team.find_by number: id_or_number)
		end

		# Since Team has a special way of finding itself, we can make
		# the error message reflect this.
		def self.could_not_find(value, attribute = "id", model = model_name.downcase)
			if attribute == "id" && model == "team"
				"Could not find team of id or number #{value}!"
			else
				"Could not find #{model} of #{attribute} #{value}!"
			end
		end

		def self.records(params)
			@team = find_model params

			if @team
				if params[:competition_id]
					@competition = Competition.find params[:competition_id]

					if @competition
						@team.records.in(match_id: @competition.matches.map { |match| match.id }).to_json
					else
						raise RequestError.new(404, could_not_find(params[:competition_id], "id", "competition"), {params: params, team: @team})
					end
				else
					@team.records.to_json
				end
			else
				raise RequestError.new(404, could_not_find(params[:id], "id or number"), {params: params})
			end
		end

		def self.matches(params)
			@team = find_model params

			if @team
				# Ensure that the competition ID is valid.
				if params[:competition_id]
					@competition = Competition.find params[:competition_id]

					raise RequestError.new(404, could_not_find(params[:competition_id], "id", "competition"), {params: params, team: @team}) if @competition.nil?
				end

				@team.matches(params[:competition_id]).to_json
			else
				raise RequestError.new(404, could_not_find(params[:id], "id or number"), {params: params})
			end
		end

		def self.competitions(params)
			@team = find_model params

			if @team
				@team.competitions.to_json
			else
				raise RequestError.new(404, could_not_find(params[:id], "id or number"), {params: params})
			end
		end
	end
end
