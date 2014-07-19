require "json"
require "frecon/models"

module FReCon
	class CompetitionsController < Controller
		def self.teams(params)
			@competition = Competition.find params[:id]

			if @competition
				@competition.teams.to_json
			else
				[404, ErrorFormatter.format(could_not_find(params[:id]))]
			end
		end

		def self.matches(params)
			@competition = Competition.find params[:id]

			if @competition
				@competition.matches.to_json
			else
				[404, ErrorFormatter.format(could_not_find(params[:id]))]
			end
		end

		def self.records(params)
			@competition = Competition.find params[:id]

			if @competition
				@competition.records.to_json
			else
				[404, ErrorFormatter.format(could_not_find(params[:id]))]
			end
		end
	end
end
