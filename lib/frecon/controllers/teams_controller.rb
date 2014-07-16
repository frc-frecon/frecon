require "json"

module FReCon
	class TeamsController
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
				return JSON.generate({status: 422, errors: [ "Malformed JSON!" ]})
			end

			# Set up a baseline response hash to get filled
			# with errors and filth when bad stuff happens.
			response_hash = {status: 201, errors: []}

			# If anything isn't what it's supposed to be, set the status to be
			# 422 (Unprocessable Entity) because the JSON isn't clear to set up
			# a new Team object
			response_hash[:status] = 422 if (!post_data["number"] ||
			                                 !post_data["number"].is_a?(Integer) ||
			                                 !post_data["location"] ||
			                                 !post_data["location"].is_a?(String) ||
			                                 !post_data["name"] ||
			                                 !post_data["name"].is_a?(String))

			# Add errors to describe why something didn't work.
			response_hash[:errors] << "Must supply a team number as an Integer!" unless
				post_data["number"] && post_data["number"].is_a?(Integer)
			response_hash[:errors] << "Must supply a team location as a String!" unless
				post_data["location"] && post_data["location"].is_a?(String)
			response_hash[:errors] << "Must supply a team name as a String!" unless
				post_data["name"] && post_data["name"].is_a?(String)

			# If the response status is in the correct range,
			if (200..299).include?(response_hash[:status])
				@team = FReCon::Team.create(number: post_data["number"], location: post_data["location"], name: post_data["name"])

				return JSON.generate(@team)
			else
				return JSON.generate(response_hash)
			end
		end

		def self.update(request, params)
			raise IncorrectParamError, "Must supply a team number!" unless params[:number]

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
				return JSON.generate({status: 422, errors: [ "Malformed JSON!" ]})
			end

			# Set up a baseline response hash to get filled
			# with errors and filth when bad stuff happens.
			response_hash = {status: 201, errors: []}

			@team = FReCon::Team.find_by(number: params[:number])

			if !@team
				response_hash = {status: 422, errors: ["Could not find team #{params[:number]}"]}
			end

			update_properties = post_data.keys.select{|key| ["number", "name", "location"].include?(key)}

			if update_properties.include?("number")
				unless FReCon::Team.number_good?(post_data["number"])
					response_hash[:status] = 422
					response_hash[:errors] << "Team number is incorrect!"
				end

				@team.number = post_data["number"]
			end

			if update_properties.include?("name")
				unless FReCon::Team.name_good?(post_data["name"])
					response_hash[:status] = 422
					response_hash[:errors] << "Team name is incorrect!"
				end

				@team.name = post_data["name"]
			end

			if update_properties.include?("location")
				unless FReCon::Team.location_good?(post_data["location"])
					response_hash[:status] = 422
					response_hash[:errors] << "Team location is incorrect!"
				end

				@team.location = post_data["location"]
			end

			@team.save

			return JSON.generate(response_hash)
		end

		def self.show(params)
			@team = Team.find_by number: params[:number]

			raise Sinatra::NotFound unless @team

			case params[:format]
			when "json"
				@team.to_json
			end
		end

		def self.index(params)
			@teams = Team.all

			case params[:format]
			when "json"
				@teams.to_json
			end
		end
	end
end
