class TeamController
	def self.show(params)
		@team = Team.get(params[:number])

		raise Sinatra::NotFound unless @team

		case params[:format]
		when "json"
			return @team.to_json
		end
	end

	def self.index(params)
		@teams = Team.all

		case params[:format]
		when "json"
			return @teams.to_json
		end
	end
end
