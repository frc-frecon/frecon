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

require "frecon/models"

module FReCon
	class Database
		def self.setup(environment)
			Mongoid.load!(File.join(File.dirname(__FILE__), "mongoid.yml"), environment)
			
			Mongoid.logger.level = Logger::DEBUG
			Mongoid.logger = Logger.new($stdout)

			Moped.logger.level = Logger::DEBUG
			Moped.logger = Logger.new($stdout)
		end
	end
end
