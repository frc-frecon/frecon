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
require "frecon/database"
require "frecon/routes"
require "frecon/controllers"

module FReCon
	class Server < Sinatra::Base
		include Routes

		before do
			content_type "application/json"
		end

		def self.start(**keyword_arguments)
			run!(**keyword_arguments)
		end

		protected

		def self.setup!(server: %w[thin HTTP webrick], host: "localhost", port: 4567, environment: FReCon.environment)
			set :server, server
			set :bind, host
			set :port, port
			set :environment, environment

			Database.setup(settings.environment)
		end

		def self.run!(**keyword_arguments)
			setup!(**keyword_arguments)

			super
		end
	end
end
