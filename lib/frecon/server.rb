require "sinatra/base"
require "frecon/db"
require "frecon/routes"
require "frecon/controllers"

module FReCon
	class Server < Sinatra::Base
		include Routes

		configure do
			Database.setup(:development)
		end

		before do
			content_type "application/json"
		end

		def self.start
			run!
		end
	end
end
