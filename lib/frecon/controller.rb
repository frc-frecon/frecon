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
	# Public: A base class to represent a controller.
	class Controller
		# Public: Converts the class's name to a Model name.
		#
		# Returns a Symbol that is the Model name.
		def self.model_name
			# Removes the namespace "FReCon::" and "Controller" from
			# the class name, then singularizes the result.
			self.name.gsub(/FReCon::|Controller\Z/, "").singularize
		end

		# Public: Converts the class's name to a Model.
		#
		# Returns the Model's class.
		def self.model
			# Removes the trailing "Controller" from the class name,
			# singularizes the result, and turns it into the class.
			self.name.gsub(/Controller\Z/, "").singularize.constantize
		end

		# Public: Find a model.
		#
		# params - A Hash containing the parameters.  This should contain an
		#          'id' key, which is deleted and used for the find.
		#
		# Returns either the found model value or nil.
		def self.find_model(params)
			model.find params.delete("id")
		end

		# Public: Generate a could-not-find message.
		#
		# value     - The value that was tested.
		# attribute - The attribute that was used for the search.
		# model     - The model that the search was performed upon.
		#
		# Returns a String containing the error message.
		def self.could_not_find(value, attribute = "id", model = model_name.downcase)
			"Could not find #{model} of #{attribute} #{value}!"
		end

		# Public: Process a JSON request.
		#
		# request - The internal Sinatra request object that is available to
		#           request handling.
		#
		# Returns a Hash corresponding to the request's body.
		# Raises a RequestError if the JSON parse fails.
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

		# Public: Process a creation request (HTTP POST)
		#
		# If `post_data` is an Array, iterates through the array and calls itself
		# with each element within.  Otherwise, performs the creation using
		# the attribute key-value pairings within the `post_data`.
		#
		# request   - The internal Sinatra request object that is available to
		#             request handling.
		# params    - The internal params Hash that is available to request
		#             handling.
		# post_data - The data that was sent in the request body.
		#
		# Returns an Array, a formatted response that can be passed back through
		#   Sinatra's request processing.
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

		# Public: Process an update request (HTTP PUT)
		#
		# Processes the JSON request, finds the model, then updates it.
		#
		# request   - The internal Sinatra request object that is available to
		#             request handling.
		# params    - The internal params Hash that is available to request
		#             handling.
		# post_data - The data that was sent in the request body.
		#
		# Returns a String with the JSON representation of the model.
		# Raises a RequestError if the request is malformed or if the attributes
		#   can't be updated.
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
			if params.empty?
				@models = model.all
			else
				params.delete("splat")
				params.delete("captures")

				@models = model.all.psv_filter(params)
			end

			@models.to_json
		end
	end
end
