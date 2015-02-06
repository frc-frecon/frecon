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

require "tempfile"
require "yaml"

require "frecon/models"

module FReCon
	class Database
		def self.setup(environment, mongoid_hash = nil)
			if mongoid_hash.is_a?(Hash)
				mongoid_tempfile = Tempfile.new("FReCon")
				mongoid_tempfile.write(mongoid_hash.to_yaml)
				mongoid_tempfile.rewind

				Mongoid.load!(mongoid_tempfile.path, environment)
			else
				Mongoid.load!(File.join(File.dirname(__FILE__), "mongoid.yml"), environment)
			end
		end
	end
end
