# lib/frecon/database.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "logger"

require "frecon/base/variables"

require "mongoid"
require "frecon/mongoid/criteria"

require "tempfile"
require "yaml"

require "frecon/models"

module FReCon
	# Public: A system to set up the database.
	class Database
		# Public: Set up the database.
		def self.setup!
			Mongoid.load!(File.join(File.dirname(__FILE__), "mongoid.yml"), FReCon::ENVIRONMENT.variable)

			if FReCon::ENVIRONMENT.console["level"]
				Mongoid.logger.level = Logger::DEBUG
				Mongoid.logger = Logger.new($stdout)

				Moped.logger.level = Logger::DEBUG
				Moped.logger = Logger.new($stdout)
			end
		end
	end
end
