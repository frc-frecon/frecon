# lib/frecon/scraper.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "httparty"

module FReCon
	# The default scraper scrapes other FReCon instances.
	# To scrape a different source, a descendant scraper should be used.
	class Scraper
		def initialize(base_uri)
			@base_uri = base_uri
		end

		# Reads and imports a data string.
		# Determines what to do with information in the `context` hash.
		def read(data, context = {})
			# `data` will be a string, so we need to convert it from JSON.
			data = JSON.parse(data)

			# Here we want `context` to tell us what model we are making.
			if context[:model]
				context[:model].controller.create(nil, nil, data).first
			else
				# Therefore, we must be dealing with a dump.
				statuses = data.map do |key, value|
					unless value.empty?
						model = ("FReCon::" + key.singularize.capitalize).constantize
						model.controller.create(nil, nil, value).first
					end
				end
				statuses.delete(nil)
				statuses
			end
		end

		# If no arguments are passed, will import the whole other database.
		# If only one argument is passed, will import all of that model.
		# If two arguments are passed, will import the models that match
		# the query params.
		def get(model = nil, query = {})
			# Turns something like "team" into Team.
			model = ("FReCon::" + model.capitalize).constantize if model.is_a?(String)

			# The route name for the model branch.
			route_name = model.name.gsub(/FReCon::/, "").downcase.pluralize if model
			
			if !model && query.empty?
				data = HTTParty.get(@base_uri + "/dump")
			elsif model && query.empty?
				data = HTTParty.get(@base_uri + "/#{route_name}")
			else
				data = HTTParty.get(@base_uri + "/#{route_name}", { query: query })
			end

			read data, model: model
		end
	end
end
