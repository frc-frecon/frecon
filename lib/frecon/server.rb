require "sinatra/base"

require "frecon/database"
require "frecon/routes"
require "frecon/controllers"

module FReCon
	class Server < Sinatra::Base
		include Routes

		before do
			content_type "application/json"
		end

		def self.start(environment = ENVIRONMENT)
			Database.setup environment
			
			run!
		end
	end
end
