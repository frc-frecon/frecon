module FReCon
	class ParticipationsController < Controller
		def self.create(request, params)
			post_data = process_request request
			return post_data if post_data.is_an?(Array)
			
			# Convert team number to team_id.
			post_data = team_number_to_team_id(post_data)

			@model = model.new
			@model.attributes = post_data

			if @model.save
				[201, @model.to_json]
			else
				[422, ErrorFormatter.format(@model.errors.full_messages)]
			end
		end
		
		def self.competition(params)
			show_attribute params, :competition
		end
		
		def self.team(params)
			show_attribute params, :team
		end
	end
end
