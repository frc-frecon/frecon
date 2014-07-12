require "sinatra"
require_relative "routes"

Dir.glob(File.join(File.dirname(__FILE__), "controllers/*.rb")).each do |file|
	require_relative file
end

module FReCon
	class Server < Sinatra::Base
		include FReCon::Routes

		class << self
			alias_method :start, :run!
		end
	end
end
