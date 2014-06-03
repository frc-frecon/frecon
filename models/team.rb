class Team
	include DataMapper::Resource

	property :number,     Integer, key: true
	property :name,       String
	# Do we want these or not?
	# property :created_at, DateTime 
	# property :updated_at, DateTime

	has n, :records
	has n, :matches, through: :records
end
