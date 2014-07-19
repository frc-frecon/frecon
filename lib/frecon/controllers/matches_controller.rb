require "json"
require "frecon/models"

module FReCon
	class MatchesController < Controller
		def self.competition(params)
			show_attribute params, :competition
		end

		def self.records(params)
			show_attribute params, :records
		end
	end
end
