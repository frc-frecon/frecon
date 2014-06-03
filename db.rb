DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'sqlite:database.db')

# load models
Dir.glob("models/*.rb").each do |file|
	require_relative file
end

DataMapper.finalize

# Update the DB to match the current schema as defined in the models
DataMapper.auto_upgrade!
