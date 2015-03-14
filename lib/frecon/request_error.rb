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
	attr_reader :body

	def initialize(code, message = nil, context = "No context provided!")
		@code = code
		@message = message
		@context = context

		# If @message is a String or an Array,
		# generate a JSON string for the body and
		# store it in the @body variable.
		#
		# Notice that if @message is nil, neither
		# of these is tripped, so @body becomes nil.
		# This means that #return_value will instead
		# return just @code, which is similar to the
		# previous behavior.
		@body = case @message
		when String
			JSON.generate({ context: @context, errors: [ @message ] })
		when Array
			JSON.generate({ context: @context, errors: @message })
		end
	end

	# A Sinatra-compliant return value.
	def return_value
		if @body
			[@code, @body]
		else
			@code
		end
	end
end
