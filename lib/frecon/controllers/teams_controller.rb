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
		def self.create(request, params)
			post_data = process_json_object_request request

			@team = Team.new
			@team.attributes = post_data

			if @team.save
				# Use to_json for now; we can filter it later.
				[201, @team.to_json]
			else
				raise RequestError.new(422, @team.errors.full_messages)
			end
		end

		def self.update(request, params)
			raise RequestError.new(400, "Must supply a team id or number!") unless params[:number]

			post_data = process_json_object_request request

			@team = find_team params
			raise RequestError.new(404, could_not_find(params[:number], "number")) if @team.nil?

			if @team.update_attributes(post_data)
				@team.to_json
			else
				raise RequestError.new(422, @team.errors.full_messages)
			end
		end

		def self.delete(params)
			@team = find_team params

			if @team
				if @team.destroy
					204
				else
					raise RequestError.new(422, @team.errors.full_messages)
				end
			else
				raise RequestError.new(404, could_not_find(params[:number], "number"))
			end
		end

		def self.show(params)
			@team = find_team params

			if @team
				@team.to_json
			else
				raise RequestError.new(404, could_not_find(params[:number], "number"))
			end
		end

		def self.records(params)
			@team = find_team params

			if @team
				if params[:competition_id]
					@competition = Competition.find params[:competition_id]

					if @competition
						@team.records.in(match_id: @competition.matches.map { |match| match.id }).to_json
					else
						raise RequestError.new(404, could_not_find(params[:competition_id], "id", "competition"))
					end
				else
					@team.records.to_json
				end
			else
				raise RequestError.new(404, could_not_find(params[:number], "number"))
			end
		end

		def self.matches(params)
			@team = find_team params

			if @team
				# Ensure that the competition ID is valid.
				if params[:competition_id]
					@competition = Competition.find params[:competition_id]

					raise RequestError.new(404, could_not_find(params[:competition_id], "id", "competition")) if @competition.nil?
				end

				@team.matches(params[:competition_id]).to_json
			else
				raise RequestError.new(404, could_not_find(params[:number], "number"))
			end
		end

		def self.competitions(params)
			@team = find_team params

			if @team
				@team.competitions.to_json
			else
				raise RequestError.new(404, could_not_find(params[:number], "number"))
			end
		end

		# The `number` param will be a number or id.
		def self.find_team(params)
			(Team.find_by id: params[:number]) || (Team.find_by number: params[:number])
		end
	end
end
