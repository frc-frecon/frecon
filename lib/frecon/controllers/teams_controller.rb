require "json"

module FReCon
	class TeamsController
		def self.create(request, params)
			request.body.rewind
			post_data = JSON.parse(request.body.read)

			response_hash = {status: 201, errors: []}

			response_hash[:status] = 400 if (!post_data["number"] ||
											 !post_data["location"] ||
											 !post_data["name"])

			response_hash[:errors] << "Must supply a team number as an Integer!" unless post_data["number"] && post_data["number"].is_a?(Integer)
			response_hash[:errors] << "Must supply a team location as a String!" unless post_data["location"] && post_data["location"].is_a?(String)
			response_hash[:errors] << "Must supply a team name as a String!" unless post_data["name"] && post_data["name"].is_a?(String)

			if response_hash[:status] == 201
				@team = Team.create(number: post_data["number"], location: post_data["location"], name: post_data["name"])

				JSON.generate(@team)
			else
				JSON.generate(response_hash)
			end
		end

		def self.update(params)

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
