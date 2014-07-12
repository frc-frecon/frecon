require "sinatra"

require_relative "db"

Dir.glob("controllers/*.rb").each do |file|
	require_relative file
end

require_relative "routes"
