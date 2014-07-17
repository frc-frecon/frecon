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
				return [400, FReCon::ErrorFormatter.format(e.message)]
			end
			
			@team = FReCon::Team.new
			@team.attributes = post_data

			if @team.save
				# Use to_json for now; we can filter it later.
				[201, @team.to_json]
			else
				[422, FReCon::ErrorFormatter.format(@team.errors.full_messages)]
			end
		end

		def self.update(request, params)
			return [400, "Must supply a team number!"] unless params[:number]

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
				return [422, FReCon::ErrorFormatter.format(e.message)]
			end

			@team = FReCon::Team.find_by number: params[:number]

			if @team.nil?
				return [404, FReCon::ErrorFormatter.format("Could not find team of number #{params[:number]}!")]
			end

			if @team.update_attributes(post_data)
				@team.to_json
			else
				[422, FReCon::ErrorFormatter.format(@team.errors.full_messages)]
			end
		end

		def self.delete(params)
			@team = Team.find_by number: params[:number]

			if @team
				if @team.destroy
					204
				else
					[422, FReCon::ErrorFormatter.format(@team.errors.full_messages)]
				end
			else
				[404, FReCon::ErrorFormatter.format("Could not find team of number #{params[:number]}!")]
			end
		end

		def self.show(params)
			@team = Team.find_by number: params[:number]

			if @team
				@team.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find team of number #{params[:number]}!")]
			end
		end

		def self.index(params)
			@teams = Team.all

			@teams.to_json
		end

		def self.records(params)
			@team = Team.find_by number: params[:number]

			if @team
				if params[:competition_id]
					@competition = Competition.find params[:competition_id]

					if @competition
						@team.records.where(match: @competition.matches).to_json
					else
						[404, FReCon::ErrorFormatter.format("Could not find competition of id #{params[:competition_id]}!")]
					end
				else
					@team.records.to_json
				end
			else
				[404, FReCon::ErrorFormatter.format("Could not find team of number #{params[:number]}!")]
			end
		end

		def self.matches(params)
			@team = Team.find_by number: params[:number]

			if @team
				@team.matches(params[:competition_id]).to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find team of number #{params[:number]}!")]
			end
		end

		def self.competitions(params)
			@team = Team.find_by number: params[:number]

			if @team
				@team.competitions.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find team of number #{params[:number]}!")]
			end
		end
	end
end
