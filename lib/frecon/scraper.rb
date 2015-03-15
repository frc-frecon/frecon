# lib/frecon/scraper.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

module FReCon
	# The default scraper scrapes other FReCon instances.
	# To scrape a different source, a descendant scraper should be used.
	class Scraper
		def initialize(base_url)
			@base_url = base_url
		end

		# Reads and imports a data string.
		# Determines what to do with information in the `context` hash.
		def read(data, context = {})
			# `data` will be a string, so we need to convert it from JSON.
			data = JSON.parse(data)
			
			# Here we want `context` to tell us what model we are making.
			if context[:model]
				context[:model].controller.create nil, nil, data
			else
				# Therefore, we must be dealing with a dump.
				data.each do |key, value|
					model = ("FReCon::" + key.singularize.capitalize).constantize
					model.controller.create nil, nil, value
				end
			end
		end

		# If no arguments are passed, will import the whole other database.
		# If only one argument is passed, will import all of that model.
		# If two arguments are passed, will import the models that match
		# the query params.
		def get(model = nil, query = {})
			# Turns something like "team" into Team.
			model = ("FReCon::" + model.capitalize).constantize if model.is_a?(String)
			
			if !model && query.empty?
				
			elsif model && query.empty?
				
			else
				
			end

			read data, model: model
		end
	end
end