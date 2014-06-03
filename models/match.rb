class Match
	include DataMapper::Resource

	property :number,         Integer, key: true
	property :classification, String
	property :red_score,      Integer
	property :blue_score,     Integer
	# Do we want these or not?
	# property :created_at, DateTime 
	# property :updated_at, DateTime

	has n, :records
	has n, :teams, through: :records
end
