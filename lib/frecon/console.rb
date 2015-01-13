# lib/frecon/console.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/database"
require "frecon/server"

module FReCon
	class Console
		def self.start
			Database.setup(FReCon.environment)

			# Use pry if it is installed.
			# Use the context of the FReCon module;
			# this allows for writing "Team" instead of "FReCon::Team".
			begin
				require "pry"

				FReCon.pry
			rescue LoadError
				require "irb"

				IRB.setup nil
				IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context

				require "irb/ext/multi-irb"

				IRB.irb nil, FReCon
			end
		end
	end
end
