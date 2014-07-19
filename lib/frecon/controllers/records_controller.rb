require "json"
require "frecon/models"

module FReCon
	class RecordsController
		def self.create(request, params)
			# Rewind the request body (an IO object)
			# in case someone else has already played
			# through it.
			request.body.rewind

			begin
				# Parse the POST data as a JSON hash
				# (because that's what it is)
				post_data = JSON.parse(request.body.read)
			rescue JSON::ParserError => e
				# If we have malformed JSON (JSON::ParserError is raised),
				# escape out of the function
				return [400, ErrorFormatter.format(e.message)]
			end

			# Change special post_data attributes.
			# Convert team number to team id.
			if post_data["team_number"]
				unless (team = Team.number post_data["team_number"]).nil?
					post_data["team_id"] = team.id
					
					post_data.delete("team_number")
				else
					return [404, ErrorFormatter.format("Could not find team of number #{post_data['team_number']}!")]
				end
			end

			# Convert match number and competition name to match id.
			if post_data["match_number"] && post_data["competition_name"]
				unless (competition = Competition.find_by name: post_data["competition_name"]).nil?
					# Try to set the match to the already existing match.
					match = competition.matches.find_by number: post_data["match_number"]
					
					# Create the match if necessary.
					match ||= Match.create(number: post_data["match_number"], competition_id: competition.id)
					
					post_data["match_id"] = match.id

					post_data.delete("match_number")
					post_data.delete("competition_name")
				else
					return [404, ErrorFormatter.format("A current competition is not set.  Please set it.")]
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

		def self.update(request, params)
			return [400, "Must supply a record id!"] unless params[:id]

			# Rewind the request body (an IO object)
			# in case someone else has already played
			# through it.
			request.body.rewind

			begin
				# Parse the POST data as a JSON hash
				# (because that's what it is)
				post_data = JSON.parse(request.body.read)
			rescue JSON::ParserError => e
				# If we have malformed JSON (JSON::ParserError is raised),
				# escape out of the function
				return [422, ErrorFormatter.format(e.message)]
			end

			@record = Record.find params[:id]

			if @record.nil?
				return [404, ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end

			if @record.update_attributes(post_data)
				@record.to_json
			else
				[422, ErrorFormatter.format(@record.errors.full_messages)]
			end
		end

		def self.delete(params)
			@record = Record.find params[:id]

			if @record
				if @record.destroy
					204
				else
					[422, ErrorFormatter.format(@record.errors.full_messages)]
				end
			else
				[404, ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end
		end

		def self.show(params)
			@record = Record.find params[:id]

			if @record
				@record.to_json
			else
				[404, ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end
		end

		def self.index(params)
			params.delete("_")

			@records = params.empty? ? Record.all : Record.where(params)

			@records.to_json
		end

		def self.competition(params)
			@record = Record.find params[:id]

			if @record
				@record.competition.to_json
			else
				[404, ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end
		end
	end
end
