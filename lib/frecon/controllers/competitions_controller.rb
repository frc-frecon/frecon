require "json"
require "frecon/models"

module FReCon
	class CompetitionsController < Controller
		def self.teams(params)
			show_attribute params, :teams
		end

		def self.matches(params)
			show_attribute params, :matches
		end

		def self.records(params)
			show_attribute params, :records
		end
	end
end
