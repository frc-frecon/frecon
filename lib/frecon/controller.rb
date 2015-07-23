# lib/frecon/controller.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/base"

module FReCon
	class Controller
		def self.model_name
			# Removes the namespace "FReCon::" and "Controller" from
			# the class name, then singularizes the result.
			self.name.gsub(/FReCon::|Controller\Z/, "").singularize
		end

		def self.model
			# Removes the trailing "Controller" from the class name,
			# singularizes the result, and turns it into the class.
			self.name.gsub(/Controller\Z/, "").singularize.constantize
		end

		# Some models have to find themselves in special ways,
		# so this can be overridden with those ways.
		def self.find_model(params)
			model.find params[:id]
		end

		# The 404 error message.
		def self.could_not_find(value, attribute = "id", model = model_name.downcase)
			"Could not find #{model} of #{attribute} #{value}!"
		end

		def self.process_json_request(request)
			# Rewind the request body (an IO object)
			# in case someone else has already played
			# through it.
			request.body.rewind

			begin
				post_data = JSON.parse(request.body.read)
			rescue JSON::ParserError => e
				raise RequestError.new(400, e.message)
			end

			post_data
		end
		
		def self.create(request, params, post_data = nil)
			post_data ||= process_json_request request

			if post_data.is_an? Array
				results = post_data.map do |post_data_item|
					begin
						self.create(nil, nil, post_data_item)
					rescue RequestError => e
						e.return_value
					end
				end

				status_code = 201

				if(results.map do |result|
					   result.is_an?(Array) ? result[0] : 422
				   end.select do |status_code|
					   status_code != 201
				   end.count > 0)

					status_code = 422
				end

				[status_code, results.to_json]
			else
				@model = model.new
				@model.attributes = post_data

				if @model.save
					[201, @model.to_json]
				else
					raise RequestError.new(422, @model.errors.full_messages, {params: params, post_data: post_data})
				end
			end
		end

		def self.update(request, params, post_data = nil)
			raise RequestError.new(400, "Must supply a #{model_name.downcase} id!") unless params[:id]

			post_data ||= process_json_request request

			@model = find_model params

			raise RequestError.new(404, could_not_find(params[:id])) unless @model

			if @model.update_attributes(post_data)
				@model.to_json
			else
				raise RequestError.new(422, @model.errors.full_messages, {params: params, post_data: post_data})
			end
		end
		
		def self.delete(params)
			@model = find_model params

			if @model
				if @model.destroy
					204
				else
					raise RequestError.new(422, @model.errors.full_messages)
				end
			else
				raise RequestError.new(404, could_not_find(params[:id]), {params: params})
			end
		end
		
		def self.show(params)
			@model = find_model params

			if @model
				@model.to_json
			else
				raise RequestError.new(404, could_not_find(params[:id]), {params: params})
			end
		end

		def self.index(params)
			# jQuery (used client-side in WeBCa) sometimes includes a '_'
			# param in AJAX requests to try and get rid of exuberant caching.
			#
			# We delete this param because of problems it causes in the
			# database query (The primary problem is that models don't have
			# such an '_' attribute to begin with).
			params.delete("_")
			
			@models = params.empty? ? model.all : model.where(params)

			@models.to_json
		end

		def self.show_attribute(params, attribute)
			@model = find_model params

			if @model
				@model.send(attribute).to_json
			else
				raise RequestError.new(404, could_not_find(params[:id]), {params: params, attribute: attribute})
			end
		end

		def self.team_number_to_team_id(post_data)
			return post_data unless post_data.is_a?(Hash)

			if post_data["team_number"] && !post_data["team_id"]
				unless (team = Team.number post_data["team_number"]).nil?
					post_data["team_id"] = team.id

					post_data.delete("team_number")

					post_data
				else
					raise RequestError.new(404, could_not_find(post_data["team_number"], "number", "team"), {post_data: post_data})
				end
			end
		end

		# This supports match_number and competition_name
		# or match_number and competition (which is a Hash).
		def self.match_number_and_competition_to_match_id(post_data)
			return post_data unless post_data.is_a?(Hash)

			if post_data["match_number"] && !post_data["match_id"]
				if post_data["competition_name"] && (competition = Competition.find_by name: post_data["competition_name"])
					# Try to set the match to the already existing match.
					begin
						match = competition.matches.find_by number: post_data["match_number"]
					rescue ArgumentError, TypeError => e
						raise RequestError.new(422, e.message, {post_data: post_data})
					end

					# Create the match if necessary.
					begin
						match ||= Match.create(number: post_data["match_number"], competition_id: competition.id)
					rescue ArgumentError, TypeError => e
						raise RequestError.new(422, e.message, {post_data: post_data, competition_id: competition.id})
					end

					post_data["match_id"] = match.id

					post_data.delete("match_number")
					post_data.delete("competition_name")

					post_data
				elsif post_data["competition"] && post_data["competition"]["_id"] && (competition = Competition.find_by(id: post_data["competition"]["_id"]))
					# Try to set the match to the already existing match.
					match = competition.matches.find_by number: post_data["match_number"]

					# Create the match if necessary.
					begin
						match ||= Match.create(number: post_data["match_number"], competition_id: competition.id)
					rescue ArgumentError, TypeError => e
						raise RequestError.new(422, e.message, {post_data: post_data, competition_id: competition.id})
					end

					post_data["match_id"] = match.id

					post_data.delete("match_number")
					post_data.delete("competition")

					post_data
				else
					raise RequestError.new(422, "A current competition is not set.  Please set it.", {post_data: post_data})
				end
			end
		end
	end
end
