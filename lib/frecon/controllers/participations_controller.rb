module FReCon
	class ParticipationsController < Controller
		def self.create(request, params)
			post_data = process_request request
			return post_data if post_data.is_an?(Array)
			
			# Convert team number to team_id.
			if post_data["team_number"]
				unless (team = Team.number post_data["team_number"]).nil?
					post_data["team_id"] = team.id

					post_data.delete("team_number")
				else
					return [404, ErrorFormatter.format(could_not_find(post_data["team_number"], "number", "team"))]
				end
			end

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
