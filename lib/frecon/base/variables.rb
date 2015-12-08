# lib/frecon/base/variables.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/base/environment"

# Public: The FReCon API module.
module FReCon
	# Public: A String representing the current version of FReCon.
	VERSION = "1.3.2"

	# Public: An Environment representing the system execution environment.
	ENVIRONMENT = Environment.new(:development)
end
