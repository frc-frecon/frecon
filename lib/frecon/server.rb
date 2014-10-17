require "sinatra/base"

require "frecon/database"
require "frecon/routes"
require "frecon/controllers"

module FReCon
	class Server < Sinatra::Base
		include Routes

		configure do
			Database.setup
		end

		before do
			content_type "application/json"
		end

		def self.start(environment = ENVIRONMENT)
			run!(environment)
		end
	end
end
