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

		# The 404 error message.
		def self.could_not_find(value, attribute = "id", model = model_name.downcase)
			"Could not find #{model_name.downcase} of #{attribute} #{value}!"
		end

		# Processes a POST/PUT request and returns the post data.
		def self.process_request(request)
			# Rewind the request body (an IO object)
			# in case someone else has already played
			# through it.
			request.body.rewind

			begin
				# Parse the POST data as a JSON hash
				# (because that's what it is)
				post_data = JSON.parse(request.body.read)
			rescue JSON::ParserError => e
				# If we have malformed JSON (JSON::ParserError is
				# raised), escape out of the function.
				raise RequestError.new(400, e.message)
			end

			raise RequestError.new(422, "Must pass a JSON object!") if post_data.is_an?(Array)
			post_data
		end

		def self.create(request, params, post_data = nil)
			post_data ||= process_request request

			@model = model.new
			@model.attributes = post_data

			if @model.save
				[201, @model.to_json]
			else
				raise RequestError.new(422, @model.errors.full_messages)
			end
		end

		def self.update(request, params)
			raise RequestError.new(400, "Must supply a #{model_name.downcase}!") unless params[:id]

			post_data = process_request request

			@model = model.find params[:id]

			raise RequestError.new(404, could_not_find(params[:id])) unless @model

			if @model.update_attributes(post_data)
				@model.to_json
			else
				raise RequestError.new(422, @model.errors.full_messages)
			end
		end

		def self.delete(params)
			@model = model.find params[:id]

			if @model
				if @model.destroy
					204
				else
					raise RequestError.new(422, @model.errors.full_messages)
				end
			else
				raise RequestError.new(404, could_not_find(params[:id]))
			end
		end

		def self.show(params)
			@model = model.find params[:id]

			if @model
				@model.to_json
			else
				raise RequestError.new(404, could_not_find(params[:id]))
			end
		end

		def self.index(params)
			params.delete("_")

			@models = params.empty? ? model.all : model.where(params)

			@models.to_json
		end

		def self.show_attribute(params, attribute)
			@model = model.find params[:id]

			if @model
				@model.send(attribute).to_json
			else
				raise RequestError.new(404, could_not_find(params[:id]))
			end
		end

		def self.team_number_to_team_id(post_data)
			if post_data["team_number"] && !post_data["team_id"]
				unless (team = Team.number post_data["team_number"]).nil?
					post_data["team_id"] = team.id

					post_data.delete("team_number")

					post_data
				else
					raise RequestError.new(404, could_not_find(post_data["team_number"], "number", "team"))
				end
			end
		end
	end
end
