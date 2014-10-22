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

		def self.run!
			Database.setup(FReCon.environment)

			super
		end

		def self.start
			run!
		end
	end
end
