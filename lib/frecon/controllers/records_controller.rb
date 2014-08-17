require "json"
require "frecon/base"
require "frecon/models"

module FReCon
	class RecordsController < Controller
		def self.create(request, params)
			post_data = process_request request
			return post_data if post_data.is_an?(Array)

			# Change special post_data attributes.
			# Convert team number to team id.
			post_data = team_number_to_team_id(post_data)

			# Convert match number and competition name to match id.
			if post_data["match_number"] && !post_data["match_id"]
				if post_data["competition_name"] && (competition = Competition.find_by name: post_data["competition_name"])
					# Try to set the match to the already existing match.
					match = competition.matches.find_by number: post_data["match_number"]

					# Create the match if necessary.
					match ||= Match.create(number: post_data["match_number"], competition_id: competition.id)

					post_data["match_id"] = match.id

					post_data.delete("match_number")
					post_data.delete("competition_name")
				else
					return [422, ErrorFormatter.format("A current competition is not set.  Please set it.")]
				end
			end

			@record = Record.new
			@record.attributes = post_data

			if @record.save
				# Use to_json for now; we can filter it later.
				[201, @record.to_json]
			else
				[422, ErrorFormatter.format(@record.errors.full_messages)]
			end
		end

		def self.competition(params)
			show_attribute params, :competition
		end
	end
end
