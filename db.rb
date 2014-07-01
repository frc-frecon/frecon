require "logger"
require "sequel"

# Load the migration extension so we can do stuff with migrations.
Sequel.extension :migration

# This variable is global across all files and is accessible by the entire API.
$db = Sequel.connect("sqlite://database/database.db", :logger => Logger.new("log/db.log"))

# If we have any outstanding migrations that have not been applied yet,
unless Sequel::Migrator.is_current?($db, "database/migrations")
	# Print out a warning.
	warn "Warning: Outstanding migrations present, attempting to run them."

	# Run them.
	Sequel::Migrator.run($db, "database/migrations")
end

Dir.glob("models/*.rb").each do |file|
	require_relative file
end
