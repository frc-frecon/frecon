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
		def self.create(request, params)
			post_data = process_request request

			# Change special post_data attributes.
			# Convert team number to team id.
			post_data = team_number_to_team_id(post_data)

			# Convert match number and competition name to match id.
			if post_data["match_number"] && !post_data["match_id"]
				if post_data["competition_name"] && (competition = Competition.find_by name: post_data["competition_name"])
					# Try to set the match to the already existing match.
					begin
						match = competition.matches.find_by number: post_data["match_number"]
					rescue ArgumentError, TypeError => e
						raise RequestError.new(422, e.message)
					end

					# Create the match if necessary.
					begin
						match ||= Match.create(number: post_data["match_number"], competition_id: competition.id)
					rescue ArgumentError, TypeError => e
						raise RequestError.new(422, e.message)
					end

					post_data["match_id"] = match.id

					post_data.delete("match_number")
					post_data.delete("competition_name")
				elsif post_data["competition"] && post_data["competition"]["_id"] && post_data["competition"]["_id"]["$oid"] && (competition = Competition.find_by(id: post_data["competition"]["_id"]["$oid"]))
					# Try to set the match to the already existing match.
					match = competition.matches.find_by number: post_data["match_number"]

					# Create the match if necessary.
					begin
						match ||= Match.create(number: post_data["match_number"], competition_id: competition.id)
					rescue ArgumentError, TypeError => e
						raise RequestError.new(422, e.message)
					end

					post_data["match_id"] = match.id

					post_data.delete("match_number")
					post_data.delete("competition")
				else
					raise RequestError.new(422, "A current competition is not set.  Please set it.")
				end
			end

			@record = Record.new
			@record.attributes = post_data

			if @record.save
				# Use to_json for now; we can filter it later.
				[201, @record.to_json]
			else
				raise RequestError.new(422, @record.errors.full_messages)
			end
		end

		def self.competition(params)
			show_attribute params, :competition
		end
	end
end
