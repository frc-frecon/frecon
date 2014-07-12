require "sinatra"
require_relative "routes"

module FReCon
	class Server < Sinatra::Base
		include Routes
		Dir.glob("controllers/*.rb").each do |file|
			require_relative file
		end
	end
end
