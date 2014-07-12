require "sinatra"

module FReCon
	module Server
		# Starts the server.
		def start
			Dir.glob("controllers/*.rb").each do |file|
				require_relative file
			end

			require_relative "routes"
		end
	end
end
