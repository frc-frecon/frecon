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
			
		end

		# If no arguments are passed, will import the whole other database.
		# If only one argument is passed, will import all of that model.
		# If two arguments are passed, will import the models that match
		# the query params.
		def get(model = nil, query = {})
			
		end
	end
end
