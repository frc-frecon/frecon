# lib/frecon/request_error.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "json"

class RequestError < StandardError
	attr_reader :code
	attr_reader :message

	def initialize(code, message = nil)
		@code = code
		@message = format_error_message(message)
	end

	def format_error_message(message)
		case message
		when String
			JSON.generate({ errors: [ message ] })
		when Array
			JSON.generate({ errors: message })
		end
	end

	# A Sinatra-compliant return value.
	def return_value
		if @message
			[@code, @message]
		else
			@code
		end
	end
end
