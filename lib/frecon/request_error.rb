# lib/frecon/request_error.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "json"

# Public: A class representing errors that emanate from request handling.
class RequestError < StandardError
	# Public: The Array or Integer representing what can be returned from the
	# request handler.
	attr_reader :return_value

	# Public: Initialize a RequestError.
	#
	# code    - An Integer representing the HTTP status code.
	# message - A String representing the error message.
	# context - An Object containing any necessary debugging values.
	def initialize(code, message = nil, context = nil)
		@code = code
		@message = message
		@context = context

		# When @message is a String or an Array,
		# the return_value is set to a Sinatra-compliant
		# Array with @code being the first element and the
		# response body being the stringification of the
		# JSON stringification of @context and @message.
		#
		# If @message is a String, it is first put into an
		# array.
		#
		# If @message is neither a String nor an Array,
		# @return_value becomes simply @code.
		@return_value =
			case @message
			when String
				[@code, JSON.generate({ context: @context, errors: [ @message ] })]
			when Array
				[@code, JSON.generate({ context: @context, errors: @message })]
			else
				@code
			end
	end
end
