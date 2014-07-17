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
				return JSON.generate({ status: 422, errors: [ e.message ] })
			end

			# Even though "location" and "name" are optional,
			# still set them.  If they are nil, @team.location
			# and @team.name will be set to nil.
			@team = FReCon::Team.new
			@team.attributes = post_data

			if @team.save
				# Use to_json for now; we can filter it later.
				@team.to_json
			else
				JSON.generate({ status: 422, errors: @team.errors.full_messages })
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
				return JSON.generate({ status: 422, errors: [ e.message ] })
			end

			@team = FReCon::Team.find_by number: params[:number]

			if @team.nil?
				return JSON.generate({ status: 422, errors: [ "Could not find team of number #{params[:number]}!" ] })
			end

			if @team.update_attributes(post_data)
				@team.to_json
			else
				JSON.generate({ status: 422, errors: @team.errors.full_messages })
			end
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
