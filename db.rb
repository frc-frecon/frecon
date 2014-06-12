require "logger"
require "sequel"

# This variable is global across all files and is accessible by the entire API.
$db = Sequel.connect("sqlite://database.db", :logger => Logger.new("log/db.log"))

Dir.glob("models/*.rb").each do |file|
	require_relative file
end

# DataMapper.finalize

# # Update the DB to match the current schema as defined in the models
# DataMapper.auto_upgrade!
