require "json"
require "frecon/models/robot"

module FReCon
	class RobotsController < Controller
		def self.competition(params)
			show_attribute params, :competition
		end

		def self.team(params)
			show_attribute params, :team
		end
	end
end
