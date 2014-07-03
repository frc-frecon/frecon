require "json"

class TeamController
	def self.show(params)
		@team = Team.where(number: params[:number]).to_a.last

		raise Sinatra::NotFound unless @team

		case params[:format]
		when "json"
			return @team.values.to_json
		end
	end

	def self.index(params)
		@teams = Team.all

		case params[:format]
		when "json"
			return @teams.to_a.map{|team| team.values}.to_json
		end
	end
end
