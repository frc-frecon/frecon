require "logger"
require "sequel"

# This variable is global across all files and is accessible by the entire API.
$db = Sequel.connect("sqlite://database/database.db", :logger => Logger.new("log/db.log"))

Dir.glob("models/*.rb").each do |file|
	require_relative file
end
