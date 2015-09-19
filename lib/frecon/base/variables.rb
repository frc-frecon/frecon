# lib/frecon/base/variables.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

# Public: The FReCon API module.
module FReCon
	# Public: A String representing the current version of FReCon.
	VERSION = "1.1.0"

	@environment_variable = :development

	# Public: Returns the current environment.
	def self.environment
		@environment_variable
	end

	# Public: Sets the environment.
	#
	# arg - The new environment.
	#
	# Returns the result from setting the current environment.
	def self.environment=(arg)
		@environment_variable = arg
	end
end
