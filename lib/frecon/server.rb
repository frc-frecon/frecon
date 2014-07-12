require "sinatra"
require_relative "routes"

Dir.glob("controllers/*.rb").each do |file|
	require_relative file
end

module FReCon
	class Server < Sinatra::Base
		include FReCon::Routes
	end
end
