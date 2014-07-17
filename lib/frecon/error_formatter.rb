require "json"

module FReCon
	class ErrorFormatter
		def self.format(message)
			case message
			when String
				JSON.generate({ errors: [ message ] })
			when Array
				JSON.generate({ errors: message })
			end
		end
	end
end
