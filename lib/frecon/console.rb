# lib/frecon/console.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/base/variables"
require "frecon/database"
require "frecon/server"

module FReCon
	class Console
		def self.start(environment: FReCon.environment)
			Database.setup(environment)

			require "pry"

			FReCon.pry
		end
	end
end
