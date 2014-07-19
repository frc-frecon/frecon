require "json"
require "frecon/models"

module FReCon
	class MatchesController < Controller
		def self.competition(params)
			@match = Match.find params[:id]

			if @match
				@match.competition.to_json
			else
				[404, ErrorFormatter.format(could_not_find(params[:id]))]
			end
		end

		def self.records(params)
			@match = Match.find params[:id]

			if @match
				@match.records.to_json
			else
				[404, ErrorFormatter.format(could_not_find(params[:id]))]
			end
		end
	end
end
