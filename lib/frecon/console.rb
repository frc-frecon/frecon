# lib/frecon/console.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'frecon/database'
require 'frecon'

module FReCon
	# Public: The wrapper system for a pry console.
	class Console
		# Public: Starts the FReCon console.
		#
		# Returns the result of running pry on FReCon.
		def self.start
			Database.setup!

			require 'pry'

			FReCon.pry
		end
	end
end
