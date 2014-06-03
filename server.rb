require "sinatra"
require "data_mapper"

require_relative "db"

Dir.glob("controllers/*.rb").each do |file|
	require_relative file
end

require_relative "routes"

