require "sequel"

class Record < Sequel::Model
	plugin :enum

	Serial :id
	Text :notes

	# we wrote down position:string, but I think this works better
	enum :position, [:r1, :r2, :r3, :b1, :b2, :b3]

	DateTime :created_at
	DateTime :updated_at
end
