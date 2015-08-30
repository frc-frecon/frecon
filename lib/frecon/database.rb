# lib/frecon/database.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "logger"

require "mongoid"
require "frecon/mongoid/criteria"

require "tempfile"
require "yaml"

require "frecon/models"

module FReCon
	# Public: A system to set up the database.
	class Database
		# Public: Set up the database.
		#
		# environment - Symbol containing environment to start the database in.
		# mongoid     - Hash containing the configuration for Mongoid. If not
		#               present, the lib/frecon/mongoid.yml file is given to
		#               Mongoid.load!.  If present, the Hash is dumped to a
		#               tempfile which is given to Mongoid.load!.
		def self.setup(environment = FReCon.environment, mongoid = nil)
			if mongoid.is_a?(Hash)
				mongoid_tempfile = Tempfile.new("FReCon")

				mongoid_tempfile.write(mongoid.to_h.to_yaml)
				mongoid_tempfile.rewind

				Mongoid.load!(mongoid_tempfile.path, environment)
			else
				Mongoid.load!(File.join(File.dirname(__FILE__), "mongoid.yml"), environment)
			end

			if environment == :development
				Mongoid.logger.level = Logger::DEBUG
				Mongoid.logger = Logger.new($stdout)

				Moped.logger.level = Logger::DEBUG
				Moped.logger = Logger.new($stdout)
			end
		end
	end
end
