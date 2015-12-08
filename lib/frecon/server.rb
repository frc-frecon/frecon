# lib/frecon/server.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'sinatra/base'

require 'frecon/base/variables'
require 'frecon/database'
require 'frecon/routes'
require 'frecon/controllers'

module FReCon
	# Public: The Sinatra web server.
	class Server < Sinatra::Base
		include Routes

		before do
			content_type 'application/json'
		end

		# Public: Start the Server.
		#
		# Returns the result of starting the server.
		def self.start(*arguments)
			run!(*arguments)
		end

		protected

		# Internal: Set up the server.
		#
		# Sets various Thin and Sinatra options, and sets up the database.
		#
		# Returns the result of setting up the database.
		def self.setup!
			# Set the Thin and Sinatra options.
			set :server, %w[thin HTTP webrick]
			set :bind, FReCon::ENVIRONMENT.server['host']
			set :port, FReCon::ENVIRONMENT.server['port']
			set :environment, FReCon::ENVIRONMENT.variable.to_s

			# Set up the database.
			Database.setup!
		end

		# Internal: Set up the server and start it.
		def self.run!(*arguments)
			setup!(*arguments)

			super
		end
	end
end
