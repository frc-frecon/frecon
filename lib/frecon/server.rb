require "sinatra"
require "frecon/routes"
require "frecon/controllers"

module FReCon
	class Server < Sinatra::Base
		include FReCon::Routes

		before do
			content_type "application/json"
		end

		def self.start
			FReCon::Database.setup(environment)
			run!
		end
	end
end
