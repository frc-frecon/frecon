# lib/frecon/base/variables.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

module FReCon
	VERSION = "0.2.1"

	@environment_variable = :development

	def self.environment
		@environment_variable
	end

	def self.environment=(arg)
		@environment_variable = arg
	end
end
