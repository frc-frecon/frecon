# lib/frecon/server.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "sinatra/base"

require "frecon/base/variables"
require "frecon/configuration"
require "frecon/database"
require "frecon/routes"
require "frecon/controllers"

module FReCon
	# Public: The Sinatra web server.
	class Server < Sinatra::Base
		include Routes

		before do
			content_type "application/json"
		end

		# Public: Start the Server.
		#
		# keyword_arguments - The Hash of arguments to use.
		#                     :configuration - The Configuration to use when
		#                                      setting up the server.
		#
		# Returns the result of starting the server.
		def self.start(**keyword_arguments)
			run!(**keyword_arguments)
		end

		protected

		# Internal: Set up the server.
		#
		# Sets the various Thin and Sinatra options, and sets up the database.
		#
		# :configuration - The Configuration to use when starting the server.
		#
		# Returns the result of setting up the database.
		def self.setup!(configuration: Configuration.construct!)
			set :server, %w[thin HTTP webrick]
			set :bind, configuration["frecon"]["server"]["host"]
			set :port, configuration["frecon"]["server"]["port"]
			set :environment, configuration["frecon"]["server"]["environment"]

			mongoid = configuration["frecon"]["database"]["mongoid"]

			Database.setup(environment: environment, mongoid: mongoid)
		end

		def self.run!(**keyword_arguments)
			setup!(**keyword_arguments)

			super
		end
	end
end
