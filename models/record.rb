class Record
	include DataMapper::Resource

	property :id,     Serial
	property :notes,  Text
	# we wrote down position:string, but I think this works better
	property :position, Enum[:r1, :r2, :r3, :b1, :b2, :b3]
	# Do we want these or not?
	# property :created_at, DateTime 
	# property :updated_at, DateTime 

	belongs_to :team
	belongs_to :match
end
