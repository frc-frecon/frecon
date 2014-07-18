require "sinatra/base"
require "frecon/db"
require "frecon/routes"
require "frecon/controllers"

module FReCon
	class Server < Sinatra::Base
		include FReCon::Routes

		configure do
			FReCon::Database.setup(:development)
		end

		before do
			content_type "application/json"
		end

		def self.start
			run!
		end
	end
end
