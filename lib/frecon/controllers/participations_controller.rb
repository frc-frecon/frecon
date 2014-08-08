module FReCon
	class ParticipationsController < Controller
		def self.competition(params)
			show_attribute params, :competition
		end
		
		def self.team(params)
			show_attribute params, :team
		end
	end
end
