# lib/frecon/request_error.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

class RequestError < StandardError
	attr_reader :code
	attr_reader :message

	def initialize(code, message = nil)
		@code = code
		@message = message
	end
end
